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
        Picker("Chart Type", selection: $visualizationManager.chart.type) {
            ForEach(Chart.ChartType.allCases) { chart in
                Text(chart.rawValue.capitalized)
            }
        }
        
        Button("Done") {presentationMode.wrappedValue.dismiss()}
        
    }
}

//struct ChartTypeSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartTypeSelectionView()
//    }
//}
