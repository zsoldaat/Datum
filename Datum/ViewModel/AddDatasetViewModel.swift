//
//  AddDatasetViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-14.
//

import Foundation
import Combine

class AddDatasetViewModel: ObservableObject {
    
    @Published var datasets: [Dataset] = []
    @Published var datasetName = ""
    
    @Published var alertShowing = false
    @Published var alertMessage = ""
    
    private var cancellable: AnyCancellable?
    
    init(datasetPublisher: AnyPublisher<[Dataset], Never> = DatasetStorage.shared.datasets.eraseToAnyPublisher()) {
        cancellable = datasetPublisher.sink { datasets in
            print("Updating datasets")
            self.datasets = datasets
        }
    }
    
    func addDataset() {
        if !datasetName.isEmpty {
            DatasetStorage.shared.add(name: datasetName)
        }
    }
    
    func showAlert() {
        alertMessage = "Name cannot be blank"
        alertShowing = true
    }
}
