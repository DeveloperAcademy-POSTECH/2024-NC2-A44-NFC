//
//  URL+Extensions.swift
//  NRT in C5
//
//  Created by EVIE on 6/20/24.
//

import Foundation

extension URL {
    func extractQueryParameters() -> [String: String] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else { return [:] }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        return parameters
    }
}
