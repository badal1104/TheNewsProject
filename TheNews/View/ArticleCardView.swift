//
//  ArticleCardView.swift
//  TheNews
//
//

import SwiftUI
import NukeUI
struct ArticleCardView: View {
    var article: NewsArticleModel
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)
                
                Text(article.description ?? NewsAppConstant.descriptionNotAvailable)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                VStack(alignment: .leading) {
                    Text(article.captionText)
                        .font(.caption)
                        .foregroundColor(.accentColor)
                        .lineLimit(1)
                    
                }
                .padding(.top, 5)
            }
            
            Spacer()
            VStack(alignment: .trailing) {
                if let urlString = article.urlToImage, let imageURL = URL(string: urlString) {
                    LazyImage(url: imageURL) { state in
                        if let image = state.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        } else { // Acts as a placeholder
                            placeholder
                        }
                    }
                } else {
                    placeholder
                }
                
            }
        }
        .buttonStyle(PlainButtonStyle())
        
    }
    
    @ViewBuilder
    private var placeholder: some View {
        Color.gray.opacity(0.7)
            .frame(width: 100, height: 100)
            .cornerRadius(10)
    }
}

#Preview {
    ArticleCardView(article: NewsArticleModel.myArticle)
}
