//
//  ViewController.swift
//  mapNotes
//
//  Created by ROY ALAMEH on 1/23/23.
//
//testing github

import UIKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //need this object to keep track of location
    let locationManager = CLLocationManager()
    //keeps current location
    var currentLocation : CLLocation!
    
    var spots = [MKMapItem]()
    @IBOutlet weak var mapOutlet: MKMapView!
    
    @IBOutlet weak var textOutlet: UITextField!
    @IBOutlet weak var searchOutlet: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        mapOutlet.showsUserLocation = true
    }
    
    //sets most recent location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
    }
    
    //button action to zoom in
    @IBAction func zoomAction(_ sender: UIBarButtonItem) {
        print("test")
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let center = currentLocation?.coordinate
        let region = MKCoordinateRegion(center: center!, span: coordinateSpan)
        mapOutlet.setRegion(region, animated: true)
    }
    
    @IBAction func searchAction(_ sender: Any) {
        let request = MKLocalSearch.Request()// builds blank request
        let zoomMultiplier = 0.05
        request.naturalLanguageQuery = textOutlet.text!
        request.region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 0.05, longitudinalMeters: 0.05)
        
        let search = MKLocalSearch(request: request)
        search.start {response, error in
            //checking if there is a response (no nil)
            guard let response = response else {
                print(error)
                return
            }
            for mapItem in response.mapItems {
                self.spots.append(mapItem)
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self.mapOutlet.addAnnotation(annotation)
            }
        }
    }
    
}

