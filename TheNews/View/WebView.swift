//
//  ArticleDetailsView.swift
//  TheNews
//
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL?
    var webViewModel: WebViewModel
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url else {
            debugPrint("url is nil >>>>>>>")
            return
        }
        let request = URLRequest(url: url)
        uiView.isOpaque = false
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension WebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.parent.webViewModel.updateLoadingFlag(value: true)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            debugPrint("loading finished")
            self.parent.webViewModel.updateBothIsLoadingAndError()
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            if let nsError = error as NSError? {
                debugPrint("Failed loading with error: \(nsError.localizedDescription)")
                self.parent.webViewModel.updateBothIsLoadingAndError(error: nsError.localizedDescription)
            }
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            if let nsError = error as NSError? {
                debugPrint("Failed loading with error: \(nsError.localizedDescription)")
                self.parent.webViewModel.updateBothIsLoadingAndError(error: nsError.localizedDescription)
            }
        }
        
    }
}
