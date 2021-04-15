//
//  AddDatasetView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import SwiftUI

struct AddDatasetView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var vm = AddDatasetViewModel()
    
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
                        vm.showAlert()
                    }
                }
            }
        }.alert(isPresented: $vm.alertShowing) {
            Alert(title: Text(vm.alertMessage))
        }
    }
    
}

struct AddDatasetView_Previews: PreviewProvider {
    static var previews: some View {
        AddDatasetView()
    }
}
