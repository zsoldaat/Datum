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
    
    private let continuousFetchController: NSFetchedResultsController<ContinuousVariable>
    
    //Singleton
    static let shared: ContinuousVariableStorage = ContinuousVariableStorage()
    
    public override init() {
        
        let continuousFetchRequest: NSFetchRequest<ContinuousVariable> = ContinuousVariable.fetchRequest()
        continuousFetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ContinuousVariable.name, ascending: true)]
        
        continuousFetchController = NSFetchedResultsController(
            fetchRequest: continuousFetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        continuousFetchController.delegate = self
        
        do {
            try continuousFetchController.performFetch()
            continuousVariables.value = continuousFetchController.fetchedObjects ?? []
            
        } catch {
            print("Could not fetch variables")
        }

    }
    
    func add(name: String, min: Double, max: Double, dataset: Dataset) {
        
        let newVariable = ContinuousVariable(context: context)
        newVariable.id = UUID()
        newVariable.dataset = dataset
        newVariable.name = name
        newVariable.min = min
        newVariable.max = max
        
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
