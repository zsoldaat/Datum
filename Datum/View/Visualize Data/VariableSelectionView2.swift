//
//  VariableSelectionView2.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-21.
//

import SwiftUI

struct VariableSelectionView2: View {
    
    let datasets: [Dataset]
    
    @Binding var visualizationManager: VisualizationManager
    
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
                    DatasetCellView(dataset: dataset, selectedDataset: $selectedDataset)
                        .onTapGesture {
                            selectedDataset = dataset
                        }
                        .animation(.linear)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }

    }
    
    struct DatasetCellView: View {
        
        let dataset: Dataset
        
        @Binding var selectedDataset: Dataset?
        
        var body: some View {
            DisclosureGroup {
                VStack {
                    ForEach(dataset.categoricalArray) { categorical in
                        HStack {
                            Text(categorical.wrappedName)
                                .font(.body)
                                .onTapGesture {
                                    categorical.isSelected.toggle()
                                    print("Hello")
                                }
                            Image(categorical.isSelected ? "checkmark" : "")
                        }
                    }
                    ForEach(dataset.continuousArray) { continuous in
                        HStack {
                            Text(continuous.wrappedName)
                                .font(.body)
                                .onTapGesture {
                                    continuous.isSelected.toggle()
                                    print("Hello")
                                }
                            Image(continuous.isSelected ? "checkmark" : "")
                        }
                    }
                }
            } label: {
                Text(dataset.wrappedName)
                    .font(.title)
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
