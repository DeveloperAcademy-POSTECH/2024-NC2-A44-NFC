//
//  ToiletModalView.swift
//  NRT in C5
//
//  Created by EVIE on 6/18/24.
//

import SwiftUI

struct ToiletSheet: View {
    @Binding var selectedToiletSection: String
    
    var body: some View {
        VStack {
            Text("변기 위치는 어디인가요?")
                .font(.system(size: 28))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
            
            Image("toilet_\(selectedToiletSection)")
                .resizable()
                .frame(width: 329, height: 109)
            
            HStack {
                ForEach(toiletSection.allCases, id: \.self) { item in
                    Button(action: {
                        selectedToiletSection = item.rawValue
                    }) {
                        Text("\(item)")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(
                                selectedToiletSection != item.rawValue ? .gray : .blue
                            )
                    }
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 60)
                    .border(
                        selectedToiletSection != item.rawValue ? .gray : .blue
                    )
                }
                .padding(.top, 10)
            }
            .padding(.bottom, 20)
            
            Spacer()
            
            Text("신고하시겠습니까?")
                .font(.system(size: 24))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            SendReportButton()
        }
    }
}

enum toiletSection: String, CaseIterable {
    case A
    case B
    case C
}
