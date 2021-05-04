//
//  Location.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-04.
//

import Foundation
import MapKit

struct Location: Identifiable {
    var id = UUID()
    var coordinate: CLLocationCoordinate2D
    
    
}
