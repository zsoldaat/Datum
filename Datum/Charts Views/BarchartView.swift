//
//  BarchartView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-27.
//

import SwiftUI

struct BarchartView: View {
    
    let categoricalVariable: CategoricalVariable?
    
    init(categoricalVariables: [CategoricalVariable]) {
        
        if let variable = categoricalVariables.first {
            self.categoricalVariable = variable
        } else {
            categoricalVariable = nil
        }
    }
    
    
    var body: some View {
        List {
            
            ForEach(categoricalVariable!.categoriesArray) { category in
                Text(category.name!)
            }
            
            
        }
    }
}

//struct BarchartView_Previews: PreviewProvider {
//    static var previews: some View {
//        BarchartView()
//    }
//}
