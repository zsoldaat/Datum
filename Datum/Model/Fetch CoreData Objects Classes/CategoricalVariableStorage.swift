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
    
    private let fetchController: NSFetchedResultsController<CategoricalVariable>
    
    //Singleton
    static let shared: CategoricalVariableStorage = CategoricalVariableStorage()
    
    public override init() {
        
        let fetchRequest: NSFetchRequest<CategoricalVariable> = CategoricalVariable.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CategoricalVariable.name, ascending: true)]
        
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
            categoricalVariables.value = fetchController.fetchedObjects ?? []
            
        } catch {
            print("Could not fetch variables")
        }

    }
    
    func add(name: String, dataset: Dataset, categories: [String]) {
        
        let newVariable = CategoricalVariable(context: context)
        newVariable.id = UUID()
        newVariable.dataset = dataset
        newVariable.name = name
        
        context.safeSave()
        
        
        for category in categories {
            CategoryStorage.shared.add(variable: newVariable, name: category)
        }
        
        context.safeSave()
        
    }
    
    func update(id: UUID) {
        
        //TODO: Add this method
        
    }
    
    func delete(variable: CategoricalVariable) {
        context.delete(variable)
        context.safeSave()
    }
    
    
}
extension CategoricalVariableStorage: NSFetchedResultsControllerDelegate {
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        guard let categorical = controller.fetchedObjects as? [CategoricalVariable] else {return}
        print("Context has changed, reloading continuous variables")
        self.categoricalVariables.value = categorical
        
    }
    
}
