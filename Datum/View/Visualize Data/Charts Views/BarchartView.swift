//
//  BarchartView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-27.
//

import SwiftUI

struct BarchartView: View {
    
    let exampleMode: Bool
    
    let vm: BarChartViewModel
    
    init(categoricalVariable: CategoricalVariable?, exampleMode: Bool = false) {
        self.vm = BarChartViewModel(categoricalVariable: categoricalVariable!)
        self.exampleMode = exampleMode
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                //Chart
                HStack(alignment: .bottom) {
                    ForEach(vm.categories) { category in
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .foregroundColor(Color.random()) //change this to use some sort of colour scheme once I start working on that stuff
                                .frame(
                                    width: (geometry.size.width / vm.numberOfCategories / 1.5),
                                    height: geometry.size.height / vm.maxValue * CGFloat(vm.categoriesAndCounts[category]!)
                                )
                            Text("\(category.name!)")
                                .offset(x: 0, y: 20)
                        }
                    }
                }
                //Grid
                ForEach(0..<6) { number in
                        ZStack {
                            Text(number != 0 ? "\(number * (Int(vm.maxValue)/5))" : "")
                                .offset(x:-geometry.size.width/2 - 10, y:0)
                            Rectangle()
                                .frame(height: 1)
                                
                        }
                        .position(
                            x: geometry.size.width / 2,
                            y: geometry.size.height - (geometry.size.height/5) * CGFloat(number)
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
