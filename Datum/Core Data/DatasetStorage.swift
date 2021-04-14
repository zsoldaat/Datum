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
    
    private let datasetFetchController: NSFetchedResultsController<Dataset>
    private let context = PersistenceController.shared.container.viewContext
    
    static let shared: DatasetStorage = DatasetStorage()
    
    public override init() {
        
        let fetchRequest: NSFetchRequest<Dataset> = Dataset.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Dataset.name, ascending: true)]
        
        datasetFetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        datasetFetchController.delegate = self
        
        do {
            try datasetFetchController.performFetch()
            datasets.value = datasetFetchController.fetchedObjects ?? []
        } catch {
            print("Could not fetch Dataset objects")
        }
    }
    
    func add(name: String) {
        
        let context = PersistenceController.shared.container.viewContext
        
        let newDataset = Dataset(context: context)
        newDataset.name = name
        newDataset.id = UUID()
        
        context.safeSave()
        
    }
    
    func update(id: UUID) {
        
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
