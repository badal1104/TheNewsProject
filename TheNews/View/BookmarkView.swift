//
//  BookmarkView.swift
//  TheNews
//
//

import SwiftUI

struct BookmarkView: View {
    var newViewModel: [NewsArticleModel]
    var body: some View {
        List(newViewModel, id: \.id) { article in
            ZStack {
                NavigationLink(destination: ArticleDetailsView(article: article)) {  EmptyView() }
                    .opacity(0.0)
                ArticleCardView(article: article)
            }
        }
        .overlay(content: {
            if newViewModel.isEmpty {
                ContentUnavailableView.init(NewsAppConstant.bookmarkNotAdded, systemImage: NewsAppConstant.Images.emptyBookmark)}
            
        })
        .listStyle(.plain)
        .navigationTitle(NewsAppConstant.bookmark)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    BookmarkView(newViewModel: [NewsArticleModel.myArticle])
}
