//
//  SwiftLabApp.swift
//  SwiftLab
//
//  Created by PC on 28/01/22.
//

import SwiftUI

@main
struct SwiftLabApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SettingsStore())
        }
    }
}
