//
//  BLEAdvertisement.swift
//  BluetoothDemo
//
//  Created by Saniha Hunur on 14/12/25.
//

import Foundation

struct BLEResponse: Codable {
    let advertisements: [BLEAdvertisement]
}

struct BLEAdvertisement: Codable, Identifiable {
    let id: String
    let name: String
    let rssi: Int
    let battery: Int
    let type: String
    let profile: String
    let advertisingData: AdvertisingData?
}

struct AdvertisingData: Codable {
    let serviceUUIDs: [String]
    let manufacturerData: String?
    let txPowerLevel: Int?
}
