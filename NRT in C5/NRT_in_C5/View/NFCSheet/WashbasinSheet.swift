//
//  ReportModalView.swift
//  NRT in C5
//
//  Created by EVIE on 6/18/24.
//

import SwiftUI

struct WashbasinSheet: View {
    @EnvironmentObject var reportData: ReportData
    
    var body: some View {
        VStack {
            Text("5층 여자화장실 \(reportData.selectedWashbasinSection)세면대")
                .font(.system(size: 28))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
            
            Image("washbasin_\(reportData.selectedWashbasinSection)")
                .resizable()
                .frame(width: 329, height: 109)
            
            Spacer()
            
            Text("관리자에게 메시지가 전달됩니다.")
                .font(.system(size: 14))
                .foregroundStyle(.gray)
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
