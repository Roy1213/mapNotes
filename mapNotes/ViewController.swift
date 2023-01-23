//
//  ViewController.swift
//  mapNotes
//
//  Created by ROY ALAMEH on 1/23/23.
//

import UIKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    @IBOutlet weak var mapOutlet: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
        locationManager.requestWhenInUseAuthorization()
        mapOutlet.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
    }
    
    
    @IBAction func zoomAction(_ sender: UIBarButtonItem) {
        print("test")
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let center = currentLocation?.coordinate
        let region = MKCoordinateRegion(center: center!, span: coordinateSpan)
        mapOutlet.setRegion(region, animated: true)
    }
    
}

