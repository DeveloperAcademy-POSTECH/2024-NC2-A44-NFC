//
//  InAppWashbasinSheet.swift
//  NRT in C5
//
//  Created by EVIE on 6/20/24.
//

import SwiftUI

struct InAppWashbasinSheet: View {
    @EnvironmentObject var reportData: ReportData
    
    var body: some View {
        VStack {
            Text("세면대 위치는 어디인가요?")
                .font(.system(size: 28))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
            
            Image("washbasin_\(reportData.selectedWashbasinSection)")
                .resizable()
                .frame(width: 329, height: 109)
            
            HStack {
                ForEach(WashbasinSection.allCases, id: \.self) { item in
                    Button(action: {
                        reportData.selectedWashbasinSection = item.rawValue
                    }) {
                        Text("\(item)")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(
                                reportData.selectedWashbasinSection != item.rawValue ? .gray : .blue
                            )
                    }
                    .frame(width: 172, height: 60)
                    .cornerRadius(6)
                    .border(
                        reportData.selectedWashbasinSection != item.rawValue ? .gray : .blue
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

