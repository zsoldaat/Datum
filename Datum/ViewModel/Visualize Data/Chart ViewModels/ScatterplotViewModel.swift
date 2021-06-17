//
//  ScatterplotViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-06-17.
//

import Foundation

class ScatterplotViewModel: ObservableObject {
    
    @Published var dataPoints: [Point]
    @Published var xmin: Double
    @Published var xmax: Double
    @Published var ymin: Double
    @Published var ymax: Double
    
    init(xvar: ContinuousVariable, yvar: ContinuousVariable) {
        self.dataPoints = []
        
        let x = xvar.valuesArray
        let y = yvar.valuesArray
        
        self.xmin = x.min{$0.value < $1.value}!.value
        self.xmax = x.max{$0.value < $1.value}!.value
        self.ymin = y.min{$0.value < $1.value}!.value
        self.ymax = y.max{$0.value < $1.value}!.value
        
        for (x, y) in zip(x, y) {
            
            let point = Point(id: UUID(), xValue: x, yValue: y)
            dataPoints.append(point)
            
            //Only assigning these so it has a default value that the min function can compare with, this is also jank
//            self.xmin = point.xValue.value
//            self.xmax = point.xValue.value
//            self.ymin = point.yValue.value
//            self.ymax = point.yValue.value
//            
//            self.xmin = min(xmin!, point.xValue.value)
//            self.xmax = max(xmax!, point.xValue.value)
//            self.ymin = min(ymin!, point.yValue.value)
//            self.ymax = min(ymax!, point.yValue.value)
            
        }
    }
    
    struct Point: Identifiable {
        
        var id: UUID
        var xValue: ContinuousDataPoint
        var yValue: ContinuousDataPoint
        
    }
    
    
}

