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
        VStack(alignment: .leading) {
            
            Text("\(variable.wrappedName):")
                .font(.headline)
                
            
            HStack {
                
                TextField("Value", text: $newValue)
                    .keyboardType(.decimalPad)
                
                VStack(alignment: .leading) {
                    if variable.min != nil {
                        HStack {
                            Text("Minimum: ")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("\(variable.minString!)")
                                .font(.subheadline)
                        }
                    }
                    if variable.max != nil {
                        HStack {
                            Text("Maximum: ")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("\(variable.maxString!)")
                                .font(.subheadline)
                        }
                    }
                }
                .padding(.horizontal)
                .frame(height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: variable.max != nil || variable.min != nil ? 1 : 0)
                )
            }
            .frame(height: 50)
        }
    }
}

//struct AddContinuousVariableView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddContinuousVariableView()
//    }
//}
