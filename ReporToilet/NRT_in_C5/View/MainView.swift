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
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Buttons()
                .padding(.bottom, 50)
            Button(action: {
                
            }) {
                Image(systemName: "person.badge.key")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 16)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxHeight: .infinity)
    }
}

struct Buttons: View {
    let reportBtns = [
        "washbasin" : "세면대가\n막혔어요!",
        "toilet" : "변기가\n막혔어요!",
        "toiletpaper" : "휴지가\n없어요!",
        "sos" : "긴급한\n상황이에요!"
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var selectedBtn: String = ""
    @State var isModal: Bool = false
    
    var body: some View {
        ZStack {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Category.allCases, id: \.self) { category in
                    if let title = reportBtns["\(category)"] {
                        Button(action: {
                            selectedBtn = "\(category)"
                            isModal = true
                        }) {
                            VStack {
                                Spacer()
                                Text(title)
                                    .font(.system(size: 28))
                                    .multilineTextAlignment(.leading)
                                    .bold()
                                    .padding(.bottom)
                                    .foregroundStyle(.white)
                                    .padding(.leading, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .frame(width: 171, height: 241)
                        .background(.gray)
                        
                    }
                }
                .cornerRadius(/*@START_MENU_TOKEN@*/16.0/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            if isModal {
                ModalView(isModal: $isModal, selectedBtn: $selectedBtn)
            }
        }
    }
}

struct ModalView: View {
    @Binding var isModal: Bool
    @Binding var selectedBtn: String
    
    var body: some View {
        VStack {
            Text("modal")
            Text(selectedBtn)
            Button(action: {
                isModal = false
            }) {
                Text("close")
            }
        }
        .frame(width: 393, height: 852)
        .background(.black.opacity(0.5))
    }
}

enum Category: CaseIterable {
    case washbasin
    case toilet
    case toiletpaper
    case sos
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
