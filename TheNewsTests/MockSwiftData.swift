//
//  MockSwiftData.swift
//  TheNewsTests
//
//

import Foundation
import SwiftData
@testable import TheNews

final class MockSwiftData {
    public private(set) var container: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Category.self, configurations: config)
            return container
        } catch {
            fatalError("Failed to create container")
        }
    }()
    
   public private(set) var cacheManger = SwiftDataManager.shared
    
    @MainActor func setCacheManager() {
        cacheManger.setContext(context: container.mainContext)
    }
}
