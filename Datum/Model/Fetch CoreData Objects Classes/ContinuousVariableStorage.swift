//
//  ContinuousVariableStorage.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-14.
//

import CoreData
import Combine

class ContinuousVariableStorage: NSObject, ObservableObject {
    
    var continuousVariables = CurrentValueSubject<[ContinuousVariable], Never>([])
    
    private let context = PersistenceController.shared.container.viewContext
    
    private let fetchController: NSFetchedResultsController<ContinuousVariable>
    
    //Singleton
    static let shared: ContinuousVariableStorage = ContinuousVariableStorage()
    
    public override init() {
        
        let fetchRequest: NSFetchRequest<ContinuousVariable> = ContinuousVariable.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ContinuousVariable.name, ascending: true)]
        
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
            continuousVariables.value = fetchController.fetchedObjects ?? []
            
        } catch {
            print("Could not fetch variables")
        }

    }
    
    func add(name: String, min: Double?, max: Double?, dataset: Dataset) {
        
        let newVariable = ContinuousVariable(context: context)
        newVariable.id = UUID()
        newVariable.dataset = dataset
        newVariable.name = name
        if let min = min {
            newVariable.min = min
        }
        if let max = max {
            newVariable.max = max
        }
        context.safeSave()
        
    }
    
    func update(id: UUID) {
        
        //TODO: Fill this method when the time comes
        
    }
    
    func delete(variable: ContinuousVariable) {
        context.delete(variable)
        context.safeSave()
    }
    
    
}
extension ContinuousVariableStorage: NSFetchedResultsControllerDelegate {
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        guard let continuous = controller.fetchedObjects as? [ContinuousVariable] else {return}
        print("Context has changed, reloading continuous variables")
        self.continuousVariables.value = continuous
        
    }
    
}
