//
//  SystemMemory.swift
//  MemoryHog
//
//  Created by W. Brian Gourlie on 3/13/23.
//

import Foundation
import SwiftUI
import MachO

class SystemMemory: ObservableObject {
    @Published var processMemory: Int64 = 0
    let totalMemory = Int64(ProcessInfo.processInfo.physicalMemory)

    private var timer: Timer?

    init() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.processMemory = Self.getProcessMemoryUsage() ?? 0
        }
    }

    deinit {
        self.timer?.invalidate()
    }
    
    private static func getProcessMemoryUsage() -> Int64? {
        let TASK_VM_INFO_COUNT = mach_msg_type_number_t(MemoryLayout<task_vm_info_data_t>.size / MemoryLayout<integer_t>.size)
        let TASK_VM_INFO_REV1_COUNT = mach_msg_type_number_t(MemoryLayout.offset(of: \task_vm_info_data_t.min_address)! / MemoryLayout<integer_t>.size)
        var info = task_vm_info_data_t()
        var count = TASK_VM_INFO_COUNT
        let kr = withUnsafeMutablePointer(to: &info) { infoPtr in
            infoPtr.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { intPtr in
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), intPtr, &count)
            }
        }
        guard
            kr == KERN_SUCCESS,
            count >= TASK_VM_INFO_REV1_COUNT
        else { return nil }
        return Int64(info.phys_footprint)
    }
}

