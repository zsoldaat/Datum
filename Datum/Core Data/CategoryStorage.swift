//
//  CategoryStorage.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-22.
//

import CoreData
import Combine

class CategoryStorage: NSObject, ObservableObject {
    
    var categories = CurrentValueSubject<[Category], Never>([])
    
    private let context = PersistenceController.shared.container.viewContext
    
    private let fetchController: NSFetchedResultsController<Category>
    
    //Singleton
    static let shared: CategoryStorage = CategoryStorage()
    
    public override init() {
        
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Category.name, ascending: true)]
        
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
            categories.value = fetchController.fetchedObjects ?? []
            
        } catch {
            print("Could not fetch variables")
        }

    }
    
    func add(variable: CategoricalVariable, name: String) {
        let category = Category(context: context)
        category.id = UUID()
        category.name = name
        
        category.variable = variable
        
        context.safeSave()
        
        print(category)
    }
    
    func update(id: UUID) {
        
        //TODO: Fill this method when the time comes
        
    }
    
    func delete() {
        
    }
    
}
extension CategoryStorage: NSFetchedResultsControllerDelegate {
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        guard let categories = controller.fetchedObjects as? [Category] else {return}
        print("Context has changed, reloading continuous variables")
        self.categories.value = categories
        
    }
    
}
