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
    
    
    init(xvar: ContinuousVariable?, yvar: ContinuousVariable?) {
        
        dataPoints = []
        
        let x: [ContinuousDataPoint]
        let y: [ContinuousDataPoint]

        x = xvar?.valuesArray ?? []
        y = yvar?.valuesArray ?? []
        
        for (x, y) in zip(x, y) {
            
            let point = Point(id: UUID(), xValue: x, yValue: y)
            dataPoints.append(point)
            
            //Only assisnging these so it has a default value that the min function can compare with, this is also jank
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
