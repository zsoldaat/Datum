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
    
    private var cancellable: AnyCancellable?
    
    init(datasetPublisher: AnyPublisher<[Dataset], Never> = DatasetStorage.shared.datasets.eraseToAnyPublisher()) {
        cancellable = datasetPublisher.sink { datasets in
            print("Updating datasets")
            self.datasets = datasets
        }
    }
    
    
    
}
