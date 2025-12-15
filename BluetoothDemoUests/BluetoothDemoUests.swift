//
//  BluetoothDemoUests.swift
//  BluetoothDemoUests
//
//  Created by Saniha Hunur on 15/12/25.
//

import XCTest
@testable import BluetoothDemo

final class ScanViewModelTests: XCTestCase {
    
    func testNoDuplicates() {
        ScanViewModel.shared.startScan()
        let ids = ScanViewModel.shared.discoveredDevices.map { $0.id }
        XCTAssertEqual(ids.count, Set(ids).count)
    }
}
