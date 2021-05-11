//
//  ExampleData.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-11.
//

import Foundation

class ExampleData {
    
    static let context = PersistenceController.shared.container.viewContext
    
    static var rowID = UUID()
    
    static var exampleDataset: Dataset {
        
        let dataset = Dataset(context: context)
        dataset.id = UUID()
        dataset.name = "Example"
        dataset.date = Date()
        
        return dataset

    }
    
    static var exampleCategoricalVariable: CategoricalVariable {
        
        let variable = CategoricalVariable(context: context)
        variable.id = UUID()
        variable.name = "Example"
        
        let category1 = Category(context: context)
        category1.id = UUID()
        category1.name = "First Category"
        category1.variable = variable
        
        for _ in 1...3 {
            let value = CategoricalDataPoint(context: context)
            value.id = UUID()
            value.date = Date()
            value.category = category1
            value.variable = variable
            value.latitude = (LocationFetcher.shared.lastKnownLocation?.latitude ?? 49.284154) + Double.random(in: -0.009...0.009)
            value.longitude = (LocationFetcher.shared.lastKnownLocation?.longitude ?? -123.133507) + Double.random(in: -0.009...0.009)
            value.rowId = rowID
        }
        
        let category2 = Category(context: context)
        category2.id = UUID()
        category2.name = "Second Category"
        category2.variable = variable
        
        for _ in 1...4 {
            let value = CategoricalDataPoint(context: context)
            value.id = UUID()
            value.date = Date()
            value.category = category2
            value.variable = variable
            value.latitude = (LocationFetcher.shared.lastKnownLocation?.latitude ?? 49.284154) + Double.random(in: -0.009...0.009)
            value.longitude = (LocationFetcher.shared.lastKnownLocation?.longitude ?? -123.133507) + Double.random(in: -0.009...0.009)
            value.rowId = rowID
        }
        
        variable.dataset = self.exampleDataset

        return variable
        
    }
    
    static var exampleVariables: [ContinuousVariable] {
        
        let variable1 = ContinuousVariable(context: context)
        variable1.id = UUID()
        variable1.name = "Variable 1"
        variable1.dataset = exampleDataset
        
        for i in 1...10 {
            let datapoint = ContinuousDataPoint(context: context)
            datapoint.id = UUID()
            datapoint.date = Date()
            datapoint.rowId = rowID
            datapoint.value = Double(i)
            datapoint.variable = variable1
        }
        
        let variable2 = ContinuousVariable(context: context)
        variable2.id = UUID()
        variable2.name = "Variable 2"
        variable2.dataset = exampleDataset
        
        for i in 1...10 {
            let datapoint = ContinuousDataPoint(context: context)
            datapoint.id = UUID()
            datapoint.date = Date()
            datapoint.rowId = rowID
            datapoint.value = Double(i)
            datapoint.variable = variable2
        }
        
        return [variable1, variable2]
    }
}
