//
//  RootView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-06.
//

import SwiftUI

struct RootCalendarView: View {
    
    @Environment(\.calendar) var calendar
    
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    
    var body: some View {
        CalendarView(interval: year) { date in
            Text("30")
                .hidden()
                .padding(8)
                .background(Color.blue)
                .clipShape(Circle())
                .padding(.vertical, 4)
                .overlay(
                    Text(String(self.calendar.component(.day, from: date)))
                )
        }
    }
}

//struct RootCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView()
//    }
//}
