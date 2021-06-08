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
        }

    }
    
    struct DatasetCellView: View {
        
        let dataset: Dataset
        
        @Binding var selectedDataset: Dataset?
        
        @Binding var visualizationManager: VisualizationManager
        
        var body: some View {
            DisclosureGroup {
                VStack {
                    ForEach(dataset.categoricalArray) { categorical in
                        HStack {
                            Text(categorical.wrappedName)
                                .font(.body)
                                .foregroundColor(categorical.isSelected ? .accentColor : .white)
                                .onTapGesture {
                                    visualizationManager.selectVariable(categorical)
                                    print("Hello")
                                }
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
                                    print("Hello")
                                }
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
