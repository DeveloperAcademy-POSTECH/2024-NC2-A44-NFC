//
//  ToiletModalView.swift
//  NRT in C5
//
//  Created by EVIE on 6/18/24.
//

import SwiftUI

struct ToiletSheet: View {
    @State var selectedSection: String = "none"
    
    var body: some View {
        VStack {
            Text("몇 번째 칸인가요?")
                .font(.system(size: 24))
                .bold()
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image("selected_\(selectedSection)")
                .resizable()
                .frame(width: 329, height: 109)
            
            HStack {
                ForEach(Section.allCases, id: \.self) { item in
                    Button(action: {
                        selectedSection = "\(item)"
                    }) {
                        Text("\(item)")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundStyle(
                                selectedSection != "\(item)" ?
                                    .gray : .white
                            )
                    }
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 60)
                    .background(
                        selectedSection != "\(item)" ?
                        Color(red: 232 / 255, green: 232 / 255, blue: 232 / 255) : .blue
                    )
                }
                .cornerRadius(6)
                .padding(.top, 10)
            }
            .padding(.bottom, 20)
            
            Text("신고하시겠습니까?")
                .font(.system(size: 24))
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
            .frame(width: 331, height: 60)
            .background(.blue)
            .cornerRadius(6)
        }
    }
}

enum Section: String, CaseIterable {
    case A
    case B
    case C
}
