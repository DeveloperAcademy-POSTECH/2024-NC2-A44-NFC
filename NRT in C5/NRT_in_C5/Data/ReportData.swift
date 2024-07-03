//
//  ReportData.swift
//  NRT in C5
//
//  Created by EVIE on 6/30/24.
//

import SwiftUI

class ReportData: ObservableObject {
    @Published var selectedButton: String = ""
    @Published var selectedToiletSection: String = "A"
    @Published var selectedWashbasinSection: String = "A"
    @Published var selectedReports: Set<String> = [""]
    @Published var selectedGender: String = ""
    @Published var selectedFloor: String = ""
    
    func toggleReport(_ report: String) {
        if selectedReports.contains(report) {
            selectedReports.remove(report)
        } else {
            selectedReports.insert(report)
        }
    }
}

