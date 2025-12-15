//
//  DeviceDetailViewController.swift
//  BluetoothDemo
//
//  Created by Saniha Hunur on 14/12/25.
//

import UIKit

final class DeviceDetailViewController: UIViewController {
    
    @IBOutlet weak var lblDeviceDetails: UILabel!
    var device: BLEAdvertisement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Device Details"
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = .systemBackground
        lblDeviceDetails.text = """
        RSSI: \(device.rssi)
        Battery: \(device.battery)%
        Type: \(device.type)
        Profile: \(device.profile)
        
        About Bluetooth:
        Bluetooth is a short-range wireless technology.
        """
    }
}
