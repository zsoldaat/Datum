//
//  ContinuousVariable+CoreDataProperties.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-09.
//
//

import Foundation
import CoreData


extension ContinuousVariable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContinuousVariable> {
        return NSFetchRequest<ContinuousVariable>(entityName: "ContinuousVariable")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var max: Double
    @NSManaged public var min: Double
    @NSManaged public var dataset: Dataset?
    @NSManaged public var values: NSSet?
    
    public var wrappedName: String {
        name ?? "No Name"
    }
    
    public var minString: String {
        self.min.removeZerosFromEnd()
    }
    
    public var maxString: String {
        self.max.removeZerosFromEnd()
    }

}

// MARK: Generated accessors for values
extension ContinuousVariable {

    @objc(addValuesObject:)
    @NSManaged public func addToValues(_ value: ContinuousDataPoint)

    @objc(removeValuesObject:)
    @NSManaged public func removeFromValues(_ value: ContinuousDataPoint)

    @objc(addValues:)
    @NSManaged public func addToValues(_ values: NSSet)

    @objc(removeValues:)
    @NSManaged public func removeFromValues(_ values: NSSet)

}

extension ContinuousVariable : Identifiable {

}
