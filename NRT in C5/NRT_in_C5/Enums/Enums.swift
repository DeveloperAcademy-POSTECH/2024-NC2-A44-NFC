//
//  Enums.swift
//  NRT in C5
//
//  Created by EVIE on 6/20/24.
//

import Foundation

enum Category: String, CaseIterable {
    case washbasin
    case toilet
    case toiletpaper
    case sos
    case nfcToilet
    case nfcWashbasin
}

enum ToiletSection: String, CaseIterable {
    case A
    case B
    case C
}

enum WashbasinSection: String, CaseIterable {
    case A
    case B
}

enum ReportType: String, CaseIterable {
    case toilet = "변기가 막혔어요!"
    case toiletpaper = "휴지가 없어요!"
}
