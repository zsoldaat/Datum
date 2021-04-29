//
//  DynamicNavigationLink.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-04-29.
//

import SwiftUI

struct DynamicNavigationLink<NextView: View>: View {
    var text: String
    var nextView: NextView
    
    var body: some View {
        NavigationLink(destination: nextView) {
            Text(text)
        }
    }
}
//
//struct DynamicNavigationLink_Previews: PreviewProvider {
//    static var previews: some View {
//        DynamicNavigationLink()
//    }
//}
