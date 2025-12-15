//
//  ScanViewController.swift
//  BluetoothDemo
//
//  Created by Saniha Hunur on 14/12/25.
//

import UIKit

final class ScanViewController: UIViewController {
    
    private let tableView = UITableView()
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bluetooth Scan"
        setupUI()
        
        ScanViewModel.shared.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([            
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @IBAction func buttonStartScanTapped(_ sender: UIButton) {
        ScanViewModel.shared.startScan()
    }
    
    @IBAction func buttonStopScanTapped(_ sender: UIButton) {
        ScanViewModel.shared.stopScan()
    }
}

extension ScanViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ScanViewModel.shared.discoveredDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let device = ScanViewModel.shared.discoveredDevices[indexPath.row]
        cell.textLabel?.text = device.name
        cell.detailTextLabel?.text = "RSSI: \(device.rssi)"
        cell.imageView?.image = UIImage(systemName: "earbuds")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = ScanViewModel.shared.discoveredDevices[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DeviceDetailViewController") as? DeviceDetailViewController {
            vc.device = device
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
