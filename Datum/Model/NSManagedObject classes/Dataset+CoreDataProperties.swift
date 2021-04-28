//
//  Dataset+CoreDataProperties.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-09.
//
//

import Foundation
import CoreData


extension Dataset {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dataset> {
        return NSFetchRequest<Dataset>(entityName: "Dataset")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var categoricalData: NSSet?
    @NSManaged public var continuousData: NSSet?
    
    public var wrappedName: String {
        name ?? "No Name"
    }
    
    public var categoricalArray: [CategoricalVariable] {
        let set = categoricalData as? Set<CategoricalVariable> ?? []
        return set.sorted {$0.wrappedName > $1.wrappedName}
    }
    
    public var continuousArray: [ContinuousVariable] {
        let set = continuousData as? Set<ContinuousVariable> ?? []
        return set.sorted {$0.wrappedName > $1.wrappedName}
    }
    
    public var hasCategoricalVariables: Bool {
        categoricalArray.count > 0
    }
    
    public var hasContinuousVariables: Bool {
        continuousArray.count > 0
    }

}

// MARK: Generated accessors for categoricalData
extension Dataset {

    @objc(addCategoricalDataObject:)
    @NSManaged public func addToCategoricalData(_ value: CategoricalVariable)

    @objc(removeCategoricalDataObject:)
    @NSManaged public func removeFromCategoricalData(_ value: CategoricalVariable)

    @objc(addCategoricalData:)
    @NSManaged public func addToCategoricalData(_ values: NSSet)

    @objc(removeCategoricalData:)
    @NSManaged public func removeFromCategoricalData(_ values: NSSet)

}

// MARK: Generated accessors for continuousData
extension Dataset {

    @objc(addContinuousDataObject:)
    @NSManaged public func addToContinuousData(_ value: ContinuousVariable)

    @objc(removeContinuousDataObject:)
    @NSManaged public func removeFromContinuousData(_ value: ContinuousVariable)

    @objc(addContinuousData:)
    @NSManaged public func addToContinuousData(_ values: NSSet)

    @objc(removeContinuousData:)
    @NSManaged public func removeFromContinuousData(_ values: NSSet)

}

extension Dataset : Identifiable {

}
