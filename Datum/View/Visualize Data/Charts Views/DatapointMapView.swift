//
//  DatapointMapView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-04.
//

import SwiftUI
import MapKit

struct DatapointMapView: View {
    
    let exampleMode: Bool
    
    let locations: [Location]
    
    @State var region: MKCoordinateRegion
    
    init(locations: [Location], region: MKCoordinateRegion, exampleMode: Bool = false) {
        self.locations = locations
        self.region = region
        self.exampleMode = exampleMode
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                    DatapointDetailView(location: location)
                }
            }
            .allowsHitTesting(!exampleMode)
            
            if !exampleMode {
                FloatingCloseButton()
            }
        }
    }
    
    struct DatapointDetailView: View {
        
        let location: Location
        @State private var isTapped = false
        
        var body: some View {
            if isTapped {
                VStack(alignment: .leading) {
                    ForEach(location.categoricalData) { categorical in
                        HStack {
                            Text("\(categorical.variable!.wrappedName):").foregroundColor(.primary)
                            Text(categorical.category!.name!).foregroundColor(.secondary)
                        }
                    }
                    ForEach(location.continuousData) { continuous in
                        HStack {
                            Text("\(continuous.variable!.wrappedName):").foregroundColor(.primary)
                            Text(continuous.value.removeZerosFromEnd()).foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.white, lineWidth: 2)
                )
                .frame(width: 200, height: 200)
                //This frame modifier is here so that the DetailView will be the right size for the text when tapped.This is kind of jank and should probably be replaced once I figure out how to actually set the correct size when tapped. Might have to use geometry reader but there should be a solution to this wihout it. 
                .onTapGesture {
                    isTapped.toggle()
                }
                
            } else {
                Circle()
                    .stroke(Color.green)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        isTapped.toggle()
                    }
            }
        }
    }

}

//struct DatapointMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        DatapointMapView()
//    }
//}
