//
//  BluetoothDemoUests.swift
//  BluetoothDemoUests
//
//  Created by Saniha Hunur on 15/12/25.
//

import XCTest
@testable import BluetoothDemo

final class ScanViewModelTests: XCTestCase {
    
    var viewModel: ScanViewModelProtocol!

    override func setUp() async throws {
        let provider = await LocalBLEDataProvider()
        await MainActor.run {
            self.viewModel = ScanViewModel(dataProvider: provider)
        }
    }

    override func tearDown() async throws {
        await MainActor.run {
            self.viewModel = nil
        }
    }

    func testDiscoveredDevicesInitiallyEmpty() async {
        await MainActor.run {
            XCTAssertTrue(viewModel.discoveredDevices.isEmpty, "Discovered devices should start empty")
        }
    }

    func testNoDuplicateDevices() async {
        await MainActor.run {
            viewModel.startScan()
        }

        await MainActor.run {
            let ids = viewModel.discoveredDevices.map { $0.id }
            XCTAssertEqual(ids.count, Set(ids).count, "Discovered devices should have no duplicates")
        }
    }
}
