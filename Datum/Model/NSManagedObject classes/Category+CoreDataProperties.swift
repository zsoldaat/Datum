//
//  Category+CoreDataProperties.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-22.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var values: NSSet?
    @NSManaged public var variable: CategoricalVariable?
    
    public var valuesArray: [CategoricalDataPoint] {
        let set = values as? Set<CategoricalDataPoint> ?? []
        return set.sorted {$0.date! > $1.date!}
    }

}

// MARK: Generated accessors for values
extension Category {

    @objc(addValuesObject:)
    @NSManaged public func addToValues(_ value: CategoricalDataPoint)

    @objc(removeValuesObject:)
    @NSManaged public func removeFromValues(_ value: CategoricalDataPoint)

    @objc(addValues:)
    @NSManaged public func addToValues(_ values: NSSet)

    @objc(removeValues:)
    @NSManaged public func removeFromValues(_ values: NSSet)

}

extension Category : Identifiable {

}
