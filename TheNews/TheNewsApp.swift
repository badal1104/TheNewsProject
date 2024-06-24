//
//  TheNewsApp.swift
//  TheNews
//
//

import SwiftUI
import SwiftData

@main
struct TheNewsApp: App {
    @State private var newViewModel: NewsListViewModel

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Category.self,
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
            NewsListView()
                .environment(newViewModel)
            
        }
        .modelContainer(sharedModelContainer)
    }
    
    init() {
        SwiftDataManager.shared.setContext(context: sharedModelContainer.mainContext)
        let viewModel = NewsListViewModel(cacheManager: SwiftDataManager.shared)
        _newViewModel = State(initialValue: viewModel)
    }
   
    
}
