//
//  VariableSelectionView2.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-21.
//

import SwiftUI

struct VariableSelectionView2: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let datasets: [Dataset]
    
    @Binding var visualizationManager: VisualizationManager
    
    //This variable was going to be used to only allow one dataset to be open at a time
    @State var selectedDataset: Dataset?
    
    var body: some View {
        
        VStack {
            if visualizationManager.chart.continuousVariablesRequired > 0 {
                Text("\(visualizationManager.selectedContinuous.count) / \(visualizationManager.chart.continuousVariablesRequired) continuous variables selected.")
            }
            
            if visualizationManager.chart.categoricalVariablesRequired > 0 {
                Text("\(visualizationManager.selectedCategorical.count) / \(visualizationManager.chart.categoricalVariablesRequired) categorical variables selected.")
            }
            List {
                ForEach(datasets) { dataset in
                    DatasetCellView(dataset: dataset, selectedDataset: $selectedDataset, visualizationManager: $visualizationManager)
                        .onTapGesture {
                            selectedDataset = dataset
                            visualizationManager.dataset = dataset
                        }
                        .animation(.linear)
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            DoneButton {presentationMode.wrappedValue.dismiss()}
        }

    }
    
    struct DatasetCellView: View {
        
        let dataset: Dataset
        
        @Binding var selectedDataset: Dataset?
        
        @Binding var visualizationManager: VisualizationManager
        
        var body: some View {
            DisclosureGroup {
                VStack(alignment: .leading) {
                    ForEach(dataset.categoricalArray) { categorical in
                        HStack {
                            Text(categorical.wrappedName)
                                .font(.body)
                                .foregroundColor(categorical.isSelected ? .accentColor : .white)
                                .onTapGesture {
                                    visualizationManager.selectVariable(categorical)
                                }
                            
                            Spacer()
                            
                            Text("Categorical")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
//                            Image(categorical.isSelected ? "checkmark" : "")
                        }
                    }
                    ForEach(dataset.continuousArray) { continuous in
                        HStack {
                            Text(continuous.wrappedName)
                                .font(.body)
                                .foregroundColor(continuous.isSelected ? .accentColor : .white)
                                .onTapGesture {
                                    visualizationManager.selectVariable(continuous)
                                }
                            
                            Spacer()
                            
                            Text("Continuous")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
//                            Image(continuous.isSelected ? "checkmark" : "")
                        }
                    }
                }
            } label: {
                Text(dataset.wrappedName)
                    .font(.title)
                    .foregroundColor(visualizationManager.dataset == dataset ? .accentColor : .white)
            }
        }
    }
}
//
//struct VariableSelectionView2_Previews: PreviewProvider {
//    static var previews: some View {
//        VariableSelectionView2()
//    }
//}
