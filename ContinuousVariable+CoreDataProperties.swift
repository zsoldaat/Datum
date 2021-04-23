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
//    @NSManaged public var max: Double
//    @NSManaged public var min: Double
    @NSManaged public var dataset: Dataset?
    @NSManaged public var values: NSSet?
    
    public var max: Double? {
        get {
            willAccessValue(forKey: "max")
            defer { didAccessValue(forKey: "max") }

            return primitiveValue(forKey: "max") as? Double
        }
        set {
            willChangeValue(forKey: "max")
            defer { didChangeValue(forKey: "max") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "max")
                return
            }
            setPrimitiveValue(value, forKey: "max")
        }
    }
    
    public var min: Double? {
        get {
            willAccessValue(forKey: "min")
            defer { didAccessValue(forKey: "min") }

            return primitiveValue(forKey: "min") as? Double
        }
        set {
            willChangeValue(forKey: "min")
            defer { didChangeValue(forKey: "min") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "min")
                return
            }
            setPrimitiveValue(value, forKey: "min")
        }
    }
    
    public var wrappedName: String {
        name ?? "No Name"
    }
    
    public var minString: String? {
        
        if let min = self.min {
            return min.removeZerosFromEnd()
        } else {
            return nil
        }
    }
    
    public var maxString: String? {
        
        if let max = self.max {
            return max.removeZerosFromEnd()
        } else {
            return nil
        }
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
