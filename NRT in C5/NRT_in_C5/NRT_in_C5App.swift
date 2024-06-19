//
//  ReporToiletApp.swift
//  ReporToilet
//
//  Created by EVIE on 6/18/24.
//

import SwiftUI
import SwiftData

@main
struct NRT_in_C5App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var urlHandler = URLHandler()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(urlHandler)
                .onOpenURL { url in
                    urlHandler.handle(url: url)
                }
        }
        .modelContainer(sharedModelContainer)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            NotificationCenter.default.post(name: .handleOpenURL, object: url)
            return true
        }
}

extension Notification.Name {
    static let handleOpenURL = Notification.Name("handleOpenURL")
}

class URLHandler: ObservableObject {
    @Published var selectedCategory: Category? = nil
    @Published var selectedToiletSection: String? = nil
    @Published var selectedWashbasinSection: String? = nil
    
    func handle(url: URL) {
        if url.host == "toilet" {
            selectedCategory = .toilet
            if let section = url.queryParameters?["section"] {
                selectedToiletSection = section
            } else {
                selectedToiletSection = "A"
            }
        } else if url.host == "washbasin" {
            selectedCategory = .washbasin
            if let section = url.queryParameters?["section"] {
                selectedWashbasinSection = section
            } else {
                selectedWashbasinSection = "A"
            }
        }
    }
}

extension URL {
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else { return nil }
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        return parameters
    }
}
