//
//  SendReportButton.swift
//  NRT in C5
//
//  Created by EVIE on 6/19/24.
//

import SwiftUI
import MessageUI

struct SendReportButton: View {
    @EnvironmentObject var reportData: ReportData
    @Environment(\.modelContext) private var modelContext
    @State private var isShowingMessageCompose = false
    
    var body: some View {
        VStack {
            Button(action: {
                isShowingMessageCompose = true
                addReport()
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
        .padding(.bottom, 40)
        .padding(.top, 10)
        .sheet(isPresented: $isShowingMessageCompose) {
            MessageComposeView()
                .environmentObject(reportData)
        }
    }
    private func addReport() {
        let newReport = ReportModel(
            id: UUID(),
            date: Date(),
            category: reportData.selectedButton,
            toiletSection: reportData.selectedToiletSection,
            washbasinSection: reportData.selectedWashbasinSection,
            reports: reportData.selectedReports,
            gender: reportData.selectedGender,
            floor: reportData.selectedFloor
        )
        modelContext.insert(newReport)
    }
}

struct MessageComposeView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var reportData: ReportData
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let composeViewController = MFMessageComposeViewController()
        composeViewController.messageComposeDelegate = context.coordinator
        composeViewController.recipients = ["haepark24@pos.idserve.net"]
        
        var bodyText: String
        
        switch reportData.selectedButton {
        case Category.toilet.rawValue:
            bodyText = "🚽 \(reportData.selectedFloor)층 \(reportData.selectedGender == "male" ? "남자" : "여자")화장실 변기 \(reportData.selectedToiletSection)칸 막혔어요!"
        case Category.washbasin.rawValue, Category.nfcWashbasin.rawValue:
            bodyText = "🧼 \(reportData.selectedFloor)층 \(reportData.selectedGender == "male" ? "남자" : "여자")화장실 세면대 \(reportData.selectedWashbasinSection)칸 막혔어요!"
        case Category.toiletpaper.rawValue:
            bodyText = "🧻 \(reportData.selectedFloor)층 \(reportData.selectedGender == "male" ? "남자" : "여자")화장실 변기 \(reportData.selectedToiletSection)칸 휴지가 없어요!"
        case Category.nfcToilet.rawValue:
            let reports = reportData.selectedReports.joined(separator: " ")
            bodyText = "🧻 \(reportData.selectedFloor)층 \(reportData.selectedGender == "male" ? "남자" : "여자")화장실 변기 \(reportData.selectedToiletSection)칸\(reports)"
        case Category.sos.rawValue:
            bodyText = "‼️ \(reportData.selectedFloor)층 \(reportData.selectedGender == "male" ? "남자" : "여자")화장실 도움이 필요해요!"
        default:
            bodyText = "Unknown report type."
        }
        
        composeViewController.body = bodyText
        return composeViewController
    }
    
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        @Environment(\.modelContext) private var modelContext
        var parent: MessageComposeView
        
        init(_ parent: MessageComposeView) {
            self.parent = parent
        }
        
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            switch result {
            case .cancelled:
                print("Cancelled")
            case .sent:
                if let body = controller.body {
                    print("Sent message:", body)
                    saveReport(bodyText: body)
                }
            case .failed:
                print("Failed")
            @unknown default:
                print("Unknown Error")
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        private func saveReport(bodyText: String) {
            let newReport = ReportModel(
                id: UUID(),
                date: Date(),
                category: parent.reportData.selectedButton,
                toiletSection: parent.reportData.selectedToiletSection,
                washbasinSection: parent.reportData.selectedWashbasinSection,
                reports: parent.reportData.selectedReports,
                gender: parent.reportData.selectedGender,
                floor: parent.reportData.selectedFloor
            )
            modelContext.insert(newReport)
            do {
                try modelContext.save()
                print("Report saved successfully")
            } catch {
                print("Failed to save report: \(error)")
            }
        }
    }
}
