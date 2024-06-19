//
//  InAppToiletSheet.swift
//  NRT in C5
//
//  Created by EVIE on 6/19/24.
//

import SwiftUI

struct InAppToiletSheet: View {
    @State var selectedToiletSection: String = "A"
    
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
                        selectedToiletSection = "\(item)"
                    }) {
                        Text("\(item)")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(
                                selectedToiletSection != "\(item)" ? .gray : .blue
                            )
                    }
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 60)
                    .border(
                        selectedToiletSection != "\(item)" ? .gray : .blue
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
