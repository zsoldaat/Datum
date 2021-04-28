//
//  DatasetView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import SwiftUI
import CoreData

struct DatasetView: View {
    
    @ObservedObject var vm: DatasetViewModel
    
    init(dataset: Dataset) {
        self.vm = DatasetViewModel(dataset: dataset)
    }
    
    var body: some View {
        Form {
            List {
//                Section {
//                    NavigationLink(
//                        destination: ChartTypesView(dataset: vm.dataset),
//                        label: {
//                            Text("Visualize")
//                        })
//                }
                
                Section(header: Text("Continuous Variables")) {
                    ForEach(vm.continuousVariables) { variable in
                        Text(variable.wrappedName)
                    }
                }
                Section(header: Text("Categorical Variables")) {
                    ForEach(vm.categoricalVariables) { variable in
                        Text(variable.wrappedName)
                    }
                }
                
                
            }
        }
        .navigationBarTitle(Text(vm.dataset.wrappedName))
        .navigationBarItems(trailing: Button("Manage Variables") { vm.showAddVariableView()})
        .sheet(isPresented: $vm.showSheet) {
            switch vm.destination {
            case .addVariableView:
                AddVariableView(dataset: vm.dataset)
            }
        }
    }
}

struct DatasetView_Previews: PreviewProvider {
    
    static var previews: some View {
        DatasetView(dataset: DatasetStorage.shared.datasets.value.first!)
    }
}
