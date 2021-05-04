//
//  VizualizationManager.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-28.
//

import Foundation
import MapKit

struct VisualizationManager {
    
    var chart: Chart = Chart(type: .scatterplot)
    var dataset: Dataset? = nil {
        didSet {
            updateSelected()
        }
    }
    
    var allDatasets = DatasetStorage.shared.datasets.value
    var selectedChartType: Chart.ChartType = .scatterplot {
        didSet {
            self.chart = Chart(type: selectedChartType)
        }
    }
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
    
    var locationCoordinates: [Location] {
        var locations: [Location] = []
        var seenRowIds: [UUID] = []
        
        let continuous = ContinuousDataPointStorage.shared.continuousDataPoints.value.filter {$0.variable?.dataset == self.dataset}
        let categorical = CategoricalDataPointStorage.shared.categoricalDataPoints.value.filter {$0.variable?.dataset == self.dataset}
        
        for variable in continuous {
            
            if !seenRowIds.contains(variable.rowId!) {
                let coordinate = CLLocationCoordinate2D(latitude: variable.latitude, longitude: variable.longitude)
                let location = Location(coordinate: coordinate)
                locations.append(location)
            } else {
                seenRowIds.append(variable.rowId!)
            }
        }
        
        for variable in categorical {
            if !seenRowIds.contains(variable.rowId!) {
                let coordinate = CLLocationCoordinate2D(latitude: variable.latitude, longitude: variable.longitude)
                let location = Location(coordinate: coordinate)
                locations.append(location)
            } else {
                seenRowIds.append(variable.rowId!)
            }
        }
        
        return locations
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
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    }
    
}
