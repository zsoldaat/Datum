//
//  VariableSelectionView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-23.
//

import SwiftUI

struct VariableSelectionView: View {
    
    @ObservedObject var vm: VariableSelectionViewModel
    
    init(dataset: Dataset, chart: Chart) {
        self.vm = VariableSelectionViewModel(dataset: dataset, chart: chart)
    }
    
    var body: some View {
        Form {
            List {
                
                NavigationLink(destination: ScatterplotView(variables: vm.selectedContinuousVariables)) {
                    Text("See the chart")
                }
                .disabled(!vm.correctNumberSelected)
                
                Text("Selected continuous variables: \(vm.continuousCount)/\(vm.chart.continuousVariablesRequired)")
                Text("Selected categorical variables: \(vm.categoricalCount)/\(vm.chart.categoricalVariablesRequired)")
                
                if vm.chart.continuousVariablesRequired > 0 {
                    Section(header: Text("Continuous Variables")) {
                        ForEach(vm.dataset.continuousArray) { continuous in
                            HStack {
                                Text(continuous.wrappedName)
                                Spacer()
                                if continuous.isSelected {
                                    Image(systemName: "checkmark")
                                }
                            }
                            .onTapGesture {
                                vm.selectContinuousVariable(variable: continuous)
                            }
                        }
                    }
                }
                
                if vm.chart.categoricalVariablesRequired > 0 {
                    Section(header: Text("Categorical Variables")) {
                        ForEach(vm.dataset.categoricalArray) { categorical in
                            HStack {
                                Text(categorical.wrappedName)
                                Spacer()
                                if categorical.isSelected {
                                    Image(systemName: "checkmark")
                                }
                            }
                            .onTapGesture {
                                vm.selectCategoricalVariable(variable: categorical)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Select Variables")
    }
}

//struct VariableSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        VariableSelectionView()
//    }
//}
