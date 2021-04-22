//
//  CategoricalDataPointStorage.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-16.
//

import CoreData
import Combine

class CategoricalDataPointStorage: NSObject, ObservableObject {
    
    var categoricalDataPoints = CurrentValueSubject<[CategoricalDataPoint], Never>([])
    
    private let context = PersistenceController.shared.container.viewContext
    
    private let fetchController: NSFetchedResultsController<CategoricalDataPoint>
    
    //Singleton
    static let shared: CategoricalDataPointStorage = CategoricalDataPointStorage()
    
    public override init() {
        
        let fetchRequest: NSFetchRequest<CategoricalDataPoint> = CategoricalDataPoint.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CategoricalDataPoint.category, ascending: true)]
        
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
            categoricalDataPoints.value = fetchController.fetchedObjects ?? []
            
        } catch {
            print("Could not fetch variables")
        }

    }
    
    func add(variable: CategoricalVariable, category: Category, rowId: UUID) {
        
        let newDataPoint = CategoricalDataPoint(context: context)
        newDataPoint.category = category
        context.safeSave()
        print("First save complete")
        
        newDataPoint.id = UUID()
        newDataPoint.date = Date()
        newDataPoint.rowId = rowId
        
        if let location = LocationFetcher.shared.lastKnownLocation {
            newDataPoint.longitude = location.longitude
            newDataPoint.latitude = location.latitude
        }
        
//        newDataPoint.category = category
        newDataPoint.variable = variable
        
        context.safeSave()
        
        print("Second save complete")
        
        print(newDataPoint)
    }
    
    func update(id: UUID) {
        
        //TODO: Fill this method when the time comes
        
    }
    
    func delete() {
        
    }
    
}
extension CategoricalDataPointStorage: NSFetchedResultsControllerDelegate {
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        guard let categorical = controller.fetchedObjects as? [CategoricalDataPoint] else {return}
        print("Context has changed, reloading continuous variables")
        self.categoricalDataPoints.value = categorical
        
    }
    
}

