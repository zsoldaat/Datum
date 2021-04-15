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
    
    func add(name: String, dataset: Dataset, categories: [String]) {
        
        let newVariable = CategoricalVariable(context: context)
        newVariable.id = UUID()
        newVariable.dataset = dataset
        newVariable.name = name
        
        for category in categories {
            addCategory(name: category, variable: newVariable)
        }
        
        context.safeSave()
        
    }
    
    func addCategory(name: String, variable: CategoricalVariable) {
        let newCategory = Category(context: context)
        newCategory.id = UUID()
        newCategory.variable = variable
        newCategory.name = name
        
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