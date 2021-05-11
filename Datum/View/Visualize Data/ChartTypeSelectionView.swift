//
//  ChartTypeSelectionView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-28.
//

import SwiftUI

struct ChartTypeSelectionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var visualizationManager: VisualizationManager
    
    var body: some View {
//        Picker("Chart Type", selection: $visualizationManager.chart.type) {
//            ForEach(Chart.ChartType.allCases) { chart in
//                Text(chart.rawValue.capitalized)
//            }
//        }
        
        List {
            
            VStack {
                BarchartView(categoricalVariable: ExampleData.exampleCategoricalVariable)
                    .frame(height: 200)
//                    .allowsHitTesting(false)
                Text("Barchart")
            }
            .onTapGesture {
                visualizationManager.chart.type = .barchart
                print("Hello")
            }
            
            VStack {
                ScatterplotView(xvar: ExampleData.exampleContinuousVariables.first, yvar: ExampleData.exampleContinuousVariables.last)
                    .frame(height: 200)
//                    .allowsHitTesting(false)
                Text("Scatterplot")
            }
            .onTapGesture { visualizationManager.chart.type = .scatterplot }
            
            VStack {
                DatapointMapView(locations: ExampleData.locations, region: ExampleData.mapRegion)
                    .frame(height: 200)
                    .allowsHitTesting(false)
                Text("Map View")
            }
            .onTapGesture { visualizationManager.chart.type = .mapView }
            
            VStack {
                RootCalendarView(datesAndValues: ExampleData.averageValuesByDate)
                    .frame(height: 200)
                Text("Calendar Heat Map")
            }
            .onTapGesture {
                visualizationManager.chart.type = .calendarView
            }
            
            
            
            
            
            
            
            
        }
        
        
        
        DoneButton{presentationMode.wrappedValue.dismiss()}
        
    }
}

//struct ChartTypeSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartTypeSelectionView()
//    }
//}
