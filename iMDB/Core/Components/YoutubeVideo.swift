//
//  YoutubeVideos.swift
//  iMDB
//
//  Created by Furkan Doğan on 28.02.2024.
//

import SwiftUI
import WebKit

struct YoutubeVideo: View {
    let videos: Videos?
    var body: some View {
        if (videos != nil) {
            if (!(videos!.results.isEmpty)) {
                let trailerKey = videos!.results[0].key
                YTVideo(videoID: trailerKey!)
            }
        }
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
/*
#Preview {
    YoutubeVideo(videos: )
}
*/
