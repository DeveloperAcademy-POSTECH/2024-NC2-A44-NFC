//
//  ReportModalView.swift
//  NRT in C5
//
//  Created by EVIE on 6/18/24.
//

import SwiftUI

struct WashbasinSheet: View {
    @Binding var selectedWashbasinSection: String
    
    var body: some View {
        VStack {
            Text("세면대 위치는 어디인가요?")
                .font(.system(size: 28))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
            
            Image("washbasin_\(selectedWashbasinSection)")
                .resizable()
                .frame(width: 329, height: 109)
            
            HStack {
                ForEach(washbasinSection.allCases, id: \.self) { item in
                    Button(action: {
                        selectedWashbasinSection = item.rawValue
                    }) {
                        Text("\(item)")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(
                                selectedWashbasinSection != item.rawValue ? .gray : .blue
                            )
                    }
                    .frame(width: 172, height: 60)
                    .cornerRadius(6)
                    .border(
                        selectedWashbasinSection != item.rawValue ? .gray : .blue
                    )
                }
                .padding(.top, 10)
            }
            .padding(.bottom, 20)
            
            Spacer()
            
            Text("신고하시겠습니까?")
                .font(.system(size: 22))
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
            .frame(width: 361, height: 60)
            .background(.blue)
            .cornerRadius(6)
            .padding(.bottom, 50)
        }
    }
}
