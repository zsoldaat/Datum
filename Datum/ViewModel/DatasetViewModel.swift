//
//  DatasetViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-14.
//

import Foundation
import Combine

class DatasetViewModel: ObservableObject {
    
    var selectedDataset: Dataset
    
    @Published var continuousVariables: [ContinuousVariable] = []
    @Published var categoricalVariables: [CategoricalVariable] = []
    
    private var continuousCancellable: AnyCancellable?
    private var categoricalCancellable: AnyCancellable?
    
    init(continuousPublisher: AnyPublisher<[ContinuousVariable], Never> = ContinuousVariableStorage.shared.continuousVariables.eraseToAnyPublisher(),
         categoricalPublisher: AnyPublisher<[CategoricalVariable], Never> = CategoricalVariableStorage.shared.categoricalVariables.eraseToAnyPublisher(),
         selectedDataset: Dataset) {
        
        self.selectedDataset = selectedDataset
        
        continuousCancellable = continuousPublisher.sink { continuous in
            print("Updating continuous variables")
            self.continuousVariables = continuous.filter {$0.dataset == self.selectedDataset}
            
        }
        
        categoricalCancellable = categoricalPublisher.sink { categorical in
            print("Updating categorical variables")
            self.categoricalVariables = categorical.filter {$0.dataset == self.selectedDataset}
        }
        
    }
    
    
}
