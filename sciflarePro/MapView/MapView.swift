//
//  MapView.swift
//  sciflarePro
//
//  Created by Briston on 18/07/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7833, longitude: -122.4167),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, showsUserLocation: true)
                .onAppear {
                    if let location = locationManager.lastLocation {
                        region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .frame(height: 300)
            
            VStack {
                Text("Location status: \(locationManager.statusString)")
                    .padding()
                HStack {
                    Text("Latitude: \(locationManager.lastLocation?.coordinate.latitude ?? 0)")
                    Text("Longitude: \(locationManager.lastLocation?.coordinate.longitude ?? 0)")
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    MapView()
}
