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
    @Published var selectedGender: String? = nil
    @Published var selectedFloor: String? = nil
    
    var reportData: ReportData?
    
    func handle(url: URL) {
        let parameters = url.extractQueryParameters()
        
        switch url.host {
        case "toilet":
            selectedCategory = .nfcToilet
            selectedToiletSection = parameters["section"] ?? "A"
            selectedGender = parameters["gender"] ?? "male"
            selectedFloor = parameters["floor"] ?? "7"
            
            reportData?.selectedButton = Category.nfcToilet.rawValue
            reportData?.selectedToiletSection = selectedToiletSection ?? "A"
            reportData?.selectedGender = selectedGender ?? "male"
            reportData?.selectedFloor = selectedFloor ?? "7"
            
        case "washbasin":
            selectedCategory = .nfcWashbasin
            selectedWashbasinSection = parameters["section"] ?? "A"
            selectedGender = parameters["gender"] ?? "male"
            selectedFloor = parameters["floor"] ?? "7"
            
            reportData?.selectedButton = Category.nfcWashbasin.rawValue
            reportData?.selectedWashbasinSection = selectedWashbasinSection ?? "A"
            reportData?.selectedGender = selectedGender ?? "male"
            reportData?.selectedFloor = selectedFloor ?? "7"
            
        default:
            break
        }
    }
}
