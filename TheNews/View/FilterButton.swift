//
//  FilterButton.swift
//  TheNews
//
//

import SwiftUI

struct FilterButton: View {
    var viewModel: NewsListViewModel
    var category: String
    var body: some View {
        Button(action: {
            viewModel.filterNews(by: category)
        }) {
            Label(category, systemImage: viewModel.selectedCategory == category ? NewsAppConstant.Images.circleSelection : NewsAppConstant.Images.circle)
        }
    }
}

#Preview {
    FilterButton(viewModel: NewsListViewModel(), category: NewsCategories.business.rawValue)
}
