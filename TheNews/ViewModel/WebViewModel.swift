//
//  WebViewModel.swift
//  TheNews
//
//

import Foundation
import SwiftUI

@Observable final class WebViewModel {
    var isLoading = true
    var error = ""
    
    func updateLoadingFlag(value: Bool = false) {
        isLoading = value
    }
    
    func updateErrorValue(value: String = "") {
        error = value
    }
    
    func updateBothIsLoadingAndError(with isLoading: Bool = false, error value: String = "") {
        updateLoadingFlag(value: isLoading)
        updateErrorValue(value: value)
    }
}
