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
            Button("Add Continuous") {
                let continous = ContinuousVariable(context: PersistenceController.shared.container.viewContext)
                continous.name = "Test"
                continous.id = UUID()
                vm.dataset.addToContinuousData(continous)
                PersistenceController.shared.container.viewContext.safeSave()
            }
            Button("Add Categorical") {
                let continous = CategoricalVariable(context: PersistenceController.shared.container.viewContext)
                continous.name = "Test"
                continous.id = UUID()
                vm.dataset.addToCategoricalData(continous)
                PersistenceController.shared.container.viewContext.safeSave()
            }
            List {
                Section(header: Text("Continuous Variables")) {
                    ForEach(vm.continuousVariables) { variable in
                        HStack {
                            Text(variable.wrappedName)
                            Text("\(variable.dataset!.wrappedName)")
                        }
                    }
                }
                Section(header: Text("Categorical Variables")) {
                    ForEach(vm.categoricalVariables) { variable in
                        HStack {
                            Text(variable.wrappedName)
                            Text("\(variable.dataset!.wrappedName)")
                        }
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
    
    static let moc = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        
        func getDataset() -> Dataset? {
            do {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: Dataset.entity().name!)
                request.sortDescriptors = [NSSortDescriptor(keyPath: \Dataset.name, ascending: true)]
                
                let result = try moc.fetch(request) as? [Dataset]
                if !result!.isEmpty {
                    return result?.first!
                } else {
                    return nil
                }
            } catch {
                print("Could not fetch datasets")
                return nil
            }
        }
        return DatasetView(dataset: getDataset()!)
    }
}
