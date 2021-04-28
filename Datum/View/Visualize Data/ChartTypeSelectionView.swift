//
//  ChartTypeSelectionView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-28.
//

import SwiftUI

struct ChartTypeSelectionView: View {
    
    @Binding var visualizationManager: VisualizationManager
    
    var body: some View {
        Picker("Chart Type", selection: $visualizationManager.selectedChartType) {
            ForEach(Chart.ChartType.allCases) { chart in
                Text(chart.rawValue.capitalized)
            }
        }
    }
}

//struct ChartTypeSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartTypeSelectionView()
//    }
//}
