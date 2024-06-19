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
}

enum toiletSection: String, CaseIterable {
    case A
    case B
    case C
}

enum washbasinSection: String, CaseIterable {
    case A
    case B
}
