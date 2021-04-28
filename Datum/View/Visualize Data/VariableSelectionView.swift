//
//  VariableSelectionView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-28.
//

import SwiftUI

struct VariableSelectionView: View {
    
    let datasets: [Dataset]
    
    @Binding var visualizationManager: VisualizationManager
    
    @State private var selection: Set<Dataset> = []
    
    var body: some View {
        ScrollView {
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
    }
    
    private func selectDeselect(_ dataset: Dataset) {
        if selection.contains(dataset) {
            selection.remove(dataset)
        } else {
            selection.insert(dataset)
        }
    }
    
    struct ListRowModifier: ViewModifier {
        func body(content: Content) -> some View {
            Group {
                content
                Divider()
            }.offset(x: 20)
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
                Text(dataset.wrappedName).font(.headline)
                
                if isExpanded {
                    if dataset.hasCategoricalVariables {
                        Text("Categorical Variables")
                    }
                    
                    ForEach(dataset.categoricalArray) { categorical in
                        HStack {
                            Text(categorical.wrappedName)
                            Spacer()
                            Text(categorical.isSelected ? "Selected" : "")
                        }
                        .onTapGesture {
                            visualizationManager.selectVariable(categorical)
                        }
                    }
                    
                    if dataset.hasContinuousVariables {
                        Text("Continuous Variables")
                    }
                    
                    ForEach(dataset.continuousArray) { continuous in
                        HStack {
                            Text(continuous.wrappedName)
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
}

//struct VariableSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        VariableSelectionView()
//    }
//}
