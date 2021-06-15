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
                    
                    Section(header: Text("Chart Type").foregroundColor(.accentColor)) {
                        Text(vm.visualizationManager.chart.type.properName)
                            .onTapGesture {
                                vm.destination = .chartTypeSelection
                                sheetPresented = true
                            }
                    }
                    
                    Section(header: Text("Dataset").foregroundColor(.accentColor)) {
                        Text(vm.visualizationManager.dataset?.wrappedName ?? "Select a dataset")
                            .onTapGesture {
                                vm.destination = .variableSelection
                                sheetPresented = true
                            }
                    }

                    Section {
                        if vm.visualizationManager.chart.continuousVariablesRequired > 0 {
                            Text("\(vm.visualizationManager.selectedContinuous.count) / \(vm.visualizationManager.chart.continuousVariablesRequired) continuous variables selected.")
                        }
                        
                        if vm.visualizationManager.chart.categoricalVariablesRequired > 0 {
                            Text("\(vm.visualizationManager.selectedCategorical.count) / \(vm.visualizationManager.chart.categoricalVariablesRequired) categorical variables selected.")
                        }
                    }
                    
                    if vm.visualizationManager.hasDatasetSelected {
                        Section(header: Text("Available Variables")) {
                            
                            if vm.visualizationManager.chart.continuousVariablesRequired > 0 {
                                ForEach(vm.visualizationManager.dataset?.continuousArray ?? []) { continuous in
                                    HStack {
                                        Text(continuous.wrappedName)
                                        Spacer()
                                        Text("Continuous")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .foregroundColor(continuous.isSelected ? .accentColor : .black)
                                    .onTapGesture {
                                        vm.visualizationManager.selectVariable(continuous)
                                    }
                                }
                            }
                            
                            if vm.visualizationManager.chart.categoricalVariablesRequired > 0 {
                                ForEach(vm.visualizationManager.dataset?.categoricalArray ?? []) { categorical in
                                    HStack {
                                        Text(categorical.wrappedName)
                                        Spacer()
                                        Text("Categorical")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .foregroundColor(categorical.isSelected ? .accentColor : .black)
                                    .onTapGesture {
                                        vm.visualizationManager.selectVariable(categorical)
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .fullScreenCover(isPresented: $sheetPresented) {
                    switch vm.destination {
                    case .chartTypeSelection:
                        ChartTypeSelectionView(visualizationManager: $vm.visualizationManager)
                    case .variableSelection:
                        VariableSelectionView3(datasets: vm.allDatasets, visualizationManager: $vm.visualizationManager)
                    case .barchart:
                        BarchartView(categoricalVariable: vm.visualizationManager.selectedCategorical.first)
                    case .scatterplot:
                        ScatterplotView(xvar: vm.visualizationManager.selectedContinuous.first, yvar: vm.visualizationManager.selectedContinuous.last)
                    case .mapView:
                        DatapointMapView(locations: vm.visualizationManager.locationCoordinates, region: vm.visualizationManager.mapRegion)
                    case .calendarView:
                        RootCalendarView(datesAndValues: vm.visualizationManager.averageValuesByDate)
                    }
                }
                .navigationTitle("Visualize")
                
                DoneButton{
                    showChart(chart: vm.visualizationManager.chart.type)
                }
                .disabled(!vm.visualizationManager.correctNumberOfVarsSelected)
            }
            
        }
    }
    
    func showChart(chart: Chart.ChartType) {
        switch chart {
        case .barchart:
            vm.destination = DatasetAndChartSelectionViewModel.Destination.barchart
        case .scatterplot:
            vm.destination = DatasetAndChartSelectionViewModel.Destination.scatterplot
        case .mapView:
            vm.destination = DatasetAndChartSelectionViewModel.Destination.mapView
        case .calendarView:
            vm.destination = DatasetAndChartSelectionViewModel.Destination.calendarView
        }
        sheetPresented = true
    }
    
}

struct DatasetAndChartSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DatasetAndChartSelectionView()
    }
}
