//
//  BarchartView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-27.
//

import SwiftUI

struct BarchartView: View {
    
    let exampleMode: Bool
    
    var categoriesAndCounts: [Category:Int]
    var numberOfCategories: CGFloat
    var maxValue: CGFloat = 0
    
    init(categoricalVariable: CategoricalVariable?, exampleMode: Bool = false) {
        
        self.categoriesAndCounts = [Category: Int]()
        
        if let variable = categoricalVariable {
            for category in variable.categoriesArray {
                self.categoriesAndCounts[category] = category.valuesArray.count
                self.maxValue = max(maxValue, CGFloat(category.valuesArray.count))
            }
        }
        
        //This is to give the chart some headroom.
        maxValue += 1
        
        self.numberOfCategories = CGFloat(categoriesAndCounts.count)
        
        self.exampleMode = exampleMode
        
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                //Chart
                HStack(alignment: .bottom) {
//                    Spacer(minLength: geometry.size.width / 20)
                    ForEach(Array(categoriesAndCounts.keys)) { category in
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .foregroundColor(Color.random()) //change this to use some sort of colour scheme once I start working on that stuff
                                .frame(
                                    width: (geometry.size.width / numberOfCategories / 1.5),
                                    height: geometry.size.height / maxValue * CGFloat(categoriesAndCounts[category]!)
                                )
                            Text("\(category.name!)")
                                .offset(x: 0, y: 20)
                        }
                    }
                }
                //Grid
                ForEach(0..<Int(maxValue+1)) { number in
                        ZStack {
                            Text(number != 0 ? "\(number)" : "")
                                .offset(x:-geometry.size.width/2 - 10, y:0)
                            Rectangle()
                                .frame(height: 1)
                                
                        }
                        .position(
                            x: geometry.size.width / 2,
                            y: geometry.size.height - CGFloat(number)*(geometry.size.height/maxValue)
                        )
                }
                
                if !exampleMode {
                    FloatingCloseButton()
                }
                    
            }
        }
        .padding()
    }

}

//struct BarchartView_Previews: PreviewProvider {
//
//    static var previews: some View {
//    }
//}
