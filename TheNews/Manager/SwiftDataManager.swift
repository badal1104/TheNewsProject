//
//  SwiftDataManager.swift
//  TheNews
//
//

import Foundation
import SwiftData

final class SwiftDataManager {
    static let shared = SwiftDataManager()
    private var context: ModelContext?
    private init() { }
    
    func setContext(context: ModelContext) {
        self.context = context
    }
    
    func fetchCategory() -> Category? {
        let category = try? context?.fetch(FetchDescriptor<Category>())
        return category?.last
    }
    
    func updateCategory(category: String) {
        let fetchCategory = fetchCategory()
        if let fetchCategory {
            fetchCategory.name = category
        }
    }
    
    func insert(category: String) {
        if fetchCategory() == nil {
            context?.insert(Category(name: category))
            do {
               try context?.save()
            } catch {
                debugPrint("error \(error.localizedDescription)")
            }
        }
    }
    
}
