//
//  BarChartViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-06-16.
//

import Foundation
import CoreGraphics

class BarChartViewModel: ObservableObject {
    
    let variable: CategoricalVariable
    
    @Published var categoriesAndCounts: [Category: Int] = [:]
    @Published var maxValue: CGFloat = 0
    @Published var numberOfCategories: CGFloat = 0
    @Published var categories: [Category] = []
    
    init(categoricalVariable: CategoricalVariable) {
        self.variable = categoricalVariable
        
        for category in variable.categoriesArray {
            self.categoriesAndCounts[category] = category.valuesArray.count
            self.maxValue = max(maxValue, CGFloat(category.valuesArray.count))
            self.categories.append(category)
        }
        
        maxValue = calculateMaxValue(value: maxValue)
        
        self.numberOfCategories = CGFloat(categoriesAndCounts.count)
    }
    
    //Sets the max value of the chart to the nearest multiple of 5, because the chart has 5 gridlines
    func calculateMaxValue(value: CGFloat) -> CGFloat {
        let remainder = value.truncatingRemainder(dividingBy: 5)
        return value + 5 - remainder
    }
    
}
