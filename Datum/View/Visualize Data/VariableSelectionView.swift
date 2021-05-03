//
//  VariableSelectionView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-28.
//

import SwiftUI

struct VariableSelectionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let datasets: [Dataset]
    
    @Binding var visualizationManager: VisualizationManager
    
    //Since I'm only wanting one dataset selected at a time, this could be changed to hold just one dataset. Leaving it for now in case things change.
    @State private var selection: Set<Dataset> = []
    
    var body: some View {
        
        VStack {
            if visualizationManager.chart.continuousVariablesRequired > 0 {
                Text("\(visualizationManager.selectedContinuous.count) / \(visualizationManager.chart.continuousVariablesRequired) continuous variables selected.")
            }
            
            if visualizationManager.chart.categoricalVariablesRequired > 0 {
                Text("\(visualizationManager.selectedCategorical.count) / \(visualizationManager.chart.categoricalVariablesRequired) categorical variables selected.")
            }
            
            ScrollView {
                
                Text("Datasets")
                    .font(.title)
                
                Divider()
                
                ForEach(datasets) { dataset in
                    DatasetCellView(visualizationManager: $visualizationManager, dataset: dataset, isExpanded: selection.contains(dataset))
                        .onTapGesture {
                            visualizationManager.dataset = dataset
                            selectDeselect(dataset)
                        }
                        .modifier(ListRowModifier())
                        .animation(.linear(duration: 0.3))
                }
            }
            Button("Done") {presentationMode.wrappedValue.dismiss()}
        }
    }
    
    struct DatasetCellView: View {
        
        @Binding var visualizationManager: VisualizationManager
        
        let dataset: Dataset
        
        let isExpanded: Bool
        
        var body: some View {
            HStack {
                content
                Spacer()
            }
            .contentShape(Rectangle())
        }
        
        private var content: some View {
            VStack(alignment: .leading) {
                Text(dataset.wrappedName)
                    .font(.title2)
                    .foregroundColor(.blue)
                
                if isExpanded {
                    ForEach(dataset.categoricalArray) { categorical in
                        HStack {
                            Text(categorical.wrappedName)
                            Text("Categorical")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(categorical.isSelected ? "Selected" : "")
                        }
                        .onTapGesture {
                            visualizationManager.selectVariable(categorical)
                        }
                    }
                    
                    ForEach(dataset.continuousArray) { continuous in
                        HStack {
                            Text(continuous.wrappedName)
                            Text("Continuous")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(continuous.isSelected ? "Selected" : "")
                        }
                        .onTapGesture {
                            visualizationManager.selectVariable(continuous)
                        }
                    }
                }
            }
        }
    }
    
    private func selectDeselect(_ dataset: Dataset) {
        selection.removeAll()
        selection.insert(dataset)
//        if selection.contains(dataset) {
//            selection.remove(dataset)
//        } else {
//            selection.insert(dataset)
//        }
    }
    
    struct ListRowModifier: ViewModifier {
        func body(content: Content) -> some View {
            Group {
                content
                Divider()
            }.offset(x: 20)
        }
    }
}

//struct VariableSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        VariableSelectionView()
//    }
//}
