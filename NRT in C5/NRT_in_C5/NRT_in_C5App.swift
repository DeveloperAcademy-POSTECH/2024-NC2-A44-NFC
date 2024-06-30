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
    @StateObject var reportData = ReportData()
    
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
                .environmentObject(reportData)
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
