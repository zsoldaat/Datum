//
//  VariableStorage.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-14.
//

import CoreData
import Combine

class CategoricalVariableStorage: NSObject, ObservableObject {
    
    var categoricalVariables = CurrentValueSubject<[CategoricalVariable], Never>([])
    
    private let context = PersistenceController.shared.container.viewContext
    
    private let categoricalFetchController: NSFetchedResultsController<CategoricalVariable>
    
    //Singleton
    static let shared: CategoricalVariableStorage = CategoricalVariableStorage()
    
    public override init() {
        
        let categoricalFetchRequest: NSFetchRequest<CategoricalVariable> = CategoricalVariable.fetchRequest()
        categoricalFetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CategoricalVariable.name, ascending: true)]
        
        categoricalFetchController = NSFetchedResultsController(
            fetchRequest: categoricalFetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        categoricalFetchController.delegate = self
        
        do {
            try categoricalFetchController.performFetch()
            categoricalVariables.value = categoricalFetchController.fetchedObjects ?? []
            
        } catch {
            print("Could not fetch variables")
        }

    }
    
    func add(name: String) {
        
//        let context = PersistenceController.shared.container.viewContext
//
//        let newDataset = Dataset(context: context)
//        newDataset.name = name
//        newDataset.id = UUID()
//
//        context.safeSave()
        
    }
    
    func update(id: UUID) {
        
    }
    
//    func delete(dataset: Dataset) {
//        context.delete(dataset)
//        context.safeSave()
//    }
}
extension CategoricalVariableStorage: NSFetchedResultsControllerDelegate {
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        guard let categorical = controller.fetchedObjects as? [CategoricalVariable] else {return}
        print("Context has changed, reloading continuous variables")
        self.categoricalVariables.value = categorical
        
    }
    
}
