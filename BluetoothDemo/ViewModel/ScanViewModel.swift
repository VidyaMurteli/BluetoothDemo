//
//  ScanViewModel.swift
//  BluetoothDemo
//
//  Created by Saniha Hunur on 14/12/25.
//

import Foundation

protocol BLEDataProviding {
    func loadDevices() -> [BLEAdvertisement]
}

final class LocalBLEDataProvider: BLEDataProviding {

    func loadDevices() -> [BLEAdvertisement] {
        guard let url = Bundle.main.url(forResource: "Bluetooth", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(BLEResponse.self, from: data)
        else { return [] }

        return response.advertisements
    }
}

//open for extension and closed for modification
@MainActor
protocol ScanViewModelProtocol: AnyObject {
    var discoveredDevices: [BLEAdvertisement] { get }
    var onUpdate: (() -> Void)? { get set }

    func startScan()
    func stopScan()
}

@MainActor
final class ScanViewModel: ScanViewModelProtocol {

    private let dataProvider: BLEDataProviding
    private let allDevices: [BLEAdvertisement]

    private(set) var discoveredDevices: [BLEAdvertisement] = [] {
        didSet { onUpdate?() }
    }

    private var timer: Timer?
    private var currentIndex = 0

    var onUpdate: (() -> Void)?

    init(dataProvider: BLEDataProviding) {
        self.dataProvider = dataProvider
        self.allDevices = dataProvider.loadDevices()
    }

    func startScan() {
        stopScan()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            Task { await self?.revealNext() }
        }
    }

    func stopScan() {
        timer?.invalidate()
        timer = nil
    }
    
    private func revealNext() {
        guard currentIndex < allDevices.count else {
            stopScan()
            return
        }
        let device = allDevices[currentIndex]
        if !discoveredDevices.contains(where: { $0.id == device.id }) {
            discoveredDevices.append(allDevices[currentIndex])
            onUpdate?()
        }
        currentIndex += 1
    }
}
