//
//  ContentViewModel.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-14.
//

import Foundation
import CoreData
import SwiftUI

extension ContentView {
    
    class ContentViewModel: ObservableObject {
        
        let context = PersistenceController.shared.container.viewContext
        
        var datasets: [Dataset]
        
        var request2: FetchRequest<Dataset>
        
        @Published var destination = SheetDestination.addDatasetView
        @Published var showSheet = false
        
        init() {
            
            request2 = FetchRequest<Dataset>(entity: Dataset.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Dataset.name, ascending: true)], predicate: nil, animation: .default)
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Dataset.entity().name!)
            
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Dataset.name, ascending: true)]
            
            if let results = try? context.fetch(request) as? [Dataset] {
                self.datasets = results
                print("Success")
            } else {
                self.datasets = []
                print("Could not retrieve datasets")
            }
        }
        
        func showAddDatasetView() {
            destination = .addDatasetView
            showSheet = true
        }
        
        enum SheetDestination {
            case addDatasetView
        }
        
        func deleteItems(offsets: IndexSet) {
            withAnimation {
                offsets.map { datasets[$0] }.forEach(context.delete)

                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
        
    }
    
    
}
