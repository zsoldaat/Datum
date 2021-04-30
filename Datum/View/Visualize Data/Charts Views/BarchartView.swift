//
//  BarchartView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-27.
//

import SwiftUI

struct BarchartView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
        
        //This is to give the chart some headroom.
        maxValue += 1
        
        self.numberOfCategories = CGFloat(categoriesAndCounts.count)
        
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
                                .foregroundColor(Color.random()) //make color a property of the category and assign it randomly upon creation
                                .frame(
                                    width: (geometry.size.width / numberOfCategories / 1.5),
                                    height: geometry.size.height / maxValue * CGFloat(categoriesAndCounts[category]!)
                                )
                            Text("\(category.name!), \(categoriesAndCounts[category]!)")
                                .padding()
                        }
                    }
                }
                //Grid
                ForEach(0..<Int(maxValue+1)) { number in
                        HStack {
                            Text(number != 0 ? "\(number)" : "")
                                .padding(.leading)
                            Rectangle()
                                .frame(height: 1)
                                
                        }
                        .position(
                            x: geometry.size.width / 2,
                            y: geometry.size.height - CGFloat(number)*(geometry.size.height/maxValue)
                        )
                }
                
                //Just to outline the bounds of the view
                Rectangle().strokeBorder(lineWidth: 2).foregroundColor(.red)
                
                Button(action: {presentationMode.wrappedValue.dismiss()}, label: {
                    Image(systemName: "x.circle")
                })
                .position(
                    x: geometry.size.width - 20,
                    y: 20
                )
                    
            }
        }
        .padding()
    }
}

//struct BarchartView_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//        let context = PersistenceController.shared.container.viewContext
//
//        let variable = CategoricalVariable(context: context)
//        variable.id = UUID()
//        variable.name = "Barchar test"
//
//        let category1 = Category(context: context)
//        category1.id = UUID()
//        category1.name = "First"
//
//        let category2 = Category(context: context)
//        category2.id = UUID()
//        category2.name = "Second"
//
//        let point1 = CategoricalDataPoint(context: context)
//        point1.id = UUID()
//        point1.category = category1
//
//        let point2 = CategoricalDataPoint(context: context)
//        point2.id = UUID()
//        point2.category = category1
//
//        let point3 = CategoricalDataPoint(context: context)
//        point3.id = UUID()
//        point3.category = category2
//
//        variable.addToCategories(category1)
//        variable.addToCategories(category2)
//
//        return BarchartView(categoricalVariable: variable)
//    }
//}
