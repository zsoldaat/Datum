//
//  ScatterplotView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import SwiftUI

struct ScatterplotView: View {
    
    let xvar: ContinuousVariable
    let yvar: ContinuousVariable
    
    
    var body: some View {
        List {
            ForEach(Array(arrayLiteral: xvar.values!), id: \.self) { value in
                Text("\(value)")
            }
            
            ForEach(Array(arrayLiteral: yvar.values!), id: \.self) { value in
                Text("\(value)")
            }
        }
    }
    
    
}

//struct ScatterplotView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScatterplotView(xvar: <#[ContinuousData]#>, yvar: <#[ContinuousData]#>)
//    }
//}
