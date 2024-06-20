//
//  InAppToiletSheet.swift
//  NRT in C5
//
//  Created by EVIE on 6/19/24.
//

import SwiftUI

struct InAppToiletSheet: View {
    @Binding var selectedInAppToiletSection: String
    
    var body: some View {
        VStack {
            Text("어느 위치에 계신가요?")
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
                    .frame(width: 109, height: 80)
                    .border(
                        selectedInAppToiletSection != "\(item)" ? .gray : .blue
                    )
                }
                .padding(.top, 10)
            }
            .padding(.bottom, 20)
            
            Text("관리자에게 메시지가 전달됩니다.")
                .font(.system(size: 14))
                .foregroundStyle(.gray)
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
