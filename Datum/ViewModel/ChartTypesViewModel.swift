//
//  ChartTypesViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-23.
//

import Foundation

class ChartTypesViewModel: ObservableObject {
    
    let dataset: Dataset
    
    @Published var continuousVariableCount: Int
    @Published var categoricalVariableCount: Int
    
    @Published var chartList = [Chart]()
    
    init(dataset: Dataset) {
        self.dataset = dataset
        continuousVariableCount = dataset.continuousArray.count
        categoricalVariableCount = dataset.categoricalArray.count
        self.populateChartList()
    }
    
    func populateChartList() {
        if continuousVariableCount >= 2 {
            chartList.append(Chart(type: .scatterplot))
        }
        
        if categoricalVariableCount > 0 {
            chartList.append(Chart(type: .barchart))
        }
        
    }
    
    
    
    
    
    
    
    
    
    
}
