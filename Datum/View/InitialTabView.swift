//
//  TabView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-27.
//

import SwiftUI

struct InitialTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Record Data")
                }
            DatasetAndChartSelectionView()
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("Visualize Data")
                }
        }
    }
}

struct InitialTabView_Previews: PreviewProvider {
    static var previews: some View {
        InitialTabView()
    }
}
