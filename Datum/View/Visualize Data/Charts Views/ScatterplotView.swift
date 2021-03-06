//
//  ScatterplotView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import SwiftUI

struct ScatterplotView: View {
    
    let exampleMode: Bool
    let vm: ScatterplotViewModel
    
    init(xvar: ContinuousVariable?, yvar: ContinuousVariable?, exampleMode: Bool = false) {
        self.vm = ScatterplotViewModel(xvar: xvar!, yvar: yvar!)
        self.exampleMode = exampleMode
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                //Scatterplot
                ForEach(vm.dataPoints) { point in
                    Circle()
                        .frame(width: 10)
                        .foregroundColor(.blue)
                        .position(
                            x: geometry.size.width * CGFloat(point.xValue.value / vm.xmax),
                            y: geometry.size.height - geometry.size.height * CGFloat(point.yValue.value / vm.ymax)
                        )
                        .onTapGesture {
                            //Change this to actually display the point on screen
//                            print(point.xValue.value, point.yValue.value)
                        }
                }
                
                //Horizontal Grid
                ForEach(0..<6) { number in
                    ZStack {
                        Text("\(number * Int(vm.ymax)/5)")
                            .offset(x:-geometry.size.width/2 - 10, y:0)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)

                    }
                    .position(
                        x: geometry.size.width / 2,
                        y: geometry.size.height - (geometry.size.height/5) * CGFloat(number)
                    )
                }
                
                //Vertical Grid
                ForEach(0..<6) { number in
                    ZStack {
                        Text(number != 0 ? "\(number * Int(vm.xmax/5))" : "")
                            .offset(x:0, y: geometry.size.height/2 + 10)
                        Rectangle()
                            .frame(width: 1)
                            .foregroundColor(.gray)

                    }
                    .position(
                        x: CGFloat(number) * geometry.size.width/5,
                        y: geometry.size.height / 2
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

//struct ScatterplotView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScatterplotView(xvar: <#[ContinuousData]#>, yvar: <#[ContinuousData]#>)
//    }
//}
