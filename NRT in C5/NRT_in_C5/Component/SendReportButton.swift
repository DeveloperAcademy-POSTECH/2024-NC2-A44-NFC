//
//  SendReportButton.swift
//  NRT in C5
//
//  Created by EVIE on 6/19/24.
//

import SwiftUI
import MessageUI

struct SendReportButton: View {
    @State private var isShowingMessageCompose = false
    @Binding var selectedButton: String
    @Binding var selectedToiletSection: String
    @Binding var selectedWashbasinSection: String
    
    var body: some View {
        VStack {
            Button(action: {
                isShowingMessageCompose = true
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
        .sheet(isPresented: $isShowingMessageCompose) {
            MessageComposeView(selectedButton: $selectedButton, selectedToiletSection: $selectedToiletSection, selectedWashbasinSection: $selectedWashbasinSection)
        }
    }
}

struct MessageComposeView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedButton: String
    @Binding var selectedToiletSection: String
    @Binding var selectedWashbasinSection: String
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let composeViewController = MFMessageComposeViewController()
        composeViewController.messageComposeDelegate = context.coordinator
        composeViewController.recipients = ["jelly09@postech.ac.kr"]
        if selectedButton == "toilet" {
            composeViewController.body = "🚽 5층 여자화장실 변기 \(selectedToiletSection)칸 막혔어요!"
        } else if selectedButton == "washbasin" || selectedButton == "nfcWashbasin" {
            composeViewController.body = "🧼 세면대 \(selectedWashbasinSection)칸 막혔어요!"
        } else if selectedButton == "toiletpaper"  {
            composeViewController.body = "🧻 5층 여자화장실 변기 \(selectedToiletSection)칸 휴지가 없어요!"
        } else if selectedButton == "nfcToilet"  {
            composeViewController.body = "🧻 5층 여자화장실 변기 \(selectedToiletSection)칸 휴지도 없고 변기도 막혔어요!"
        } else {
            composeViewController.body = "‼️ 5층 여자화장실 도움이 필요해요!"
        }
        return composeViewController
    }
    
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        var parent: MessageComposeView
        
        init(_ parent: MessageComposeView) {
            self.parent = parent
        }
        
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            switch result {
            case .cancelled:
                print("Cancelled")
            case .sent:
                print("Sent message:", controller.body ?? "")
            case .failed:
                print("Failed")
            @unknown default:
                print("Unknown Error")
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

