//
//  DatapointMapViewViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-06-16.
//

import Foundation
import MapKit

class DatapointMapViewViewModel: ObservableObject {
    
    let dataset: Dataset
    
    init(dataset: Dataset) {
        self.dataset = dataset
    }
    
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
    
}
