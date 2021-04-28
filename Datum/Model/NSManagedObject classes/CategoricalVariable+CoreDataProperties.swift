//
//  CategoricalVariable+CoreDataProperties.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-09.
//
//

import Foundation
import CoreData


extension CategoricalVariable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoricalVariable> {
        return NSFetchRequest<CategoricalVariable>(entityName: "CategoricalVariable")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var dataset: Dataset?
    @NSManaged public var values: NSSet?
    @NSManaged public var categories: NSSet?
    
    public var wrappedName: String {
        name ?? "No Name"
    }
    
    public var categoriesArray: [Category] {
        let set = categories as? Set<Category> ?? []
        
        return set.sorted {
            $0.name ?? "No name" > $1.name ?? "No name"
        }
    }

}

// MARK: Generated accessors for values
extension CategoricalVariable {

    @objc(addValuesObject:)
    @NSManaged public func addToValues(_ value: CategoricalDataPoint)

    @objc(removeValuesObject:)
    @NSManaged public func removeFromValues(_ value: CategoricalDataPoint)

    @objc(addValues:)
    @NSManaged public func addToValues(_ values: NSSet)

    @objc(removeValues:)
    @NSManaged public func removeFromValues(_ values: NSSet)

}

// MARK: Generated accessors for categories
extension CategoricalVariable {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: Category)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: Category)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

extension CategoricalVariable : Identifiable {

}

extension CategoricalVariable: Variable {
    
}
