//
//  FloatingCloseButton.swift
//  Datum
//
//  Created by Zac Soldaat on 2021-05-07.
//

import SwiftUI

struct FloatingCloseButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct FloatingCloseButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingCloseButton()
    }
}
