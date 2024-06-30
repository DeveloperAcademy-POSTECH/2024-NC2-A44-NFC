//
//  MainView.swift
//  ReporToilet
//
//  Created by EVIE on 6/18/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var reportData: ReportData
    @EnvironmentObject var urlHandler: URLHandler
    @State private var isSheetPresented: Bool = false
    @State private var isAdminViewPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HeaderView()
                    
                    ButtonsView(isSheetPresented: $isSheetPresented)
                        .padding(.bottom, 50)
                    
                    AdminButton(isAdminViewPresented: $isAdminViewPresented)
                }
                .blur(radius: isSheetPresented ? 12 : 0)
                
                if isSheetPresented {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.black)
                        .opacity(0.3)
                        .padding(.top, -60)
                        .padding(.bottom, -60)
                }
            }
            .navigationDestination(isPresented: $isAdminViewPresented) {
                AdminCodeView()
            }
        }
        .frame(maxHeight: .infinity)
        .onChange(of: urlHandler.selectedCategory) { category in
            if let category = category {
                reportData.selectedButton = category.rawValue
                if let section = urlHandler.selectedToiletSection {
                    reportData.selectedToiletSection = section
                } else if let section = urlHandler.selectedWashbasinSection {
                    reportData.selectedWashbasinSection = section
                }
                isSheetPresented = true
                urlHandler.selectedCategory = nil
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            SheetView(isSheetPresented: $isSheetPresented)
                .environmentObject(reportData)
                .presentationDetents(reportData.selectedButton == "sos" ? [.large] : reportData.selectedButton == "nfcToilet" ? [.height(519)] : [.medium])
        }
    }
}

struct HeaderView: View {
    var body: some View {
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
    }
}

struct AdminButton: View {
    @Binding var isAdminViewPresented: Bool
    
    var body: some View {
        Button(action: {
            isAdminViewPresented = true
        }) {
            Image(systemName: "person.badge.key")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.gray)
        }
        .padding(.trailing, 16)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct ButtonsView: View {
    @EnvironmentObject var reportData: ReportData
    @Binding var isSheetPresented: Bool
    
    let reportButtons = [
        "washbasin" : "세면대가\n막혔어요!",
        "toilet" : "변기가\n막혔어요!",
        "toiletpaper" : "휴지가\n없어요!",
        "sos" : "긴급한\n상황이에요!"
    ]
    
    let columns = [ GridItem(.flexible()), GridItem(.flexible()) ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(Category.allCases, id: \.self) { category in
                if let title = reportButtons[category.rawValue] {
                    ReportButton(title: title, category: category, action: {
                        reportData.selectedButton = category.rawValue
                        isSheetPresented = true
                    })
                }
            }
        }
        .padding()
    }
}

struct ReportButton: View {
    let title: String
    let category: Category
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
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
        .background(
            Image(category.rawValue)
                .resizable()
        )
        .cornerRadius(16.0)
    }
}

struct SheetView: View {
    @EnvironmentObject var reportData: ReportData
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        VStack {
            switch reportData.selectedButton {
            case Category.toilet.rawValue, Category.toiletpaper.rawValue:
                InAppToiletSheet()
            case Category.washbasin.rawValue:
                InAppWashbasinSheet()
            case Category.nfcToilet.rawValue:
                ToiletSheet()
            case Category.nfcWashbasin.rawValue:
                WashbasinSheet()
            case Category.sos.rawValue:
                InAppSOSSheet()
            default:
                MainView()
            }
            
            if reportData.selectedButton != Category.sos.rawValue {
                SendReportButton()
            }
        }
    }
}
