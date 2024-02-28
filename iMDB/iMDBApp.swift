//
//  iMDBApp.swift
//  iMDB
//
//  Created by Furkan Doğan on 20.02.2024.
//

import SwiftUI

@main
struct iMDBApp: App {
    
    @StateObject var vm  = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, * ){
                NavigationStack {
                    
                    HomeView()
                        .toolbar(.hidden)
                }
                .environmentObject(vm)
            } else {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(vm)
            }
        }
    }
}
