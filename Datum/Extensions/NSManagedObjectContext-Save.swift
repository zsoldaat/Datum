//
//  NSManagedContextSave.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-07.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    func safeSave() {
        do {
            try self.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}
