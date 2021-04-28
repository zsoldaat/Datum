//
//  VizualizationManager.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-28.
//

import Foundation

struct VisualizationManager {
    
    var dataset: Dataset? = nil {
        didSet {
            selectedContinuous = dataset!.continuousArray.filter {$0.isSelected == true}
            selectedCategorical = dataset!.categoricalArray.filter {$0.isSelected == true}
        }
    }
    let chart: Chart? = nil
    
    //Notes for next time: Once the user selects the chart type, create the actual Chart object. This will populate the values for the required number of variables. Once we know what types of variables are required, we can then let the user choose which variables they want. 
    
    let allDatasets = DatasetStorage.shared.datasets.value
    
    var selectedChartType: Chart.ChartType = .barchart
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
    
}
