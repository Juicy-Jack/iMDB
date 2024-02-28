//
//  YoutubeVideos.swift
//  iMDB
//
//  Created by Furkan Doğan on 28.02.2024.
//

import SwiftUI
import WebKit

struct YoutubeVideo: View {
    let videoID: String
    var body: some View {
        YTVideo(videoID: videoID)
    }
}

struct YTVideo: UIViewRepresentable {
    
    let videoID: String
    
    func makeUIView(context: Context) -> some WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let YouTubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: YouTubeURL))
    }
}

#Preview {
    YoutubeVideo(videoID: "l91Km49W9qI")
}
