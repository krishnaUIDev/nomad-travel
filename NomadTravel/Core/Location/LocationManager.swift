import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let clManager = CLLocationManager()
    
    @Published var userLocation: CLLocation? = nil
    @Published var currentCityName: String = "Canggu, Bali"
    @Published var timezoneIdentifier: String = TimeZone.current.identifier
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        clManager.delegate = self
        clManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission() {
        clManager.requestWhenInUseAuthorization()
        clManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.userLocation = location
            self.reverseGeocode(location)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.authorizationStatus = manager.authorizationStatus
            #if os(iOS)
            if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
                self.clManager.startUpdatingLocation()
            }
            #else
            if manager.authorizationStatus == .authorized {
                self.clManager.startUpdatingLocation()
            }
            #endif
        }
    }

    
    private func reverseGeocode(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first, error == nil else { return }
            let city = placemark.locality ?? placemark.administrativeArea ?? "Unknown City"
            let country = placemark.country ?? ""
            DispatchQueue.main.async {
                self?.currentCityName = "\(city), \(country)"
            }
        }
    }
    
    func distanceTo(lat: Double, lon: Double) -> String {
        guard let userLocation = userLocation else { return "1.2 km" }
        let targetLocation = CLLocation(latitude: lat, longitude: lon)
        let distanceMeters = userLocation.distance(from: targetLocation)
        if distanceMeters >= 1000 {
            return String(format: "%.1f km", distanceMeters / 1000.0)
        } else {
            return "\(Int(distanceMeters)) m"
        }
    }
}
