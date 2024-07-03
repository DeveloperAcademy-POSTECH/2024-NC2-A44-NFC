//
//  ToiletModalView.swift
//  NRT in C5
//
//  Created by EVIE on 6/18/24.
//

import SwiftUI

struct ToiletSheet: View {
    @EnvironmentObject var reportData: ReportData
    
    var body: some View {
        VStack {
            Text("\(reportData.selectedFloor)층 \(reportData.selectedGender == "male" ? "남자" : "여자")화장실 \(reportData.selectedToiletSection)칸")
                .font(.system(size: 28))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
            
            Image("toilet_\(reportData.selectedToiletSection)")
                .resizable()
                .frame(width: 329, height: 109)
                .padding(.bottom, 20)
            
            HStack {
                Text("무슨 상황인가요?")
                    .font(.system(size: 24))
                    .bold()
                Text("(복수선택 가능)")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            }
            .padding(.leading, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                ForEach(ReportType.allCases, id: \.self) { report in
                    Button(action: {
                        reportData.toggleReport(report.rawValue)
                    }) {
                        Text("\(report.rawValue)")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(
                                reportData.selectedReports.contains(report.rawValue) ? .blue : .gray
                            )
                    }
                    .frame(width: 172, height: 60)
                    .border(
                        reportData.selectedReports.contains(report.rawValue) ? .blue : .gray
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
