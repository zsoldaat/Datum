//
//  ExampleData.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-11.
//

import Foundation
import MapKit

class ExampleData {
    
    static let context = PersistenceController.shared.container.viewContext
    
    static var rowID = UUID()
    
    static var exampleDataset: Dataset {
        
        let dataset = Dataset(context: context)
        dataset.id = UUID()
        dataset.name = "Example"
        dataset.date = Date()
        
        return dataset

    }
    
    static var exampleCategoricalVariable: CategoricalVariable {
        
        let variable = CategoricalVariable(context: context)
        variable.id = UUID()
        variable.name = "Example"
        
        let category1 = Category(context: context)
        category1.id = UUID()
        category1.name = "First Category"
        category1.variable = variable
        
        for _ in 1...3 {
            let value = CategoricalDataPoint(context: context)
            value.id = UUID()
            value.date = Date()
            value.category = category1
            value.variable = variable
            value.latitude = (LocationFetcher.shared.lastKnownLocation?.latitude ?? 49.284154) + Double.random(in: -0.009...0.009)
            value.longitude = (LocationFetcher.shared.lastKnownLocation?.longitude ?? -123.133507) + Double.random(in: -0.009...0.009)
            value.rowId = rowID
        }
        
        let category2 = Category(context: context)
        category2.id = UUID()
        category2.name = "Second Category"
        category2.variable = variable
        
        for _ in 1...4 {
            let value = CategoricalDataPoint(context: context)
            value.id = UUID()
            value.date = Date()
            value.category = category2
            value.variable = variable
            value.latitude = (LocationFetcher.shared.lastKnownLocation?.latitude ?? 49.284154) + Double.random(in: -0.009...0.009)
            value.longitude = (LocationFetcher.shared.lastKnownLocation?.longitude ?? -123.133507) + Double.random(in: -0.009...0.009)
            value.rowId = rowID
        }
        
        variable.dataset = self.exampleDataset

        return variable
        
    }
    
    static var exampleContinuousVariables: [ContinuousVariable] {
        
        let variable1 = ContinuousVariable(context: context)
        variable1.id = UUID()
        variable1.name = "Variable 1"
        variable1.dataset = exampleDataset
        
        for i in 1...10 {
            let datapoint = ContinuousDataPoint(context: context)
            datapoint.id = UUID()
            datapoint.date = Date()
            datapoint.rowId = rowID
            datapoint.value = Double(i)
            datapoint.variable = variable1
            datapoint.latitude = (LocationFetcher.shared.lastKnownLocation?.latitude ?? 49.284154) + Double.random(in: -0.009...0.009)
            datapoint.longitude = (LocationFetcher.shared.lastKnownLocation?.longitude ?? -123.133507) + Double.random(in: -0.009...0.009)
        }
        
        let variable2 = ContinuousVariable(context: context)
        variable2.id = UUID()
        variable2.name = "Variable 2"
        variable2.dataset = exampleDataset
        
        for i in 1...10 {
            let datapoint = ContinuousDataPoint(context: context)
            datapoint.id = UUID()
            datapoint.date = Date()
            datapoint.rowId = rowID
            datapoint.value = Double(i)
            datapoint.variable = variable2
            datapoint.latitude = (LocationFetcher.shared.lastKnownLocation?.latitude ?? 49.284154) + Double.random(in: -0.009...0.009)
            datapoint.longitude = (LocationFetcher.shared.lastKnownLocation?.longitude ?? -123.133507) + Double.random(in: -0.009...0.009)
        }
        
        return [variable1, variable2]
    }
    
    static var locations: [Location] {
        
        var locations: [Location] = []
        
        for datapoint in exampleCategoricalVariable.categoriesArray.first!.valuesArray {
            let location = Location(coordinate: CLLocationCoordinate2D(latitude: datapoint.latitude, longitude: datapoint.longitude))
            locations.append(location)
        }
        
        return locations
    }
    
    static var centerLocation: Location {
        var longitude: Double = 0
        var latitude: Double = 0
        
        for location in locations {
            latitude += location.coordinate.latitude
            longitude += location.coordinate.longitude
        }
        
        latitude = latitude/Double(locations.count)
        longitude = longitude/Double(locations.count)
        
        return Location(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        
    }
    
    static var mapRegion: MKCoordinateRegion {
        MKCoordinateRegion(
            center: centerLocation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }
    
    static var averageValuesByDate: [DateComponents: Double] {
        
        guard let variable = exampleContinuousVariables.first else {return [:]}
        
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
}
