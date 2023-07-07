//
//  LocationManager.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import CoreLocation
import Foundation


final class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager: CLLocationManager = .init()
    
    override init() {
        super.init()
        self.manager.delegate = self
    }
    
    
    func request() {
        self.manager.requestWhenInUseAuthorization()
    }
    
    
    func getCity() async throws -> String {
        if CLLocationManager.locationServicesEnabled() {
            self.manager.startUpdatingLocation()
            guard let location = self.manager.location else {
                throw LocationManagerUseCaseError.notFoundLocation
            }

            let city = try await self.decodingLocation(location: location)
            return city
        } else {
            throw LocationManagerUseCaseError.serviceDisabled
        }
    }
    
    
    private func decodingLocation(location: CLLocation) async throws -> String {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.reverseGeocodeLocation(location)

        guard let placemark = placemarks.first, let city = placemark.locality else {
            throw NSError(domain: "GeocodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Не удалось определить город"])
        }
        return city
    }
}
