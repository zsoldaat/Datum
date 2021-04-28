//
//  Chart.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-23.
//

import Foundation

class Chart {
    
    var name: String
    var continuousVariablesRequired: Int
    var categoricalVariablesRequired: Int
    var type: ChartType
    
    init(type: ChartType) {
        self.name = type.rawValue.capitalized
        self.type = type
        
        switch type {
        case .scatterplot:
            self.continuousVariablesRequired = 2
            self.categoricalVariablesRequired = 0
        case .barchart:
            self.continuousVariablesRequired = 0
            self.categoricalVariablesRequired = 1
        }
    }
    
    enum ChartType: String, CaseIterable, Identifiable {
        var id: ChartType {self}
        case scatterplot, barchart
    }
    
}



extension Chart: Identifiable {
    
}
