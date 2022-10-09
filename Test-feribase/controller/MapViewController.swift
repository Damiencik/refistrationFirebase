//
//  MapViewController.swift
//  Test-feribase
//
//  Created by Baxtiyor on 15/09/22.
//


import UIKit
import MapKit
import CoreLocation

class MyAnnotation: NSObject, MKAnnotation {
   var coordinate: CLLocationCoordinate2D
   var title: String?
   var subtitle: String?
    
   init(coordinate: CLLocationCoordinate2D) {
      self.coordinate = coordinate
   }
}
class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    

    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    let regionOnMetres: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        checkLocationServices()
        addPin()
        setupNavigationBar()
    }
    
    
    private func setupNavigationBar(){
        self.title = K.NavigationTitle.home
    }
    
    func setupMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionOnMetres, longitudinalMeters: regionOnMetres)
        mapView.setRegion(region, animated: true)
    }
   
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            followUserLocation()
//            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show alert
            break
        case .authorizedAlways:
            break
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // the user didn't turn it on
        }
    }
    
    func followUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionOnMetres, longitudinalMeters: regionOnMetres)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func addPin(){
        let locationBsuir2 = CLLocation(latitude: 53.91775, longitude: 27.5951376)
        let region2 = MKCoordinateRegion(center: locationBsuir2.coordinate, latitudinalMeters: 1000,longitudinalMeters: 1000)
        mapView.setRegion(region2, animated: false)

        let annotationBsuir2 = MyAnnotation(coordinate: locationBsuir2.coordinate)
        annotationBsuir2.title = "Бгуир 2 корпус"
        annotationBsuir2.subtitle = "Think Different"
        mapView.addAnnotation(annotationBsuir2)



        let locationBsuir1 = CLLocation(latitude: 53.9183171, longitude: 27.5944402)
        let region1 = MKCoordinateRegion(center: locationBsuir1.coordinate, latitudinalMeters: 1000,longitudinalMeters: 1000)
        mapView.setRegion(region1, animated: false)

        let annotationBsuir1 = MyAnnotation(coordinate: locationBsuir1.coordinate)
        annotationBsuir1.title = "Бгуир 1 корпус"
        annotationBsuir1.subtitle = "Think Different"
        mapView.addAnnotation(annotationBsuir1)

    }
}

