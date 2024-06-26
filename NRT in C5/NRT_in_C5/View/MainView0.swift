////
////  MainView0.swift
////  NRT in C5
////
////  Created by EVIE on 6/30/24.
////
//
//import SwiftUI
//
//struct MainView0: View {
//    @EnvironmentObject var urlHandler: URLHandler
//    @State private var isSheetPresented: Bool = false
//    @State private var selectedButton: String = ""
//    @State private var selectedToiletSection: String = "A"
//    @State private var selectedWashbasinSection: String = "A"
//    @State private var selectedReports: Set<String> = ["변기가 막혔어요!", "휴지가 없어요!"]
//    
//    var body: some View {
//        ZStack {
//            VStack {
//                HeaderView()
//                
//                ButtonsView(isSheetPresented: $isSheetPresented, selectedButton: $selectedButton)
//                    .padding(.bottom, 50)
//                
//                AdminButton()
//            }
//            .blur(radius: isSheetPresented ? 12 : 0)
//            
//            if isSheetPresented {
//                Rectangle()
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .background(.black)
//                    .opacity(0.3)
//                    .padding(.top, -60)
//                    .padding(.bottom, -60)
//            }
//        }
//        .frame(maxHeight: .infinity)
//        .onChange(of: urlHandler.selectedCategory) { category in
//            if let category = category {
//                selectedButton = category.rawValue
//                if let section = urlHandler.selectedToiletSection {
//                    selectedToiletSection = section
//                } else if let section = urlHandler.selectedWashbasinSection {
//                    selectedWashbasinSection = section
//                }
//                isSheetPresented = true
//                urlHandler.selectedCategory = nil
//            }
//        }
//        .sheet(isPresented: $isSheetPresented) {
//            SheetView(isSheetPresented: $isSheetPresented, selectedButton: $selectedButton, selectedToiletSection: $selectedToiletSection, selectedWashbasinSection: $selectedWashbasinSection, selectedReports: $selectedReports)
//                .presentationDetents(selectedButton == "sos" ? [.large] : selectedButton == "nfcToilet" ? [.height(519)] : [.medium])
//        }
//    }
//}
//
//struct HeaderView: View {
//    var body: some View {
//        VStack(alignment: .leading, spacing: 3.0) {
//            Text("매콤 5층 여자화장실")
//                .font(.system(size: 34))
//                .bold()
//            Text("깨끗한 화장실을 함께 만들어요")
//                .font(.system(size: 18))
//        }
//        .padding(.leading, 20)
//        .padding(.bottom, 20)
//        .frame(maxWidth: .infinity, alignment: .leading)
//    }
//}
//
//struct AdminButton: View {
//    var body: some View {
//        Button(action: {}) {
//            Image(systemName: "person.badge.key")
//                .resizable()
//                .frame(width: 24, height: 24)
//                .foregroundColor(.gray)
//        }
//        .padding(.trailing, 16)
//        .frame(maxWidth: .infinity, alignment: .trailing)
//    }
//}
//
//struct ButtonsView: View {
//    let reportButtons = [
//        "washbasin" : "세면대가\n막혔어요!",
//        "toilet" : "변기가\n막혔어요!",
//        "toiletpaper" : "휴지가\n없어요!",
//        "sos" : "긴급한\n상황이에요!"
//    ]
//    
//    let columns = [ GridItem(.flexible()), GridItem(.flexible()) ]
//    
//    @Binding var isSheetPresented: Bool
//    @Binding var selectedButton: String
//    
//    var body: some View {
//        LazyVGrid(columns: columns, spacing: 16) {
//            ForEach(Category.allCases, id: \.self) { category in
//                if let title = reportButtons[category.rawValue] {
//                    ReportButton(title: title, category: category, action: {
//                        selectedButton = category.rawValue
//                        isSheetPresented = true
//                    })
//                }
//            }
//        }
//        .padding()
//    }
//}
//
//struct ReportButton: View {
//    let title: String
//    let category: Category
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            VStack {
//                Spacer()
//                Text(title)
//                    .font(.system(size: 28))
//                    .multilineTextAlignment(.leading)
//                    .bold()
//                    .padding(.bottom)
//                    .foregroundStyle(.white)
//                    .padding(.leading, 16)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//            }
//        }
//        .frame(width: 171, height: 241)
//        .background(
//            Image(category.rawValue)
//                .resizable()
//        )
//        .cornerRadius(16.0)
//    }
//}
//
//struct SheetView: View {
//    @Binding var isSheetPresented: Bool
//    @Binding var selectedButton: String
//    @Binding var selectedToiletSection: String
//    @Binding var selectedWashbasinSection: String
//    @Binding var selectedReports: Set<String>
//    
//    var body: some View {
//        VStack {
//            if selectedButton == Category.toilet.rawValue || selectedButton == Category.toiletpaper.rawValue {
//                InAppToiletSheet(selectedInAppToiletSection: $selectedToiletSection)
//            } else if selectedButton == Category.washbasin.rawValue {
//                InAppWashbasinSheet(selectedInAppWashbasinSection: $selectedWashbasinSection)
//            } else if selectedButton == Category.nfcToilet.rawValue {
//                ToiletSheet(selectedToiletSection: $selectedToiletSection)
//            } else if selectedButton == Category.nfcWashbasin.rawValue {
//                WashbasinSheet(selectedWashbasinSection: $selectedWashbasinSection)
//            } else {
//                InAppSOSSheet()
//            }
//            
//            if selectedButton != Category.sos.rawValue {
//                SendReportButton(selectedButton: $selectedButton, selectedToiletSection: $selectedToiletSection, selectedWashbasinSection: $selectedWashbasinSection, selectedReports: $selectedReports)
//            }
//        }
//    }
//}
//
