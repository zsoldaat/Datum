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
        
        HStack {
            Text(variable.wrappedName)
            
            Divider()
            
            Spacer()
            
            List {
                ForEach(variable.categoriesArray) { variable in
                    
                    HStack {
                        Text(variable.name!).foregroundColor(variable == selected ? .blue : .black)
                    }
                    .onTapGesture {
                        selected = variable
                    }
                }
            }
        }
        
    }
}

//struct AddCategoricalVariableView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCategoricalVariableView()
//    }
//}
