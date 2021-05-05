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
    
    init(type: ChartType) {
        self.name = type.rawValue.capitalized
        self.type = type
    }
    
    var continuousVariablesRequired: Int {
        switch type {
        case .scatterplot:
            return 2
        case .barchart:
            return 0
        case .mapView:
            return 0
        }
    }
    
    var categoricalVariablesRequired: Int {
        switch type {
        case .scatterplot:
            return 0
        case .barchart:
            return 1
        case .mapView:
            return 0
        }
    }
    
    enum ChartType: String, CaseIterable, Identifiable {
        case scatterplot, barchart, mapView
        var id: ChartType {self}
    }
    
}

extension Chart: Identifiable {
    
}
