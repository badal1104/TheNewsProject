//
//  ArticleDetailsView.swift
//  TheNews
//
//

import SwiftUI

struct ArticleDetailsView: View {
    @Environment(NewsListViewModel.self) private var viewModel
    var article: NewsArticleModel
    @State private var isLoading = true
    @State private var webViewModel = WebViewModel()
    
    var body: some View {
        ZStack  {
            WebView(url: URL(string: article.url), webViewModel: webViewModel)
                .navigationTitle(NewsAppConstant.detials)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action: {
                    viewModel.bookmark(article: article)
                }) {
                    HStack(spacing: 10) {
                        if webViewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                                .scaleEffect(1.5, anchor: .center)
                                .background(Color.clear)
                        }
                        
                        Image(systemName: article.isBookmark ? NewsAppConstant.Images.bookmarkFill : NewsAppConstant.Images.bookmark)
                            .foregroundColor(.blue)
                    }
                })
                .ignoresSafeArea()
                .onAppear {
                    viewModel.checkBookmark(article: article)
                }
            if !webViewModel.error.isEmpty {
                VStack {
                    Text(NewsAppConstant.failedToLoadContent)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
        }
    }
}

#Preview {
    ArticleDetailsView(article: NewsArticleModel.myArticle)
        .environment(NewsListViewModel())
}
