//
//  ContinuousValueStorage.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-16.
//

import CoreData
import Combine

class ContinuousDataPointStorage: NSObject, ObservableObject {
    
    var continuousDataPoints = CurrentValueSubject<[ContinuousDataPoint], Never>([])
    
    private let context = PersistenceController.shared.container.viewContext
    
    private let continuousFetchController: NSFetchedResultsController<ContinuousDataPoint>
    
    //Singleton
    static let shared: ContinuousDataPointStorage = ContinuousDataPointStorage()
    
    public override init() {
        
        let continuousFetchRequest: NSFetchRequest<ContinuousDataPoint> = ContinuousDataPoint.fetchRequest()
        continuousFetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ContinuousDataPoint.value, ascending: true)]
        
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
            continuousDataPoints.value = continuousFetchController.fetchedObjects ?? []
            
        } catch {
            print("Could not fetch variables")
        }

    }
    
    func add(variable: ContinuousVariable, value: Double, rowId: UUID) {
        
        let newDataPoint = ContinuousDataPoint(context: context)
        newDataPoint.id = UUID()
        newDataPoint.date = Date()
        newDataPoint.rowId = rowId
        newDataPoint.value = value
        
        if let location = LocationFetcher.shared.lastKnownLocation {
            newDataPoint.longitude = location.longitude
            newDataPoint.latitude = location.latitude
        }
        
        newDataPoint.variable = variable
        
        print(newDataPoint)
        
        context.safeSave()
        
    }
    
    func update(id: UUID) {
        
        //TODO: Fill this method when the time comes
        
    }
    
    func delete() {
        
    }
}
extension ContinuousDataPointStorage: NSFetchedResultsControllerDelegate {
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        guard let continuous = controller.fetchedObjects as? [ContinuousDataPoint] else {return}
        print("Context has changed, reloading continuous variables")
        self.continuousDataPoints.value = continuous
        
    }
    
}
