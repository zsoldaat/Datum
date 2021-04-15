//
//  AddVariableViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-15.
//

import Foundation
import Combine

class AddVariableViewModel: ObservableObject {
    
    var dataset: Dataset
    
    @Published var continuousVariables: [ContinuousVariable] = []
    @Published var categoricalVariables: [CategoricalVariable] = []
    
    @Published var newVariableName: String = ""
    @Published var newVariableType: VariableTypes = .continuous
    
    @Published var newVariableMin: String = ""
    @Published var newVariableMax: String = ""
    
    @Published var newVariableCategories: [String] = []
    @Published var newCategoryName: String = ""
    
    @Published var alertMessage = ""
    @Published var alertShowing = false
    
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
    
    enum VariableTypes: String, CaseIterable, Identifiable {
        case continuous
        case categorical
        
        var id: String {self.rawValue}
    }
    
    func toggleVariableType() {
        if newVariableType == .continuous {
            newVariableType = .categorical
        } else {
            newVariableType = .continuous
        }
    }
    
    func addVariable() {
        
        if !newVariableName.isEmpty {
            switch newVariableType {
            case .continuous:
                
                guard let doubleMin = Double(newVariableMin) else {
                    showAlert(message: "The minimum value you entered is not a number")
                    return
                }
                guard let doubleMax = Double(newVariableMax) else {
                    showAlert(message: "The maximum value you entered is not a number")
                    return
                }
                
                if doubleMax - doubleMin < 0 {
                    showAlert(message: "The minimum value is greater than the maximum value")
                    return
                }
            
                ContinuousVariableStorage.shared.add(name: newVariableName, min: doubleMin, max: doubleMax, dataset: dataset)
                
            case .categorical:
                
                if newVariableCategories.isEmpty {
                    showAlert(message: "There are no categories to add")
                    return
                }
            
                CategoricalVariableStorage.shared.add(name: newVariableName, dataset: dataset, categories: newVariableCategories)
            }
        } else {
            showAlert(message: "Please enter a variable name")
        }
    }
    
    func addCategoryName() {
        if !newCategoryName.isEmpty {
            newVariableCategories.append(newCategoryName)
            newCategoryName = ""
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        alertShowing = true
    }
}
