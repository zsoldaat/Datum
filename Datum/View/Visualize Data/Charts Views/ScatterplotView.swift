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
            self.xmax = point.xValue.value
            self.ymin = point.yValue.value
            self.ymax = point.yValue.value
            
            self.xmin = min(xmin!, point.xValue.value)
            self.xmax = max(xmax!, point.xValue.value)
            self.ymin = min(ymin!, point.yValue.value)
            self.ymax = min(ymax!, point.yValue.value)
            
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                //Scatterplot
                ForEach(dataPoints) { point in
                    Circle()
                        .frame(width: 10)
                        .foregroundColor(.blue)
                        .position(
                            x: geometry.size.width * CGFloat(point.xValue.value / xmax!),
                            y: geometry.size.height - geometry.size.height * CGFloat(point.yValue.value / ymax!)
                        )
                        .onTapGesture {
                            //Change this to actually display the point on screen
//                            print(point.xValue.value, point.yValue.value)
                        }
                }
                
                //Horizontal Grid
                ForEach(0..<Int(ymax!+1)) { number in
                    ZStack {
                        Text("\(number)")
                            .offset(x:-geometry.size.width/2 - 10, y:0)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)

                    }
                    .position(
                        x: geometry.size.width / 2,
                        y: geometry.size.height - CGFloat(number) * geometry.size.height / CGFloat(ymax!)
                    )
                }
                
                //Vertical Grid
                ForEach(0..<Int(xmax!+1)) { number in
                    ZStack {
                        Text(number != 0 ? "\(number)" : "")
                            .offset(x:0, y: geometry.size.height/2 + 10)
                        Rectangle()
                            .frame(width: 1)
                            .foregroundColor(.gray)

                    }
                    .position(
                        x: CGFloat(number) * geometry.size.width / CGFloat(xmax!),
                        y: geometry.size.height / 2
                    )
                }
                
                //Visual Guide
//                Rectangle().strokeBorder(lineWidth: 2).foregroundColor(.red)
                
                FloatingCloseButton()
            }
        }
        .padding()
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
