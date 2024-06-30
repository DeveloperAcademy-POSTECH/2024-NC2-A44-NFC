//
//  InAppToiletSheet.swift
//  NRT in C5
//
//  Created by EVIE on 6/19/24.
//

import SwiftUI

struct InAppToiletSheet: View {
    @EnvironmentObject var reportData: ReportData
    
    var body: some View {
        VStack {
            Text("어느 위치에 계신가요?")
                .font(.system(size: 28))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
            
            Image("toilet_\(reportData.selectedToiletSection)")
                .resizable()
                .frame(width: 329, height: 109)
            
            HStack {
                ForEach(ToiletSection.allCases, id: \.self) { item in
                    Button(action: {
                        reportData.selectedToiletSection = "\(item)"
                    }) {
                        Text("\(item)")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(
                                reportData.selectedToiletSection != "\(item)" ? .gray : .blue
                            )
                    }
                    .frame(width: 109, height: 80)
                    .border(
                        reportData.selectedToiletSection != "\(item)" ? .gray : .blue
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
