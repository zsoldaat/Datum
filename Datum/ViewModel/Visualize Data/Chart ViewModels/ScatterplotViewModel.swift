//
//  ScatterplotViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-06-17.
//

import Foundation
import CoreGraphics

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
        }
        
        xmax = self.nearestMultipleOf5(xmax)
        ymax = self.nearestMultipleOf5(ymax)
    }
    
    func nearestMultipleOf5(_ value: Double) -> Double {
        let remainder = value.truncatingRemainder(dividingBy: 5)
        
        if remainder == 0 {
            return value
        } else {
            return value + 5 - remainder
        }
    }
    
    struct Point: Identifiable {
        var id: UUID
        var xValue: ContinuousDataPoint
        var yValue: ContinuousDataPoint
    }
    
    
}

