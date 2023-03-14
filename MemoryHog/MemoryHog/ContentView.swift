//
//  ContentView.swift
//  MemoryHog
//
//  Created by W. Brian Gourlie on 3/13/23.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var systemMemory: SystemMemory
    @State private var amountToAllocate = 1.0
    private static var allocations = [[UInt8]]()

    var body: some View {
        VStack {
            Text("Total System Memory: \(systemMemory.totalMemory.format())")
            Text("Process Memory: \(systemMemory.processMemory.format())")
            Slider(
                        value: $amountToAllocate,
                        in: 1.0...Double(systemMemory.totalMemory)
                    )
            Text("Amount to Allocate: \(Int64(amountToAllocate).format())")
            Button("Allocate") {
                Self.allocations.append([UInt8](repeating: 0, count: Int(amountToAllocate)))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
