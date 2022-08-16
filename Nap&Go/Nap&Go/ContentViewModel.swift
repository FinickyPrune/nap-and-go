//
//  ContentViewModel.swift
//  Nap&Go
//
//  Created by Анастасия Кравченко on 16.08.2022.
//

import Foundation
import MapKit
import SwiftUI

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 54.85,
            longitude: 83.11),
        span: MKCoordinateSpan(
            latitudeDelta: 0.03,
            longitudeDelta: 0.03)
    )
    
    private var currentPlace: CLPlacemark?
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("")
        case .denied:
            print("")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
      // 1
      guard status == .authorizedWhenInUse else {
        return
      }
      manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      guard let firstLocation = locations.first else {
        return
      }

      // TODO: Configure MKLocalSearchCompleter here...

      // 2
      CLGeocoder().reverseGeocodeLocation(firstLocation) { places, _ in
        // 3
//        guard
//          let firstPlace = places?.first,
//          self.originTextField.contents == nil
//          else {
//            return
//        }
//
//
//        // 4
//        self.currentPlace = firstPlace
//        self.originTextField.text = firstPlace.abbreviation
      }
    }

    
}
