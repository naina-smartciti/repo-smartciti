//
//  SmartMaps-Map-ViewController.swift
//  SmartCiti
//
//  Created by Sathish on 22/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SmartMaps_Map_ViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {

    @IBOutlet var smartMapsMapView: MKMapView!
    @IBOutlet var mapSearchBar: UISearchBar!
    
    let regionRadius: CLLocationDistance = 1000
    let annotationView = MKAnnotationView()
    let annotaitonViewRed = MKAnnotationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        smartMapsMapView.showsUserLocation = true
        
        mapSearchBar.layer.cornerRadius = 20
        mapSearchBar.clipsToBounds = true
        mapSearchBar.layer.borderColor = UIColor.white.cgColor
        mapSearchBar.layer.borderWidth = 15
        mapSearchBar.placeholder = "Search Location"
        
        self.tabBarController?.tabBar.isHidden = false
        
        let initialLocation = CLLocation(latitude: 40.730872, longitude: -74.003066)
        
        centerMapOnLocation(location: initialLocation)
        
        // Set map view delegate with controller
        self.smartMapsMapView.delegate = self
        
        let newYorkLocation = CLLocationCoordinate2DMake(40.730872, -74.003066)
        let sanLocaiton = CLLocationCoordinate2DMake(43.987658, -74.098767)
        
        // Drop a pin
        let dropPin = MKPointAnnotation()
        let dropPinRed = MKPointAnnotation()
        
        dropPin.coordinate = newYorkLocation
        dropPin.title = "New York City"
        
        dropPinRed.coordinate = sanLocaiton
        dropPinRed.title = "San Locaiton"
        
        smartMapsMapView.addAnnotation(dropPin)
        smartMapsMapView.addAnnotation(dropPinRed)
        
        
        
        annotationView.annotation = dropPin
        annotationView.image = UIImage(named: "blue-pin-point")
        
        annotaitonViewRed.annotation = dropPinRed
        annotaitonViewRed.image = UIImage(named: "blue-pin-point")
        
        annotationView.canShowCallout = true
        annotationView.isEnabled = true
        
        annotaitonViewRed.canShowCallout = true
        annotaitonViewRed.isEnabled = true
        
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        annotationView.annotation = annotation
        
        return annotationView
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        smartMapsMapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
