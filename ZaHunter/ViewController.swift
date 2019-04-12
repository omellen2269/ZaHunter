//
//  ViewController.swift
//  ZaHunter
//
//  Created by Olivia Mellen on 3/8/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var iceCreamShop: [MKMapItem] = []
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let view = MKAnnotationView()
        var currentMapItem = MKMapItem()
        if let title = view.annotation?.title, let shopName = title {
            for mapItem in iceCreamShop {
                if mapItem.name == shopName {
                    currentMapItem = mapItem
                }
            }
        }
        let placemark = currentMapItem.placemark
        
        if annotation.isEqual(mapView.userLocation) {
            return nil
        }
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.canShowCallout = true
        pin.animatesDrop = true
        let detailedLabel = UILabel()
        detailedLabel.text = "\(placemark)"
        pin.detailCalloutAccessoryView = detailedLabel
        
        
      
        return pin
        
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        currentLocation = locations[0]
    }
    @IBAction func whenZoomPressed(_ sender: Any)
    {
        let center = currentLocation.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func whenSearchPressed(_ sender: Any)
    {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Ice Cream"
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else { return }
            for mapItem in response.mapItems {
                self.iceCreamShop.append(mapItem)
                let annotation = MKPointAnnotation()
                annotation.title = mapItem.name
                annotation.coordinate = mapItem.placemark.coordinate
                
                
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    // https://www.raywenderlich.com/548-mapkit-tutorial-getting-started
    
    
    
    
}
