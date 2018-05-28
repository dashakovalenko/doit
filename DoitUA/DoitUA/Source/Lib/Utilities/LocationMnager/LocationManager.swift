//
//  LocationManager.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/28/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {

    var currentCoodrinate: CLLocationCoordinate2D?
    
    private lazy var locationManager: CLLocationManager = { [unowned self] in
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        
        return locationManager
        }()
    
    //MARK: - Public
    
    func startUpdating() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdating() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentCoodrinate = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(String(describing: error))
    }
}
