//
//  BluetoothDemoUITests.swift
//  BluetoothDemoUITests
//
//  Created by Saniha Hunur on 15/12/25.
//

import XCTest

final class BluetoothDemoUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testScanAndNavigateToDeviceDetails() {

        // MARK: - Start Scan
        let startButton = app.buttons["Start Scan"]
        XCTAssertTrue(startButton.exists, "Start Scan button should exist")
        startButton.tap()

        // MARK: - Wait for at least one scanned device
        let firstCell = app.tables.cells.element(boundBy: 0)

        let exists = firstCell.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "At least one device should appear after scan")

        // MARK: - Tap device
        firstCell.tap()
    }
}
