//
//  ContentView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @ObservedObject var vm = ContentViewModel()

    @State private var destination = SheetDestination.addDatasetView
    @State var showSheet = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    List {
                        ForEach(vm.datasets) { dataset in
                            NavigationLink(destination: DatasetView(dataset: dataset)) {
                                Text(dataset.wrappedName)
                            }
                        }
                        .onDelete(perform: vm.deleteItems)
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
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
