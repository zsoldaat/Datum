//
//  DatasetView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import SwiftUI
import CoreData

struct DatasetView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    var dataset: Dataset
    var continuousFetchRequest: FetchRequest<ContinuousVariable>
    var categoricalFetchRequest: FetchRequest<CategoricalVariable>
    
    @State var showSheet = false
    @State private var destination: SheetDestination = .addVariableView
    
    init(dataset: Dataset) {
        
        self.dataset = dataset
        self.continuousFetchRequest = FetchRequest<ContinuousVariable>(entity: ContinuousVariable.entity(), sortDescriptors: [], predicate: NSPredicate(format: "dataset = %@", dataset), animation: .default)
        self.categoricalFetchRequest = FetchRequest<CategoricalVariable>(entity: CategoricalVariable.entity(), sortDescriptors: [], predicate: NSPredicate(format: "dataset = %@", dataset), animation: .default)
        
    }
    
    var body: some View {
        Form {
            Text(dataset.wrappedName)
            List {
                Section(header: Text("Continuous Variables")) {
                    ForEach(continuousFetchRequest.wrappedValue) { variable in
                        Text(variable.wrappedName)
                    }
                }
                Section(header: Text("Categorical Variables")) {
                    ForEach(categoricalFetchRequest.wrappedValue) { variable in
                        Text(variable.wrappedName)
                    }
                }
            }
        }
        .navigationBarTitle(Text(dataset.wrappedName))
        .navigationBarItems(trailing: Button("Manage Variables") { showAddVariableView()})
        .sheet(isPresented: $showSheet) {
            switch destination {
            case .addVariableView:
                AddVariableView(dataset: dataset).environment(\.managedObjectContext, viewContext)
            }
        }
    }
    
    enum SheetDestination {
        case addVariableView
    }
    
    func showAddVariableView() {
        destination = .addVariableView
        showSheet = true
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
