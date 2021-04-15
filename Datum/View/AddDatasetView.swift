//
//  AddDatasetView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import SwiftUI

struct AddDatasetView: View {
    
    @ObservedObject var vm = AddDatasetViewModel()
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
//    @State private var datasetName = ""
    @State private var alertShowing = false
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $vm.datasetName)
            }
            Section {
                Button("Save") {
                    if !vm.datasetName.isEmpty {
                        vm.addDataset()
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        showAlert()
                    }
                }
            }
        }.alert(isPresented: $alertShowing) {
            Alert(title: Text(alertMessage))
        }
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
