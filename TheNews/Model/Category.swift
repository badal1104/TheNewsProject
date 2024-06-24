//
//  Item.swift
//  TheNews
//
//

import Foundation
import SwiftData


@Model final class Category {
    var name: String
    init(name: String) {
        self.name = name
    }
}
