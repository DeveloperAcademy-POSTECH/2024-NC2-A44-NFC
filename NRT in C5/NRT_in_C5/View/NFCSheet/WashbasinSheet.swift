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
            Text("5층 여자화장실 \(selectedWashbasinSection)세면대")
                .font(.system(size: 28))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
            
            Image("washbasin_\(selectedWashbasinSection)")
                .resizable()
                .frame(width: 329, height: 109)
            
            Spacer()
            
            Text("신고하시겠습니까?")
                .font(.system(size: 22))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            SendReportButton()
        }
    }
}
