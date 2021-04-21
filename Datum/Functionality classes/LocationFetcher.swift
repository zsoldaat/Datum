//
//  LocationFetcher.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-17.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    //Singleton
    static let shared: LocationFetcher = LocationFetcher()

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        
        switch manager.authorizationStatus {
        case .restricted, .denied:
            print("No permission")
        default:
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
