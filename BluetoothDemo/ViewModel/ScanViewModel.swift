//
//  ScanViewModel.swift
//  BluetoothDemo
//
//  Created by Saniha Hunur on 14/12/25.
//

import Foundation

final class ScanViewModel {

    private(set) var allDevices: [BLEAdvertisement] = []
    private(set) var discoveredDevices: [BLEAdvertisement] = []

    private var timer: Timer?
    private var currentIndex = 0

    var onUpdate: (() -> Void)?

    init() {
        loadJSON()
    }

    private func loadJSON() {
        guard let url = Bundle.main.url(forResource: "Bluetooth", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(BLEResponse.self, from: data)
        else { return }
        allDevices = response.advertisements
    }

    func startScan() {
        stopScan()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.revealNextDevice()
        }
    }

    func stopScan() {
        timer?.invalidate()
        timer = nil
    }

    private func revealNextDevice() {
        guard currentIndex < allDevices.count else {
            stopScan()
            return
        }
        let device = allDevices[currentIndex]
        if !discoveredDevices.contains(where: { $0.id == device.id }) {
            discoveredDevices.append(device)
            onUpdate?()
        }
        currentIndex += 1
    }
}
