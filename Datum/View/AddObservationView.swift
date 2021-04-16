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
                    AddContinuousVariableView(variable: variable, newValue: continuousBinding(for: variable))
                }
                ForEach(vm.categoricalVariables) { variable in
                    AddCategoricalVariableView(variable: variable, selected: categoricalBinding(for: variable))
                }
            }
            
            Section {
                Button("Done") {
                    vm.addObservation()
                }
            }
            
        }
        .alert(isPresented: $vm.alertShowing) {
            Alert(title: Text(vm.alertMessage))
        }

    }
    
    //Custom Bindings for dictionary values in ViewModel
    func continuousBinding(for key: ContinuousVariable) -> Binding<String> {
        return Binding(
            get: {
                return vm.continuousDict[key] ?? ""
            },
            set: { newValue in
                vm.continuousDict[key] = newValue
            }
        )
    }
    
    func categoricalBinding(for key: CategoricalVariable) -> Binding<Category> {
        return Binding(
            get: {
                return vm.categoricalDict[key]!
            },
            set: { newValue in
                vm.categoricalDict[key] = newValue
            }
        )
    }
}

//struct AddObservationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddObservationView()
//    }
//}
