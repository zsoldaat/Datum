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
    
    
    init(categoricalVariable: CategoricalVariable) {
        self.variable = categoricalVariable
        
        for category in variable.categoriesArray {
            self.categoriesAndCounts[category] = category.valuesArray.count
            self.maxValue = max(maxValue, CGFloat(category.valuesArray.count))
        }
        
        self.numberOfCategories = CGFloat(categoriesAndCounts.count)
    }
    
    
    
    
    
    
    
    
}
