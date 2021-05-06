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
                        Text(vm.visualizationManager.chart.type.rawValue.capitalized)
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
                    
                    if !vm.visualizationManager.selectedContinuous.isEmpty {
                        Section(header: Text("Continuous Variables")) {
                            ForEach(vm.visualizationManager.selectedContinuous) { continuous in
                                Text(continuous.wrappedName)
                            }
                        }
                    }
                    
                    if !vm.visualizationManager.selectedCategorical.isEmpty {
                        Section(header: Text("Categorical Variables")) {
                            ForEach(vm.visualizationManager.selectedCategorical) { categorical in
                                Text(categorical.wrappedName)
                            }
                        }
                    }
                    
                    Button("Done") {
                        showChart(chart: vm.visualizationManager.chart.type)
                    }
                    .disabled(!vm.visualizationManager.correctNumberOfVarsSelected)
                    
                }
            }
            .fullScreenCover(isPresented: $sheetPresented) {
                switch vm.destination {
                case .chartTypeSelection:
                    ChartTypeSelectionView(visualizationManager: $vm.visualizationManager)
                case .variableSelection:
                    VariableSelectionView(datasets: vm.allDatasets, visualizationManager: $vm.visualizationManager)
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

//
//    @ViewBuilder func navigationLinkDestination() -> some View {
//        switch vm.visualizationManager.chart.type {
//        case .barchart:
//            BarchartView(categoricalVariable: vm.visualizationManager.selectedCategorical.first)
//        case .scatterplot:
//            ScatterplotView(xvar: vm.visualizationManager.selectedContinuous.first, yvar: vm.visualizationManager.selectedContinuous.last)
//        }
//    }

}

struct DatasetAndChartSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DatasetAndChartSelectionView()
    }
}
