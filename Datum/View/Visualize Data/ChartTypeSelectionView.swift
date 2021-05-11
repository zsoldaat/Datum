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
    
    @State private var selection: Chart.ChartType = .barchart
    
    var body: some View {
//        Picker("Chart Type", selection: $visualizationManager.chart.type) {
//            ForEach(Chart.ChartType.allCases) { chart in
//                Text(chart.rawValue.capitalized)
//            }
//        }
        
        List {
            
            VStack {
                BarchartView(categoricalVariable: CategoricalVariableStorage.exampleCategoricalVariable)
                    .frame(height: 200)
                Text("Barchart")
            }
            .onTapGesture { self.selection = .barchart }
            
            VStack {
                ScatterplotView(xvar: ContinuousVariableStorage.exampleVariables.first, yvar: ContinuousVariableStorage.exampleVariables.last)
                    .frame(height: 200)
                Text("Scatterplot")
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
