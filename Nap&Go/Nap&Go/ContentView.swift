//
//  ContentView.swift
//  Nap&Go
//
//  Created by Анастасия Кравченко on 10.08.2022.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
            VStack {
                Text("So where we gonna go?")
                    .bold()
                    .font(.system(size: 32, weight: .heavy, design: .rounded))
                    
                    .frame(width: nil, height: 80, alignment: .center)
                    .background(.green)
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                    .ignoresSafeArea()
                    .tint(Color.blue)
                    .onAppear {
                        viewModel.checkIfLocationServicesIsEnabled()
                    }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 54.85,
            longitude: 83.11),
        span: MKCoordinateSpan(
            latitudeDelta: 0.03,
            longitudeDelta: 0.03)
    )
    
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
    
}
