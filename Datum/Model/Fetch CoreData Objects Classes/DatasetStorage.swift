//
//  DatasetStorage.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-14.
//

import CoreData
import Combine

//link to how to do this: https://betterprogramming.pub/swiftui-and-coredata-the-mvvm-way-ab9847cbff0f

class DatasetStorage: NSObject, ObservableObject {
    
    var datasets = CurrentValueSubject<[Dataset], Never>([])
    
    private let fetchController: NSFetchedResultsController<Dataset>
    private let context = PersistenceController.shared.container.viewContext
    
    //Singleton
    static let shared: DatasetStorage = DatasetStorage()
    
    public override init() {
        
        let fetchRequest: NSFetchRequest<Dataset> = Dataset.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Dataset.name, ascending: true)]
        
        fetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        fetchController.delegate = self
        
        do {
            try fetchController.performFetch()
            datasets.value = fetchController.fetchedObjects ?? []
        } catch {
            print("Could not fetch Dataset objects")
        }
    }
    
    func add(name: String) {
        
        let newDataset = Dataset(context: context)
        newDataset.name = name
        newDataset.id = UUID()
        newDataset.date = Date()
        
        context.safeSave()
        
    }
    
    func update(id: UUID) {
        
        //TODO: Add this method
        
    }
    
    func delete(dataset: Dataset) {
        context.delete(dataset)
        context.safeSave()
    }
    
    
}
extension DatasetStorage: NSFetchedResultsControllerDelegate {
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let datasets = controller.fetchedObjects as? [Dataset] else {return}
        print("Context has changed, reloading datasets")
        self.datasets.value = datasets
    }
    
}
