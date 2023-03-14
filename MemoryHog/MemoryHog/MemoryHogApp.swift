//
//  MemoryHogApp.swift
//  MemoryHog
//
//  Created by W. Brian Gourlie on 3/13/23.
//

import SwiftUI

@main
struct MemoryHogApp: App {
    @StateObject var systemMemory = SystemMemory()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(systemMemory)
        }
    }
}
