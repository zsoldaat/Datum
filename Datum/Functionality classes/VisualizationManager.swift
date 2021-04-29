//
//  VizualizationManager.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-28.
//

import Foundation

struct VisualizationManager {
    
    var chart: Chart = Chart(type: .barchart)
    var dataset: Dataset? = nil {
        didSet {
            updateSelected()
        }
    }
    
    //Notes for next time: Once the user selects the chart type, create the actual Chart object. This will populate the values for the required number of variables. Once we know what types of variables are required, we can then let the user choose which variables they want. 
    
    let allDatasets = DatasetStorage.shared.datasets.value
    var selectedChartType: Chart.ChartType = .barchart {
        didSet {
            self.chart = Chart(type: selectedChartType)
        }
    }
    var selectedContinuous = [ContinuousVariable]()
    var selectedCategorical = [CategoricalVariable]()
    
    mutating func selectVariable<T: Variable>(_ variable: T) {
        if variable.self is ContinuousVariable {
            let continuous = variable as! ContinuousVariable
            continuous.isSelected.toggle()
        } else {
            let categorical = variable as! CategoricalVariable
            categorical.isSelected.toggle()
        }
        updateSelected()
    }
    
    mutating func updateSelected() {
        selectedContinuous = dataset!.continuousArray.filter {$0.isSelected == true}
        selectedCategorical = dataset!.categoricalArray.filter {$0.isSelected == true}
    }
    
    var correctNumberOfVarsSelected: Bool {
        
        let correctContinuous = selectedContinuous.count == chart.continuousVariablesRequired
        let correctCategorical = selectedCategorical.count == chart.categoricalVariablesRequired
        
        return correctContinuous && correctCategorical
        
        
        
    }
    
}
