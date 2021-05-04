//
//  Chart.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-23.
//

import Foundation

class Chart {
    
    var name: String
    var type: ChartType
    var continuousVariablesRequired: Int
    var categoricalVariablesRequired: Int
    
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
        case .mapView:
            self.continuousVariablesRequired = 0
            self.categoricalVariablesRequired = 0
        }
    }
    
    enum ChartType: String, CaseIterable, Identifiable {
        case scatterplot, barchart, mapView
        var id: ChartType {self}
    }
    
}

extension Chart: Identifiable {
    
}
