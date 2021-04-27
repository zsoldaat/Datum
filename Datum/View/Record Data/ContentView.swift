//
//  ContentView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = ContentViewModel()
    
    @State private var selectedDataset: Dataset? = nil

    var body: some View {
        NavigationView {
            Form {
                Section {
                    List {
                        ForEach(vm.datasets) { dataset in
                            HStack {
                                Button {
                                    self.selectedDataset = dataset
                                    vm.showSheet(.addObservationView)
                                } label: {
                                    Image(systemName: "plus")
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Spacer()
                                
                                NavigationLink(destination: DatasetView(dataset: dataset)) {
                                    HStack {
                                        Text(dataset.wrappedName)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .navigationBarItems(trailing: Button("Add Dataset") {vm.showSheet(.addDatasetView)})
            .sheet(isPresented: $vm.showingSheet) {
                switch vm.destination {
                case .addDatasetView:
                    AddDatasetView()
                case .addObservationView:
                    AddObservationView(dataset: selectedDataset!)
                }
            }
            .navigationBarTitle("All Datasets")
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            vm.deleteItems(offsets: offsets)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
