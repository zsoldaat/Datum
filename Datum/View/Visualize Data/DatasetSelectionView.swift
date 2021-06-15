//
//  VariableSelectionView3.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-06-14.
//

import SwiftUI

struct DatasetSelectionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let datasets: [Dataset]
    
    @State var selectedDataset: Dataset?
    
    @Binding var visualizationManager: VisualizationManager

    var body: some View {
        Form {
            Section(header: Text("Datasets")) {
                List {
                    ForEach(datasets) { dataset in
                        HStack {
                            Text(dataset.wrappedName)
                                .foregroundColor(dataset.hasVariables ? .black : .secondary)
                                .onTapGesture {
                                    selectedDataset = dataset
                                    visualizationManager.dataset = dataset
                                }
                                .disabled(!dataset.hasVariables)
                            Spacer()
                            
                            Image(systemName: selectedDataset == dataset ? "checkmark" : "")
                                .foregroundColor(.accentColor)
                            
                            if !dataset.hasVariables {
                                Text("No Data")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
            }
            
            DoneButton {presentationMode.wrappedValue.dismiss()}
        }
    }
}

//struct VariableSelectionView3_Previews: PreviewProvider {
//    static var previews: some View {
//        VariableSelectionView3()
//    }
//}
