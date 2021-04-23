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
    
    init(type: ChartTypes) {
        self.name = type.rawValue.capitalized
        
        switch type {
        case .scatterplot:
            self.continuousVariablesRequired = 2
            self.categoricalVariablesRequired = 0
        }
    }
    
    enum ChartTypes: String {
        case scatterplot
    }
    
}



extension Chart: Identifiable {
    
}
