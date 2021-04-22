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
        .onAppear(perform: LocationFetcher.shared.start)
    }
    
    //Custom Bindings for dictionary values in ViewModel
    func continuousBinding(for variable: ContinuousVariable) -> Binding<String> {
        return Binding(
            get: {
                return vm.continuousDict[variable] ?? ""
            },
            set: { newValue in
                vm.continuousDict[variable] = newValue
            }
        )
    }
    
    func categoricalBinding(for variable: CategoricalVariable) -> Binding<Category> {
        return Binding(
            get: {
                return vm.categoricalDict[variable]!
            },
            set: { newValue in
                vm.categoricalDict[variable] = newValue
            }
        )
    }
}

//struct AddObservationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddObservationView()
//    }
//}
