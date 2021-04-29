//
//  BarchartView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-27.
//

import SwiftUI

struct BarchartView: View {
    
    var categoriesAndCounts: [Category:Int]
    var numberOfCategories: CGFloat
    var maxValue: CGFloat = 0
    
    init(categoricalVariable: CategoricalVariable?) {
        
        self.categoriesAndCounts = [Category: Int]()
        
        if let variable = categoricalVariable {
            for category in variable.categoriesArray {
                self.categoriesAndCounts[category] = category.valuesArray.count
                self.maxValue = max(maxValue, CGFloat(category.valuesArray.count))
            }
        }
        
        self.numberOfCategories = CGFloat(categoriesAndCounts.count)

    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                
                HStack {
                    ForEach(Array(categoriesAndCounts.keys)) { category in
                        VStack {
//                            Text("\(category.name!), \(categoriesAndCounts[category]!)")
                            Rectangle()
                                .foregroundColor(Color.random()) //make color a property of the category and assign it randomly upon creation
                                .frame(
                                    width: geometry.size.width / numberOfCategories,
                                    height: geometry.size.height / CGFloat(categoriesAndCounts[category]!) * maxValue
                                )
                        }
                    }
                }
                
                ForEach(0..<Int(maxValue+1)) { number in
                    VStack {
                        HStack {
//                            Image(systemName: "\(number).circle.fill")//figure out why this isn't displaying properly
//                            Spacer()
                            Rectangle()
                                .frame(height: 1)
                                .position(
                                    x: geometry.size.width / 2,
                                    y: geometry.size.height - CGFloat(number)*(geometry.size.height/maxValue)
                                )
                        }
                    }
                }
            }
        }
    }
}

//struct BarchartView_Previews: PreviewProvider {
//
//    static let dataset: Dataset = DatasetStorage.shared.datasets.value.first {
//        $0.wrappedName == "Bar chart test"
//    }!
//
//    static let variable: CategoricalVariable = dataset.categoricalArray.first!
//
//
//    static var previews: some View {
//
//        BarchartView(categoricalVariable: variable)
//    }
//}
