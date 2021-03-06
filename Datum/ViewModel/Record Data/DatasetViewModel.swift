//
//  DatasetViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-14.
//

import Foundation
import Combine

class DatasetViewModel: ObservableObject {
    
    var dataset: Dataset
    
    @Published var continuousVariables: [ContinuousVariable] = []
    @Published var categoricalVariables: [CategoricalVariable] = []
    
    @Published var showSheet = false
    @Published var destination: SheetDestination = .addVariableView
    
    private var continuousCancellable: AnyCancellable?
    private var categoricalCancellable: AnyCancellable?
    
    init(continuousPublisher: AnyPublisher<[ContinuousVariable], Never> = ContinuousVariableStorage.shared.continuousVariables.eraseToAnyPublisher(),
         categoricalPublisher: AnyPublisher<[CategoricalVariable], Never> = CategoricalVariableStorage.shared.categoricalVariables.eraseToAnyPublisher(),
         dataset: Dataset) {
        
        self.dataset = dataset
        
        continuousCancellable = continuousPublisher.sink { continuous in
            print("Updating continuous variables")
            self.continuousVariables = continuous.filter {$0.dataset == self.dataset}
            
        }
        
        categoricalCancellable = categoricalPublisher.sink { categorical in
            print("Updating categorical variables")
            self.categoricalVariables = categorical.filter {$0.dataset == self.dataset}
        }
        
    }
    
    enum SheetDestination {
        case addVariableView
    }
    
    func showAddVariableView() {
        destination = .addVariableView
        showSheet = true
    }
    
    
}
