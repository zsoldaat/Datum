//
//  AddDatasetView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import SwiftUI

struct AddDatasetView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var datasetName = ""
    @State private var alertShowing = false
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $datasetName)
            }
            Section {
                Button("Save") {
                    if !datasetName.isEmpty {
                        addDataset()
                    } else {
                        showAlert()
                    }
                }
            }
        }.alert(isPresented: $alertShowing) {
            Alert(title: Text(alertMessage))
        }
    }
    
    func addDataset() {
        let newDataset = Dataset(context: viewContext)
        newDataset.name = datasetName
        newDataset.id = UUID()
        
        viewContext.safeSave()

        presentationMode.wrappedValue.dismiss()
    }
    
    func showAlert() {
        alertMessage = "Name cannot be blank"
        alertShowing = true
    }
}

struct AddDatasetView_Previews: PreviewProvider {
    static var previews: some View {
        AddDatasetView()
    }
}
