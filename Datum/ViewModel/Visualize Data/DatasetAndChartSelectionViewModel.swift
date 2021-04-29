//
//  DatasetAndChartSelectionViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-28.
//

import Foundation

class DatasetAndChartSelectionViewModel: ObservableObject {
    
    @Published var visualizationManager = VisualizationManager()
    
    @Published var chartTypes: [Chart.ChartType]
    @Published var allDatasets: [Dataset]
    
    @Published var selectedChart: Chart.ChartType = .scatterplot
//    @Published var selectedDataset: Dataset?
    
    @Published var destination: Destination = .variableSelection
    
    init() {
        self.chartTypes = Chart.ChartType.allCases
        self.allDatasets = DatasetStorage.shared.datasets.value
    }
    
    enum Destination: String, CaseIterable, Identifiable {
        case chartTypeSelection, variableSelection
        var id: Destination {self}

    }
    
}
