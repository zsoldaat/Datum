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
                List {
                    ForEach(vm.datasets) { dataset in
                        HStack {
                            Button {
                                self.selectedDataset = dataset
                                vm.showSheet(.addObservationView)
                            } label: {
                                VStack {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    Text("New Data")
                                        .font(.footnote)
                                }
                                    
                            }
                            .frame(width: 75, height: 75)
                            .buttonStyle(PlainButtonStyle())
                            
                            Spacer()
                            
                            NavigationLink(destination: DatasetView(dataset: dataset)) {
                                VStack(alignment: .leading) {
                                    Text(dataset.wrappedName)
                                        .font(.title)
                                    ForEach(dataset.continuousArray) { continuous in
                                        Text(continuous.wrappedName)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    ForEach(dataset.categoricalArray) { categorical in
                                        Text(categorical.wrappedName)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationBarItems(trailing:
                                    Button(
                                        action: {vm.showSheet(.addDatasetView)}
                                    ){
                                        Image(systemName: "plus")
                                    }
            )
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
