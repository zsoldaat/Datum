//
//  VariableSelectionView3.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-06-14.
//

import SwiftUI

struct VariableSelectionView3: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let datasets: [Dataset]
    
    @State var selectedDataset: Dataset?
    
    @Binding var visualizationManager: VisualizationManager

    var body: some View {
        Form {
//            if visualizationManager.chart.continuousVariablesRequired > 0 {
//                Text("\(visualizationManager.selectedContinuous.count) / \(visualizationManager.chart.continuousVariablesRequired) continuous variables selected.")
//            }
//
//            if visualizationManager.chart.categoricalVariablesRequired > 0 {
//                Text("\(visualizationManager.selectedCategorical.count) / \(visualizationManager.chart.categoricalVariablesRequired) categorical variables selected.")
//            }
            
            Section(header: Text("Datasets")) {
                List {
                    ForEach(datasets) { dataset in
                        Text(dataset.wrappedName)
                            .foregroundColor(dataset == selectedDataset ? .accentColor : .black)
                            .onTapGesture {
                                selectedDataset = dataset
                                visualizationManager.dataset = dataset
                            }
                    }
                }
                
            }
            
            //animate this when the dataset changes, might have to do it by creating a new array that will contain the variables of the selected dataset
            
//            Section(header: Text("Variables")) {
//                List {
//                    ForEach(selectedDataset?.continuousArray ?? []) { continuous in
//                        HStack {
//                            Text(continuous.wrappedName)
//                                .foregroundColor(continuous.isSelected ? .accentColor : .black)
//                            Spacer()
//                            Text("Continuous")
//                        }
//                        .onTapGesture {
//                            visualizationManager.selectVariable(continuous)
//                        }
//                    }
//
//                    ForEach(selectedDataset?.categoricalArray ?? []) { categorical in
//                        HStack {
//                            Text(categorical.wrappedName)
//                                .foregroundColor(categorical.isSelected ? .accentColor : .black)
//                            Spacer()
//                            Text("Categorical")
//                        }
//                        .onTapGesture {
//                            visualizationManager.selectVariable(categorical)
//                        }
//                    }
//                }
//            }
            
            DoneButton {presentationMode.wrappedValue.dismiss()}
        }
    }
}

//struct VariableSelectionView3_Previews: PreviewProvider {
//    static var previews: some View {
//        VariableSelectionView3()
//    }
//}
