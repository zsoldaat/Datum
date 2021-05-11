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
        case .calendarView:
            return 1
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
        case .calendarView:
            return 0
        }
    }
    
    enum ChartType: String, CaseIterable, Identifiable {
        case scatterplot, barchart, mapView, calendarView
        var id: ChartType {self}
        
        var properName: String {
            switch self {
            case .barchart:
                return "Barchart"
            case .calendarView:
                return "Calendar Heat Map"
            case .mapView:
                return "Map View"
            case .scatterplot:
                return "Scatterplot"
            }
        }
    }
    
}

extension Chart: Identifiable {
    
}
