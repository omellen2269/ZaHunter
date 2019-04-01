//
//  ViewController.swift
//  ZaHunter
//
//  Created by Olivia Mellen on 3/8/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }

}
