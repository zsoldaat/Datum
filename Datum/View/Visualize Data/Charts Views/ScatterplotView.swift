//
//  ScatterplotView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import SwiftUI

struct ScatterplotView: View {
    
    var dataPoints: [Point]
    var xmin: Double?
    var xmax: Double?
    var ymin: Double?
    var ymax: Double?
    
    
    init(variables: [ContinuousVariable]) {
        
        dataPoints = []
        
        let xvar: [ContinuousDataPoint]
        let yvar: [ContinuousDataPoint]
        
        //This stuff is jank, the only reason I'm unwrapping optionals is because this view is actually created in the previous screen before variables are selected. Leaving this because it can possible fix itself once I change the UI, but otherwise there should be a more permanent solution.
        if let x = variables.first {
            xvar = x.valuesArray
        } else {
            xvar = []
        }
        
        if let y = variables.last {
            yvar = y.valuesArray
        } else {
            yvar = []
        }
        
        for (x, y) in zip(xvar, yvar) {
            
            let point = Point(id: UUID(), xValue: x, yValue: y)
            dataPoints.append(point)
            
            //            //Only assisnging these so it has a default value that the min function can compare with, this is also jank
            self.xmin = point.xValue.value
            self.xmax = point.xValue.value * 1.33
            self.ymin = point.yValue.value
            self.ymax = point.yValue.value * 1.33
            
            self.xmin = min(xmin!, point.xValue.value)
            self.xmax = max(xmax!, point.xValue.value)
            self.ymin = min(ymin!, point.yValue.value)
            self.ymax = min(ymax!, point.yValue.value)
            
        }
    }
    
    var body: some View {
        ZStack {
            HStack {
                ForEach(0..<10) { _ in
                    Group {
                        Divider().background(Color.gray)
                        Spacer()
                    }
                }
                Divider().background(Color.gray)
            }
            
            GeometryReader { geometry in
                ForEach(dataPoints) { point in
                    Circle()
                        .position(x: geometry.size.width * (CGFloat(point.xValue.value)/CGFloat(self.xmax!)), y: geometry.size.width - geometry.size.width * (CGFloat(point.xValue.value)/CGFloat(self.ymax!)))
                        .frame(width: 15)
                        .onTapGesture {
                            print(point.xValue.value, point.yValue.value)
                        }
                }
            }
        }
    }
    
}

struct Point: Identifiable {
    
    var id: UUID
    var xValue: ContinuousDataPoint
    var yValue: ContinuousDataPoint
    
}

//struct ScatterplotView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScatterplotView(xvar: <#[ContinuousData]#>, yvar: <#[ContinuousData]#>)
//    }
//}
