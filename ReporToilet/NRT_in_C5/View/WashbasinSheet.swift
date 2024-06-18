//
//  ReportModalView.swift
//  NRT in C5
//
//  Created by EVIE on 6/18/24.
//

import SwiftUI

struct WashbasinSheet: View {
    
    var body: some View {
        VStack {
            Text("세면대가 막히셨나요?")
                .font(.system(size: 24))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                
            }) {
                Text("신고하기")
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(width: 331, height: 60)
            .background(.blue)
            .cornerRadius(6)
        }
    }
}
