//
//  DatumApp.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import SwiftUI

@main
struct DatumApp: App {
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            InitialTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
