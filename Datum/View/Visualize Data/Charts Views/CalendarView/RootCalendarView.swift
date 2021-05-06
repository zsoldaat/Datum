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
                //move this shit to a view model also
                .background(Color(getGradient(date: date)))
                .clipShape(Circle())
                .padding(.vertical, 4)
                .overlay(
                    ZStack {
                        Circle().stroke(lineWidth: 1)
                        Text(String(self.calendar.component(.day, from: date)))
                    }
                )
        }
    }
    
    //move this function to a vm
    func getGradient(date: Date) -> UIColor {
        
        let colors: [UIColor] = [.white, .red]
        
        let components = date.getComponents(.day, .month, .year)
        
        if let value = datesAndValues[components] {
            return colors.intermediate(percentage: CGFloat(value))
        } else {
            return .white
        }
    }
}

//struct RootCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView()
//    }
//}
