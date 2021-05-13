//
//  ChartTypeSelectionView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-28.
//

import SwiftUI

struct ChartTypeSelectionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var visualizationManager: VisualizationManager
    
    var body: some View {
        
        ChartSelectionPickerView(selection: $visualizationManager.chart.type)

        DoneButton{presentationMode.wrappedValue.dismiss()}
        
    }
    
    struct ChartSelectionPickerView: View {
        
        @Binding var selection: Chart.ChartType
        
        var body: some View {
            ScrollView {
                ForEach(Chart.ChartType.allCases) { chart in
                    ChartTypeSelectionView.ChartTypeSelectionViewCell(chartType: chart)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(selection == chart ? Color.accentColor : Color.clear, lineWidth: 2)
                        )
                        .onTapGesture {
                            selection = chart
                        }
                        .padding(.horizontal)
                        .contentShape(Rectangle())
                }
            }
        }
    }
    
    struct ChartTypeSelectionViewCell: View {

        let chartType: Chart.ChartType
        
        var body: some View {
            
            VStack {
                cellFor(chartType)
                .frame(height: 200)
                Text(chartType.properName)
            }
            
        }
        
        @ViewBuilder func cellFor(_ type: Chart.ChartType) -> some View {
            switch type {
            case .barchart:
                BarchartView(categoricalVariable: ExampleData.exampleCategoricalVariable, exampleMode: true)
            case .scatterplot:
                ScatterplotView(xvar: ExampleData.exampleContinuousVariables.first, yvar: ExampleData.exampleContinuousVariables.last, exampleMode: true)
            case .mapView:
                DatapointMapView(locations: ExampleData.locations, region: ExampleData.mapRegion, exampleMode: true)
            case .calendarView:
                RootCalendarView(datesAndValues: ExampleData.averageValuesByDate, exampleMode: true)
            }
        }
    }
}

//struct ChartTypeSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartTypeSelectionView()
//    }
//}
