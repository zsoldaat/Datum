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
    
    static var exampleCategoricalVariable: CategoricalVariable {
        
        let context = PersistenceController.shared.container.viewContext
        
        let variable = CategoricalVariable(context: context)
        variable.id = UUID()
        variable.name = "Example"
        
        let category1 = Category(context: context)
        category1.id = UUID()
        category1.name = "First Category"
        category1.variable = variable
        
        for _ in 1...3 {
            let value = CategoricalDataPoint(context: context)
            value.id = UUID()
            value.date = Date()
            value.category = category1
            value.variable = variable
        }
        
        let category2 = Category(context: context)
        category2.id = UUID()
        category2.name = "Second Category"
        category2.variable = variable
        
        for _ in 1...4 {
            let value = CategoricalDataPoint(context: context)
            value.id = UUID()
            value.date = Date()
            value.category = category2
            value.variable = variable
        }

        return variable
        
    }
    
    
}
extension CategoricalVariableStorage: NSFetchedResultsControllerDelegate {
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        guard let categorical = controller.fetchedObjects as? [CategoricalVariable] else {return}
        print("Context has changed, reloading continuous variables")
        self.categoricalVariables.value = categorical
        
    }
    
}
