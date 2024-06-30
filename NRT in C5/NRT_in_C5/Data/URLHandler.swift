//
//  URLHandler.swift
//  NRT in C5
//
//  Created by EVIE on 6/30/24.
//

import SwiftUI

class URLHandler: ObservableObject {
    @Published var selectedCategory: Category? = nil
    @Published var selectedToiletSection: String? = nil
    @Published var selectedWashbasinSection: String? = nil
    
    var reportData: ReportData?
    
    func handle(url: URL) {
        if url.host == "toilet" {
            selectedCategory = .nfcToilet
            if let section = url.queryParameters?["section"] {
                selectedToiletSection = section
            } else {
                selectedToiletSection = "A"
            }
            
            reportData?.selectedButton = Category.nfcToilet.rawValue
            reportData?.selectedToiletSection = selectedToiletSection ?? "A"
            
        } else if url.host == "washbasin" {
            selectedCategory = .nfcWashbasin
            if let section = url.queryParameters?["section"] {
                selectedWashbasinSection = section
            } else {
                selectedWashbasinSection = "A"
            }
            
            reportData?.selectedButton = Category.nfcWashbasin.rawValue
            reportData?.selectedWashbasinSection = selectedWashbasinSection ?? "A"
            
        }
    }
}

