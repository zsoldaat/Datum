//
//  ContentViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-14.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var datasets: [Dataset] = []
    
    @Published var destination = SheetDestination.addDatasetView
    @Published var showingSheet = false
    
    private var cancellable: AnyCancellable?
    
    init(datasetPublisher: AnyPublisher<[Dataset], Never> = DatasetStorage.shared.datasets.eraseToAnyPublisher()) {
        cancellable = datasetPublisher.sink { datasets in
            print("Updating datasets")
            self.datasets = datasets
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        offsets.map { datasets[$0] }.forEach(DatasetStorage.shared.delete)
    }
    
    func showSheet(_ sheet: SheetDestination) {
        destination = sheet
        showingSheet = true
    }

    enum SheetDestination {
        case addDatasetView, addObservationView
    }
}
