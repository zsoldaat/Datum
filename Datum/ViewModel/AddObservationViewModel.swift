//
//  AddObservationViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-15.
//

import Foundation
import Combine

class AddObservationViewModel: ObservableObject {
    
    var dataset: Dataset
    
    //Try to eventually only use the dictionary instead of having both of these sets of variables
    @Published var continuousVariables: [ContinuousVariable] = []
    @Published var categoricalVariables: [CategoricalVariable] = []
    
    @Published var continuousDict = [ContinuousVariable: String]()
    @Published var categoricalDict = [CategoricalVariable: Category]()
    
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
        
        for variable in continuousVariables {
            continuousDict[variable] = ""
        }
        
        for variable in categoricalVariables {
            //If you change this to not have a default value, update containsBlankValues()
            categoricalDict[variable] = variable.categoriesArray.first
        }
        
    }
    
    func addObservation() {
        if !containsBlankValues() && !containsInvalidInputs() && !containsValuesOutOfRange() {
            let rowId = UUID()
            
            for dataPoint in continuousDict.keys {
                let value = Double(continuousDict[dataPoint]!)!
                ContinuousDataPointStorage.shared.add(variable: dataPoint, value: value, rowId: rowId)
            }
            
            for dataPoint in categoricalDict.keys {
                let category = categoricalDict[dataPoint]!
                CategoricalDataPointStorage.shared.add(variable: dataPoint, category: category, rowId: rowId)
            }
        }
    }
    
    func containsBlankValues() -> Bool {
        for variable in continuousDict.keys {
            if continuousDict[variable]!.isEmpty {
                showAlert(message: "Please enter a value for \(variable.wrappedName)")
                return true
            }
        }
        return false
    }
    
    func containsInvalidInputs() -> Bool {
        for variable in continuousDict.keys {
            if Double(continuousDict[variable]!) == nil {
                showAlert(message: "The value you entered for \(variable.wrappedName) is not a valid number.")
                return true
            }
        }
        return false
    }
    
    func containsValuesOutOfRange() -> Bool {
        for variable in continuousDict.keys {
            
            guard let value = Double(continuousDict[variable]!) else { return true }
            
            if let minimum = variable.min {
                if value < minimum {
                    showAlert(message: "The value you entered for \(variable.wrappedName) is below the minimum value")
                    return true
                }
            }
            
            if let maximum = variable.max {
                if value > maximum {
                    showAlert(message: "The value you entered for \(variable.wrappedName) is above the maximum value")
                    return true
                }
            }
        }
        
        return false
        
        
    }
    
    func showAlert(message: String) {
        alertMessage = message
        alertShowing = true
    }
    
    
    
}
