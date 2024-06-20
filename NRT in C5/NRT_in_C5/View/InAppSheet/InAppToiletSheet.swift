//
//  InAppToiletSheet.swift
//  NRT in C5
//
//  Created by EVIE on 6/19/24.
//

import SwiftUI

struct InAppToiletSheet: View {
    @State var selectedInAppToiletSection: String = "A"
    
    var body: some View {
        VStack {
            Text("몇 번째 칸인가요?")
                .font(.system(size: 28))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
            
            Image("toilet_\(selectedInAppToiletSection)")
                .resizable()
                .frame(width: 329, height: 109)
            
            HStack {
                ForEach(ToiletSection.allCases, id: \.self) { item in
                    Button(action: {
                        selectedInAppToiletSection = "\(item)"
                    }) {
                        Text("\(item)")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(
                                selectedInAppToiletSection != "\(item)" ? .gray : .blue
                            )
                    }
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 60)
                    .border(
                        selectedInAppToiletSection != "\(item)" ? .gray : .blue
                    )
                }
                .padding(.top, 10)
            }
            .padding(.bottom, 20)
            
            Text("신고하시겠습니까?")
                .font(.system(size: 24))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
