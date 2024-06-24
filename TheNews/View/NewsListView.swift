//
//  NewsListView.swift
//  TheNews
//
//

import SwiftUI

struct NewsListView: View {
    @Environment(NewsListViewModel.self) private var newListViewModel
   
    var body: some View {
        @Bindable var newListViewModel = newListViewModel
        NavigationStack {
            VStack {
                if !newListViewModel.messageString.isEmpty {
                    errorView
                } else {
                    List(newListViewModel.article ?? []) { article in
                        ZStack {
                            NavigationLink(value: article) {  EmptyView() }
                                .opacity(0.0)
                            ArticleCardView(article: article)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            
            .navigationTitle(newListViewModel.selectedCategory)
            .navigationDestination(for: NewsArticleModel.self) { value in
                ArticleDetailsView(article: value)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    menu
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        newListViewModel.isShowingBookmarks = true
                    }) {
                        Label(NewsAppConstant.bookmark, systemImage: !newListViewModel.bookmarkArticle.isEmpty ? NewsAppConstant.Images.bookmarkFill : NewsAppConstant.Images.bookmark)
                    }
                }
                
            }
            .navigationDestination(isPresented: $newListViewModel.isShowingBookmarks, destination: {
                BookmarkView(newViewModel: newListViewModel.bookmarkArticle)
            })
        }
        .overlay(content: {
            if newListViewModel.isLoading {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                ProgressView(NewsAppConstant.loading)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .scaleEffect(1.5, anchor: .center)
                    .foregroundColor(.white)
            }
        })
        .refreshable(action: {
            await fetchNews()
        })
        .task {
            await fetchNews()
        }
        
    }
    
    // MARK: - Filter Menu
    @ViewBuilder
    private var menu: some View {
        Menu {
            ForEach(NewsCategories.allCases) { value in
                FilterButton(viewModel: newListViewModel, category: value.rawValue)
            }
        } label: {
            Image(systemName: NewsAppConstant.Images.filter)
        }
    }
    
    // MARK: - ErrorView
    @ViewBuilder
    private var errorView: some View {
        VStack {
            Text(newListViewModel.messageString)
                .foregroundColor(.red)
                .padding(.bottom, 10)
            
            Button(action: {
                Task {
                    await fetchNews()
                }
            }) {
                Image(systemName: NewsAppConstant.Images.refreshIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
    
    private func fetchNews() async {
        let topHeadlines = APIEndPoints.topHeadlines(urlParameters: ["country": NewsAppConstant.defaultCountry, "category" : newListViewModel.selectedCategory])
        await newListViewModel.getLatestNews(endPoint: topHeadlines)
    }
}

#Preview {
    NewsListView()
        .environment(NewsListViewModel())
}

