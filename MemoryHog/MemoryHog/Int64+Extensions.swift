//
//  UInt64+Extensions.swift
//  MemoryHog
//
//  Created by W. Brian Gourlie on 3/13/23.
//

import Foundation

extension Int64 {
    private static let formatter: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB, .useTB]
        formatter.countStyle = .file
        return formatter
    }()
    
    func format() -> String {
        return Self.formatter.string(fromByteCount: Int64(self))
    }
}
