//
//  ContentView.swift
//  Nap&Go
//
//  Created by Анастасия Кравченко on 10.08.2022.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 40.7,
            longitude: -74),
        span: MKCoordinateSpan(
            latitudeDelta: 10,
            longitudeDelta: 10)
    )
    
    var body: some View {
        NavigationView {
            VStack {
                Text("So where we gonna go?")
                    .bold()
                    .font(.system(size: 27, weight: .heavy, design: .rounded))
                    .background(.green)
//                Spacer()
                Map(coordinateRegion: $region)
            }
            .background(.blue)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
