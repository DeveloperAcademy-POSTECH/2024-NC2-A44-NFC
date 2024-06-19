//
//  NFCReadAndWrite.swift
//  NRT in C5
//
//  Created by EVIE on 6/19/24.
//

import SwiftUI
import CoreNFC

struct NFCReadAndWrite: View {
    @State var urlT = ""
    @State var writer = NFCReader()
    var body: some View {
        VStack {
            TextField("Enter URL", text: $urlT)
            Button(action: {
                writer.scan(theactualdata: urlT)
            }) {
                Text("Write To Tag")
            }
            .padding()
        }
    }
}

class NFCReader: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {
    var theactualData = ""
    var nfcSession: NFCNDEFReaderSession?
    
    func scan(theactualdata: String) {
        theactualData = theactualdata
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "NFC카드를 가까이 대주세요"
        nfcSession?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) { }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) { }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        let str:String = theactualData
        if tags.count > 1 {
            let retryInterval = DispatchTimeInterval.milliseconds(500)
            session.alertMessage = "NFC 카드를 하나만 대주세요. 다시 시도해주세요."
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
                session.restartPolling()
            })
            return
        }
        let tag = tags.first!
        session.connect(to: tag, completionHandler: {(error: Error?) in
            if nil != error {
                session.alertMessage = "연결이 되지 않았습니다"
                session.invalidate()
                return
            }
            tag.queryNDEFStatus(completionHandler: {(ndefstatus: NFCNDEFStatus, capacity: Int, error: Error?) in
                guard error == nil else {
                    session.alertMessage = "연결이 되지 않았습니다"
                    session.invalidate()
                    return
                }
                switch ndefstatus {
                case .notSupported:
                    session.alertMessage = "연결이 되지 않았습니다"
                    session.invalidate()
                case .readOnly:
                    session.alertMessage = "연결이 되지 않았습니다"
                    session.invalidate()
                case .readWrite:
                    tag.writeNDEF(.init(records: [NFCNDEFPayload.wellKnownTypeURIPayload(string: "\(str)")!]), completionHandler: {(error: Error?) in if nil != error {
                        session.alertMessage = "NDEF 메시지를 읽어오기에 실패했습니다"
                    } else {
                        session.alertMessage = "성공적으로 태그에 연결되었습니다"
                    }
                        session.invalidate()
                    })
                @unknown default:
                    session.alertMessage = "알 수 없는 에러"
                }
            })
        })
    }
}
