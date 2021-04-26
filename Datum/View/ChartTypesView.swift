//
//  ChartTypesView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-23.
//

import SwiftUI

struct ChartTypesView: View {
    
    @ObservedObject var vm: ChartTypesViewModel
    
    init(dataset: Dataset) {
        self.vm = ChartTypesViewModel(dataset: dataset)
    }
    
    var body: some View {
        Form {
            Section {
                Text("Continuous: \(vm.continuousVariableCount)")
                Text("Categorical: \(vm.categoricalVariableCount)")
            }
            
            Section {
                List {
                    ForEach(vm.chartList) { chart in
                        NavigationLink(
                            destination: VariableSelectionView(dataset: vm.dataset, chart: chart),
                            label: {
                                Text(chart.name)
                            })
                    }
                }
            }
        }
        .navigationBarTitle("Chart Types")
    }
}

//struct ChartTypesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartTypesView()
//    }
//}
