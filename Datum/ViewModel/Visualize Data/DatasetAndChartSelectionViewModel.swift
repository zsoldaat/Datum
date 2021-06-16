//
//  DatasetAndChartSelectionViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-28.
//

import Foundation

class DatasetAndChartSelectionViewModel: ObservableObject {
    
    @Published var visualizationManager: VisualizationManager
    @Published var allDatasets: [Dataset]
    @Published var destination: Destination = .barchart
    
    init() {
        self.visualizationManager = VisualizationManager()
        self.allDatasets = DatasetStorage.shared.datasets.value
    }
    
    enum Destination: String, CaseIterable, Identifiable {
        case scatterplot, barchart, mapView, calendarView
        var id: Destination {self}
    }
    
}
