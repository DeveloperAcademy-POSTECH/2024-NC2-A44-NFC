//
//  InAppSOSSheet.swift
//  NRT in C5
//
//  Created by EVIE on 6/20/24.
//

import SwiftUI

struct InAppSOSSheet: View {
    var body: some View {
        VStack {
            VStack {
                Text("긴급전화")
                    .font(.system(size: 24))
                Text("119")
                    .font(.system(size: 60))
                    .bold()
            }
            .foregroundColor(.white)
            .padding(.top, 50)
            
            Spacer()
            Button(action: {
                
            }) {
                Image("sosicon")
                    .resizable()
                    .frame(width: 228, height: 228)
                    .padding(.bottom, 180)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
