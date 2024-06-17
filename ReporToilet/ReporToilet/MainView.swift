//
//  MainView.swift
//  ReporToilet
//
//  Created by EVIE on 6/18/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 3.0) {
                Text("매콤 5층 여자화장실")
                    .font(.system(size: 34))
                    .bold()
                Text("깨끗한 화장실을 함께 만들어요")
                    .font(.system(size: 18))
            }
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Buttons()
            
            Button(action: {
                
            }) {
                Text("관리자 페이지")
                    .frame(width: 361, height: 60)
                    .background(.blue)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    MainView()
}

struct Buttons: View {
    let reportBtns = [
        "washbasin" : "세면대가\n막혔어요!",
        "toilet" : "변기가\n막혔어요!",
        "toiletpaper" : "휴지가\n떨어졌어요!",
        "sos" : "긴급한\n상황이에요!"
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(Category.allCases, id: \.self) { category in
                if let title = reportBtns["\(category)"] {
                    Button(action: {
                        
                    }) {
                        VStack {
                            Spacer()
                            Text(title)
                                .font(.system(size: 28))
                                .multilineTextAlignment(.leading)
                                .bold()
                                .padding(.bottom)
                                .foregroundStyle(.white)
                                .padding(.leading, 20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .frame(width: 171, height: 241)
                    .background(.gray)
                }
            }
        }
        .padding()
    }
}

enum Category: CaseIterable {
    case washbasin
    case toilet
    case toiletpaper
    case sos
}
