//
//  ReportModel.swift
//  NRT in C5
//
//  Created by EVIE on 7/5/24.
//

import SwiftUI
import SwiftData

@Model
final class ReportModel {
    var id: UUID
    var date: Date
    var category: Category
    var toiletSection: String = ""
    var washbasinSection: String = ""
    var reports: Set<String> = [""]
    var gender: String = ""
    var floor: String = ""
    
    init(id: UUID, date: Date, category: Category, toiletSection: String, washbasinSection: String, reports: Set<String>, gender: String, floor: String) {
        self.id = id
        self.date = date
        self.category = category
        self.toiletSection = toiletSection
        self.washbasinSection = washbasinSection
        self.reports = reports
        self.gender = gender
        self.floor = floor
    }
}
