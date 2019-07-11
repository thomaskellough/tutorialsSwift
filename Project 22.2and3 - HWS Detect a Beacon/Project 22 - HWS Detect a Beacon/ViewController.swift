//
//  ViewController.swift
//  Project 22 - HWS Detect a Beacon
//
//  Created by Thomas Kellough on 7/8/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var distanceReading: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var circleImage: UIView!
    var locationManager: CLLocationManager?
    var alertShown: Bool?
    var beaconDict: [String: String]?
    var labelName: String?
    var allBeacons = [Beacon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        circleImage.layer.cornerRadius = 207
        
        alertShown = false
        
        let beacon1 = Beacon(uuid: UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!, major: 123, minor: 456, identifier: "Apple Beacon")
        let beacon2 = Beacon(uuid: UUID(uuidString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6")!, major: 123, minor: 456, identifier: "Radius Beacon")
        let beacon3 = Beacon(uuid: UUID(uuidString: "5AFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF")!, major: 123, minor: 456, identifier: "Red Bear Beacon")
        let beacon4 = Beacon(uuid: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, major: 123, minor: 456, identifier: "Estimote")
        allBeacons += [beacon1, beacon2, beacon3, beacon4]
        view.backgroundColor = .gray  // default is in "unknown mode"
 
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // Can we monitor beacons or not?
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                //  Can we detect the distance of a beacon?
                if CLLocationManager.isRangingAvailable() {
                    for beacon in allBeacons {
                        startScanning(uuid: beacon.uuid!, major: beacon.major!, minor: beacon.minor!, identifier: beacon.identifier!)
                    }
                }
            }
        }
    }
    
    func beaconAlert() {
        alertShown = true
        let ac = UIAlertController(title: "Beacon Detected", message: "A beacon has been detected", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    func startScanning(uuid: UUID, major: UInt16, minor: UInt16, identifier: String) {
        let uuidApple = uuid
        let beaconRegion1 = CLBeaconRegion(proximityUUID: uuidApple, major: major, minor: minor, identifier: identifier)
        locationManager?.startMonitoring(for: beaconRegion1)
        locationManager?.startRangingBeacons(in: beaconRegion1)
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
                self.circleImage.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
                self.circleImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "RIGHT HERE"
                self.circleImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKNOWN"
                self.circleImage.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            if !alertShown! { beaconAlert() }
            for beac in allBeacons {
                if beac.uuid == beacon.proximityUUID {
                    nameLabel.text = beac.identifier
                }
            }
            update(distance: beacon.proximity)
        }
    }
}

