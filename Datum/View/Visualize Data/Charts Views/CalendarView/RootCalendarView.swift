//
//  RootView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-06.
//

import SwiftUI

struct RootCalendarView: View {
    
    //code for all this: https://gist.github.com/mecid/f8859ea4bdbd02cf5d440d58e936faec/9169b0293f709bb1f560de2ca8184ea903fd5116
    
    @Environment(\.calendar) var calendar
    
    var datesAndValues: [DateComponents: Double]
    
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
//                    Text(String(self.calendar.component(.day, from: date)))
                    //Move this logic to a view model
                    Text(datesAndValues[date.getComponents(.day, .month, .year)]?.removeZerosFromEnd() ?? "No")
                )
                .onTapGesture {
                    print(date)
                    print(datesAndValues.keys.first)
                }
        }
    }
}

//struct RootCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView()
//    }
//}
