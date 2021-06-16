//
//  DatapointMapViewViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-06-16.
//

import Foundation
import MapKit

class DatapointMapViewViewModel: ObservableObject {
    
    var locationCoordinates: [Location]
    var centerLocation: Location
    @Published var mapRegion: MKCoordinateRegion
    
    init(dataset: Dataset, exampleMode: Bool) {
        
        //Creating locationCoordinates
        if !exampleMode {
            var locationDict: [UUID: Location] = [:]
            
            let continuous = ContinuousDataPointStorage.shared.continuousDataPoints.value.filter {$0.variable?.dataset == dataset}
            let categorical = CategoricalDataPointStorage.shared.categoricalDataPoints.value.filter {$0.variable?.dataset == dataset}
            
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
            
            locationCoordinates = Array(locationDict.values)
            
            //Creating centerLocation
            var longitude: Double = 0
            var latitude: Double = 0
            
            for location in locationCoordinates {
                latitude += location.coordinate.latitude
                longitude += location.coordinate.longitude
            }
            
            latitude = latitude/Double(locationCoordinates.count)
            longitude = longitude/Double(locationCoordinates.count)
            
            centerLocation = Location(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            
            //Creating MapRegion
            mapRegion = MKCoordinateRegion(
                center: centerLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
            )
        } else {
            
            var locations: [Location] = []
            
            for datapoint in ExampleData.exampleCategoricalVariable.categoriesArray.first!.valuesArray {
                let location = Location(coordinate: CLLocationCoordinate2D(latitude: datapoint.latitude, longitude: datapoint.longitude))
                locations.append(location)
            }
            
            locationCoordinates = locations
            
            var longitude: Double = 0
            var latitude: Double = 0
            
            for location in locations {
                latitude += location.coordinate.latitude
                longitude += location.coordinate.longitude
            }
            
            latitude = latitude/Double(locations.count)
            longitude = longitude/Double(locations.count)
            
            centerLocation = Location(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            
            mapRegion = MKCoordinateRegion(
                center: centerLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        }
        
        
    }
    
}
