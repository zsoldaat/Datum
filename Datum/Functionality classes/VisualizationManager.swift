//
//  VizualizationManager.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-28.
//

import Foundation
import MapKit

struct VisualizationManager {
    
    var chart: Chart = Chart(type: .calendarView)
    var dataset: Dataset? = nil {
        didSet {
            updateSelected()
        }
    }
    
    var allDatasets = DatasetStorage.shared.datasets.value
    var selectedContinuous = [ContinuousVariable]()
    var selectedCategorical = [CategoricalVariable]()
    
    mutating func selectVariable<T: Variable>(_ variable: T) {
        if variable.self is ContinuousVariable {
            let continuous = variable as! ContinuousVariable
            continuous.isSelected.toggle()
        } else {
            let categorical = variable as! CategoricalVariable
            categorical.isSelected.toggle()
        }
        updateSelected()
    }
    
    mutating func updateSelected() {
        selectedContinuous = dataset!.continuousArray.filter {$0.isSelected == true}
        selectedCategorical = dataset!.categoricalArray.filter {$0.isSelected == true}
    }
    
    var correctNumberOfVarsSelected: Bool {
        let correctContinuous = selectedContinuous.count == chart.continuousVariablesRequired
        let correctCategorical = selectedCategorical.count == chart.categoricalVariablesRequired
        
        return correctContinuous && correctCategorical
    }
    
    var hasVariablesSelected: Bool {
        selectedContinuous.count > 0 || selectedCategorical.count > 0
    }
    
    //MARK: - MapView Variables
    
    var locationCoordinates: [Location] {
        
        var locationDict: [UUID: Location] = [:]
        
        let continuous = ContinuousDataPointStorage.shared.continuousDataPoints.value.filter {$0.variable?.dataset == self.dataset}
        let categorical = CategoricalDataPointStorage.shared.categoricalDataPoints.value.filter {$0.variable?.dataset == self.dataset}
        
        for datapoint in continuous {
            let rowId = datapoint.rowId!
            
            if !locationDict.keys.contains(rowId) {
                locationDict[rowId] = Location(coordinate: CLLocationCoordinate2D(latitude: datapoint.latitude, longitude: datapoint.longitude))
            }
            
            locationDict[rowId]?.continuousData.append(datapoint)
        }
        
        for datapoint in categorical {
            
            let rowId = datapoint.rowId!
            
            if !locationDict.keys.contains(rowId) {
                locationDict[rowId] = Location(coordinate: CLLocationCoordinate2D(latitude: datapoint.latitude, longitude: datapoint.longitude))
            }
            
            locationDict[rowId]?.categoricalData.append(datapoint)
        }
        
        return Array(locationDict.values)
    }
    
    var centerLocation: Location {
        var longitude: Double = 0
        var latitude: Double = 0
        
        for location in locationCoordinates {
            latitude += location.coordinate.latitude
            longitude += location.coordinate.longitude
        }
        
        latitude = latitude/Double(locationCoordinates.count)
        longitude = longitude/Double(locationCoordinates.count)
        
        return Location(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        
    }
    
    var mapRegion: MKCoordinateRegion {
        MKCoordinateRegion(
            center: centerLocation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
        )
    }
    
    //MARK: - CalendarView Variables
    
    var averageValuesByDate: [DateComponents: Double] {
        
        guard let variable = selectedContinuous.first else {return [:]}
        
        let valuesSetForDates = Dictionary(grouping: variable.valuesArray, by: {$0.date!.getComponents(.day, .month, .year)})
        
        for key in valuesSetForDates.keys {
            print(key)
            for value in valuesSetForDates[key]! {
                print(value.value)
            }
        }
        
        //Apparently explicitly declaring a type here is necessary so don't change it
        var valuesForDates: [DateComponents:Double] = valuesSetForDates.mapValues { datapoints in
            
            var total: Double = 0
            
            for datapoint in datapoints {
                total += datapoint.value
            }
            
            let average = total/Double(datapoints.count)
            return average
            
        }
        
        let maxValue = valuesForDates.values.max()! as Double
        
        valuesForDates = valuesForDates.mapValues { value in
            value/maxValue
        }
        
        
        return valuesForDates
    }
    
    //This code should eventully live here, or in the CalendarView VM, but it does not currently live here
//    func getGradient(value: CGFloat) -> UIColor {
//
//        let colors: [UIColor] = [.white, .red]
//
//        return colors.intermediate(percentage: value)
//    }

}
