//
//  ContentView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Dataset.name, ascending: true)],
        animation: .default)
    private var datasets: FetchedResults<Dataset>

    @State private var destination = SheetDestination.addDatasetView
    @State var showSheet = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    List {
                        ForEach(datasets) { dataset in
                            NavigationLink(destination: DatasetView(dataset: dataset)) {
                                Text(dataset.wrappedName)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .navigationBarItems(trailing: Button("Add Dataset") {showAddDatasetView()})
            .sheet(isPresented: $showSheet) {
                switch destination {
                case .addDatasetView:
                    AddDatasetView()
                }
            }
        }
    }
    
    private func showAddDatasetView() {
        destination = .addDatasetView
        showSheet = true
    }

    enum SheetDestination {
        case addDatasetView
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { datasets[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
