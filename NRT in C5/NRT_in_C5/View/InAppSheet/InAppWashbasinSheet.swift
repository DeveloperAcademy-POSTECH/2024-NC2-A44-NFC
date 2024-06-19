//
//  InAppWashbasinSheet.swift
//  NRT in C5
//
//  Created by EVIE on 6/20/24.
//

import SwiftUI

struct InAppWashbasinSheet: View {
    @Binding var selectedInAppWashbasinSection: String
    
    var body: some View {
        VStack {
            Text("세면대 위치는 어디인가요?")
                .font(.system(size: 28))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
            
            Image("washbasin_\(selectedInAppWashbasinSection)")
                .resizable()
                .frame(width: 329, height: 109)
            
            HStack {
                ForEach(WashbasinSection.allCases, id: \.self) { item in
                    Button(action: {
                        selectedInAppWashbasinSection = item.rawValue
                    }) {
                        Text("\(item)")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(
                                selectedInAppWashbasinSection != item.rawValue ? .gray : .blue
                            )
                    }
                    .frame(width: 172, height: 60)
                    .cornerRadius(6)
                    .border(
                        selectedInAppWashbasinSection != item.rawValue ? .gray : .blue
                    )
                }
                .padding(.top, 10)
            }
            .padding(.bottom, 20)
            
            Text("신고하시겠습니까?")
                .font(.system(size: 22))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            SendReportButton()
        }
    }
}

