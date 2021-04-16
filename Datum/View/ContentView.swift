//
//  ContentView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = ContentViewModel()

    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    Button("Add Dataset") {vm.showSheet(.addDatasetView)}
                }
                
                Section {
                    List {
                        ForEach(vm.datasets) { dataset in
                            
                            if vm.isInEditMode {
                                NavigationLink(destination: DatasetView(dataset: dataset)) {
                                    HStack {
                                        Text(dataset.wrappedName)
                                        Spacer()
                                        Text("DatasetView").foregroundColor(.red)
                                    }
                                }
                            } else {
                                NavigationLink(destination: AddObservationView(dataset: dataset)) {
                                    HStack {
                                        Text(dataset.wrappedName)
                                        Spacer()
                                        Text("AddObservationView").foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .onAppear {vm.isInEditMode = false}
            .navigationBarItems(trailing: Button(vm.isInEditMode ? "Done" : "Edit") { vm.isInEditMode.toggle()} )
            .sheet(isPresented: $vm.showingSheet) {
                switch vm.destination {
                case .addDatasetView:
                    AddDatasetView()
                }
            }
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
