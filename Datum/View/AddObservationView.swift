//
//  AddObservationView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-15.
//

import SwiftUI

struct AddObservationView: View {
    
    @ObservedObject var vm: AddObservationViewModel
    
    init(dataset: Dataset) {
        self.vm = AddObservationViewModel(dataset: dataset)
    }

    var body: some View {
        
        Form {
            Section {
                ForEach(vm.continuousVariables) { variable in
                    AddContinuousVariableView(variable: variable)
                }
                ForEach(vm.categoricalVariables) { variable in
                    AddCategoricalVariableView(variable: variable)
                }
            }
        }
        
        
    }
}

//struct AddObservationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddObservationView()
//    }
//}
