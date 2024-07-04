//
//  AdminCodeView.swift
//  NRT in C5
//
//  Created by EVIE on 6/30/24.
//

import SwiftUI

struct AdminCodeView: View {
    @State var isCorrectAdminCode: Bool = false
    @State var isErrorCodeMessage: Bool = false
    @State var adminCodeValue: String = ""
    let adminCode = "admin2024"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3.0) {
            Text("관리자 코드 입력")
                .font(.system(size: 34))
                .bold()
                .padding(.vertical, 20)
            
            ZStack {
                SecureField("Admin Code", text: $adminCodeValue)
                    .padding()
                    .background(Color(red: 118/255, green: 118/255, blue: 128/255, opacity: 0.12))
                    .cornerRadius(3.0)
                
                Button(action: {
                    adminCodeValue = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding()
                }
                .offset(x: 150)
            }
            
            if isErrorCodeMessage {
                Text("코드가 일치하지 않습니다. 다시 입력해주세요.")
                    .foregroundStyle(.red)
                    .padding(.top, 10)
                    .padding(.leading, 5)
            }
            
            Spacer()
            
            Button(action: {
                if adminCodeValue == adminCode {
                    isCorrectAdminCode = true
                } else {
                    isErrorCodeMessage = true
                }
            }) {
                Text("입장하기")
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(width: 361, height: 60)
            .background(.blue)
            .cornerRadius(6)
            .padding(.bottom, 40)
            .padding(.top, 10)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationDestination(isPresented: $isCorrectAdminCode) {
            AdminReportView()
        }
    }
}
