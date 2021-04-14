//
//  Persistence.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        for i in 0..<10 {
            let newDataset = Dataset(context: viewContext)
            newDataset.name = "Test Dataset \(i)"
            newDataset.id = UUID()
            newDataset.date = Date()
            
            let newContinuous = ContinuousVariable(context: viewContext)
            newContinuous.name = "Continuous Variable"
            newContinuous.id = UUID()
            newContinuous.min = 0
            newContinuous.max = 100
            newContinuous.dataset = newDataset
            
            let newCategorical = CategoricalVariable(context: viewContext)
            newCategorical.name = "Categorical Variable"
            newCategorical.id = UUID()
            //add categories
            for i in 1...3 {
                let category = Category(context: viewContext)
                category.id = UUID()
                category.name = "Category \(i)"
                
                newCategorical.addToCategories(category)
            }
            newCategorical.dataset = newDataset
            
            for i in 1...10 {
                
                let rowID = UUID()
                
                let newContinuousDataPoint = ContinuousDataPoint(context: viewContext)
                newContinuousDataPoint.date = Date()
                newContinuousDataPoint.id = UUID()
                newContinuousDataPoint.rowId = rowID
                newContinuousDataPoint.value = Double(i)
                
                newContinuous.addToValues(newContinuousDataPoint)
                
                let newCategoricalDataPoint = CategoricalDataPoint(context: viewContext)
                newCategoricalDataPoint.date = Date()
                newCategoricalDataPoint.id = UUID()
                newCategoricalDataPoint.rowId = rowID
                newCategoricalDataPoint.category = newCategorical.categoriesArray[Int.random(in: 0...2)]
                
                newCategorical.addToValues(newCategoricalDataPoint)
            }
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Datum")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
