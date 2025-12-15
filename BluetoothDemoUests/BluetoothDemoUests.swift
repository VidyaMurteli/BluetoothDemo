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
        let vm = ScanViewModel()
        vm.startScan()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let ids = vm.discoveredDevices.map { $0.id }
            XCTAssertEqual(ids.count, Set(ids).count)
        }
    }
}
