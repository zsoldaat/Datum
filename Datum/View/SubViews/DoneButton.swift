//
//  DoneButton.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-07.
//

import SwiftUI

struct DoneButton: View {
    
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    
    var body: some View {
        Button(action: action) {
            Text("Done")
                .frame(width: 200)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.accentColor)
                        
                )
                .padding()
            
        }
    }
}

//struct DoneButton_Previews: PreviewProvider {
//    static var previews: some View {
//        DoneButton()
//    }
//}
