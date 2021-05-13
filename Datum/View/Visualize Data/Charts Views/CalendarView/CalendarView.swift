//
//  CalendarView.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-06.
//

import SwiftUI

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let interval: DateInterval
    let content: (Date) -> DateView
    let exampleMode: Bool

    init(interval: DateInterval, exampleMode: Bool, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.content = content
        self.exampleMode = exampleMode
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(exampleMode ? [] : .vertical, showsIndicators: false) {
                VStack {
                    ForEach(months, id: \.self) { month in
                        MonthView(month: month, exampleMode: exampleMode, content: self.content)
                    }
                }
            }
            .onAppear {
                if !exampleMode {
                    scrollView.scrollTo(months[Calendar.current.dateComponents([.month], from: Date()).month!-1])
                }
                
            }
        }
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
