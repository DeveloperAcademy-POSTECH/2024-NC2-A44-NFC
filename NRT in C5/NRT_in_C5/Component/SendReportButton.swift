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
                MessageComposeView()
            }
        }
}

struct MessageComposeView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let composeViewController = MFMessageComposeViewController()
        composeViewController.messageComposeDelegate = context.coordinator
        composeViewController.recipients = ["jelly09@postech.ac.kr"]
        composeViewController.body = "🧻 5층 여자화장실 변기 B칸 휴지가 없어요!!"
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

