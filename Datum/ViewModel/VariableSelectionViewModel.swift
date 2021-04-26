//
//  VariableSelectionViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-23.
//

import Foundation

class VariableSelectionViewModel: ObservableObject {
    
    let dataset: Dataset
    let chart: Chart
    
    @Published var continuousCount = 0
    @Published var categoricalCount = 0
    
    var selectedContinuousVariables = [ContinuousVariable]()
    var selectedCategoricalVariables = [CategoricalVariable]()
    
    init(dataset: Dataset, chart: Chart) {
        self.dataset = dataset
        self.chart = chart
    }
    
    func selectContinuousVariable(variable: ContinuousVariable) {
        variable.isSelected.toggle()
        if variable.isSelected {
            continuousCount += 1
            selectedContinuousVariables.append(variable)
        } else {
            continuousCount -= 1
            selectedContinuousVariables.removeAll {$0.id == variable.id}
        }
    }
    
    func selectCategoricalVariable(variable: CategoricalVariable) {
        if variable.isSelected {
            categoricalCount += 1
            selectedCategoricalVariables.append(variable)
        } else {
            categoricalCount -= 1
            selectedCategoricalVariables.removeAll {$0.id == variable.id}
        }
    }
    
    var correctNumberSelected: Bool {
        let continuousCorrect = self.chart.continuousVariablesRequired == self.continuousCount
        let categoricalCorrect = self.chart.categoricalVariablesRequired == self.categoricalCount
        return continuousCorrect && categoricalCorrect
    }
    
    
    
}
