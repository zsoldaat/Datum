//
//  AddContinuousVariableView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-15.
//

import SwiftUI

struct AddContinuousVariableView: View {
    
    let variable: ContinuousVariable
    
    @Binding var newValue: String
    
    var body: some View {
        HStack {
            
            Text(variable.wrappedName)
            
            Spacer()
            
            if variable.min != nil {
                Text("\(variable.minString!) < ")
            }
            
            TextField("Value", text: $newValue)
                .keyboardType(.decimalPad)
                .frame(width: 100) //TODO: this should not be hardcoded
            
            if variable.max != nil {
                Text(" < \(variable.maxString!)")
            }
            

        }
    }
}

//struct AddContinuousVariableView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddContinuousVariableView()
//    }
//}
