//
//  ToiletModalView.swift
//  NRT in C5
//
//  Created by EVIE on 6/18/24.
//

import SwiftUI

struct ToiletSheet: View {
    @State var selectedToiletSection: String = "A"
    @State var selectedReports: Set<ReportType> = []
    
    var body: some View {
        VStack {
            Text("5층 여자화장실 \(selectedToiletSection)칸")
                .font(.system(size: 28))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
            
            Image("toilet_\(selectedToiletSection)")
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
                        selectedReports(report)
                        print(selectedReports)
                    }) {
                        Text("\(report.rawValue)")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(
                                selectedReports.contains(report) ? .blue : .gray
                            )
                    }
                    .frame(width: 172, height: 60)
                    .border(
                        selectedReports.contains(report) ? .blue : .gray
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
            
            VStack {
                Button(action: {
                    
                }) {
                    Text("신고하기")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .frame(width: 361, height: 60)
            .background(.blue)
            .cornerRadius(6)
            .padding(.bottom, 50)
        }
    }
    private func selectedReports(_ report: ReportType) {
        if selectedReports.contains(report) {
            selectedReports.remove(report)
        } else {
            selectedReports.insert(report)
        }
    }
}
