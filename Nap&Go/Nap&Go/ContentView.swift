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
    private var backgroundColor = Color(.sRGB, red: 31/255, green: 115/255, blue: 64/255, opacity: 1.0)
    
    var body: some View {
            VStack {
                Text("So where we gonna go?")
                    .bold()
                    .font(.system(size: 30, weight: .heavy, design: .rounded))
                    
                    .frame(width: nil, height: 80, alignment: .center)
                MapView(region: $viewModel.region)
                    .cornerRadius(10.0)
                    .onAppear {
                        viewModel.checkIfLocationServicesIsEnabled()
                    }
            }
            .background(backgroundColor)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
