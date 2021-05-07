//
//  AddCategoricalVariableView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-15.
//

import SwiftUI

struct AddCategoricalVariableView: View {
    
    let variable: CategoricalVariable
    
    @Binding var selected: Category
    
    var body: some View {
        
        VStack {
            HStack {
                Text("\(variable.wrappedName):")
                    .font(.headline)
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(variable.categoriesArray) { variable in
                        
                        Text(variable.name!)
                            .font(.subheadline)
                            .foregroundColor(variable == selected ? .accentColor : .black)
                            .onTapGesture {
                                selected = variable
                            }
                            .padding(.horizontal)
                            .overlay(
                                Capsule(style: .circular)
                                    .stroke(variable == selected ? Color.accentColor : Color.black, lineWidth: 1)
                                    .frame(height: 40)
                            )
                    }
                }
                .frame(height: 50)
            }
            
            
        }
        
    }
}

//struct AddCategoricalVariableView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCategoricalVariableView()
//    }
//}
