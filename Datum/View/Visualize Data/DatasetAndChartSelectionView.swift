//
//  DatasetAndChartSelectionView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-28.
//

import SwiftUI

struct DatasetAndChartSelectionView: View {
    
    @ObservedObject var vm = DatasetAndChartSelectionViewModel()
    
    @State private var sheetPresented = false
    @State private var selection: Set<Dataset> = []
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Chart Type")) {
                        Text(vm.visualizationManager.selectedChartType.rawValue.capitalized)
                            .onTapGesture {
                                vm.destination = .chartTypeSelection
                                sheetPresented = true
                            }
                    }
                    
                    Section(header: Text("Dataset")) {
                        Text(vm.visualizationManager.dataset?.wrappedName ?? "Select a dataset")
                            .onTapGesture {
                                vm.destination = .variableSelection
                                sheetPresented = true
                            }
                    }
                    
                    Section(header: Text("Continuous Variables")) {
                        ForEach(vm.visualizationManager.selectedContinuous) { continuous in
                            Text(continuous.wrappedName)
                        }
                    }
                    
                    Section(header: Text("Categorical Variables")) {
                        ForEach(vm.visualizationManager.selectedCategorical) { categorical in
                            Text(categorical.wrappedName)
                        }
                    }
                }
            }
            .sheet(isPresented: $sheetPresented) {
                switch vm.destination {
                
                case .chartTypeSelection:
                    ChartTypeSelectionView(visualizationManager: $vm.visualizationManager)
                case .variableSelection:
                    VariableSelectionView(datasets: vm.allDatasets, visualizationManager: $vm.visualizationManager)
                }
            }
        }
    }
}

struct DatasetAndChartSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DatasetAndChartSelectionView()
    }
}
