//
//  Date-getComponents.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-06.
//

import Foundation

extension Date {
    func getComponents(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func getComponents(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
