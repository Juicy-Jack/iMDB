//
//  ContentView.swift
//  iMDB
//
//  Created by Furkan Doğan on 20.02.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!".replacingOccurrences(of: " ", with: "%20"))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
