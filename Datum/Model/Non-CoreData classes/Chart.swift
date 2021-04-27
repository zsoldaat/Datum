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
    var type: ChartTypes
    
    init(type: ChartTypes) {
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
    
    enum ChartTypes: String {
        case scatterplot, barchart
    }
    
}



extension Chart: Identifiable {
    
}
