//
//  AddVariableView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-08.
//

import SwiftUI
import CoreData

struct AddVariableView: View {
    
    @ObservedObject var vm: AddVariableViewModel
    
    init(dataset: Dataset) {
        self.vm = AddVariableViewModel(dataset: dataset)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Variable Name", text: $vm.newVariableName)
                Button("\(vm.newVariableType.rawValue.capitalized)") {vm.toggleVariableType()}
                
                if vm.newVariableType == .categorical {
                    VStack {
                        List {
                            Text("Categories").font(.headline)
                            
                            ForEach(vm.newVariableCategories, id: \.self) { category in
                                Text(category)
                            }
                        }
                        
                        TextField("Name", text: $vm.newCategoryName)
                        
                        Button("Add Category") {
                            vm.addCategoryName()
                        }

                    }
                    
                } else {
                    VStack {
                        TextField("Minumum Value", text: $vm.newVariableMin)
                            .keyboardType(.decimalPad)
                        TextField("Maximum Value", text: $vm.newVariableMax)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            
            Section {
                Button("Add Variable") {
                    vm.addVariable()
                }
            }
            
            List {
                Section(header: Text("Continuous Variables")) {
                    ForEach(vm.dataset.continuousArray) { continuous in
                        Text(continuous.wrappedName)
                    }
                }
                
                Section(header: Text("Categorical Variables")) {
                    ForEach(vm.dataset.categoricalArray) { categorical in
                        Text(categorical.wrappedName)
                    }
                }
            }
        }
        .alert(isPresented: $vm.alertShowing) {
            Alert(title: Text(vm.alertMessage))
        }
    }
    
}

struct AddVariableView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        AddVariableView(dataset: DatasetStorage.shared.datasets.value.first!)
    }
}
