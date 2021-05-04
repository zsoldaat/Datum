//
//  DatapointMapView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-04.
//

import SwiftUI
import MapKit

struct DatapointMapView: View {
    
    let locations: [Location]
    
    @State var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                Circle()
                    .stroke(Color.green)
                    .frame(width: 44)
            }
        }
    }

}

//struct DatapointMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        DatapointMapView()
//    }
//}
