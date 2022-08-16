//
//  MapView.swift
//  Nap&Go
//
//  Created by Анастасия Кравченко on 16.08.2022.
//

import Foundation
import MapKit
import SwiftUI
import UIKit

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    
    let mapView = MKMapView()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        mapView.tintColor = .blue
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.region = region
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor),
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
        var parent: MapView

        var recognizer = UITapGestureRecognizer()

        init(_ parent: MapView) {
            self.parent = parent
            super.init()
            self.recognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
            self.recognizer.delegate = self
            self.parent.mapView.addGestureRecognizer(recognizer)
        }

        @objc func tapHandler(_ gesture: UITapGestureRecognizer) {
            // position on the screen, CGPoint
            let location = recognizer.location(in: self.parent.mapView)
            // position on the map, CLLocationCoordinate2D
            let coordinate = self.parent.mapView.convert(location, toCoordinateFrom: self.parent.mapView)
            print(coordinate)
            
        }
    }
}
