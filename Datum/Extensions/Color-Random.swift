//
//  Color-Random.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-29.
//

import SwiftUI

extension Color {
    
    static func random() -> Color {
        
        let colors = [Color.red, Color.green, Color.blue, Color.orange, Color.yellow, Color.pink, Color.purple]
        
        return colors.randomElement()!
        
    }

}

