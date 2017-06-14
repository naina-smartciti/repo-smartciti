//
//  BusinessDetailViewController.swift
//  SmartCiti
//
//  Created by Sathish on 27/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit
import MapKit

class BusinessDetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var businessDetailMapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    let annotationView = MKAnnotationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-arrow"), style: .plain, target: self, action: #selector(backButtonAction))
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "share-circle"), style: .plain, target: self, action: #selector(rightBarButtonAction))
        
        rightBarButton.tintColor = UIColor.black
        
        leftBarButton.tintColor = UIColor.black
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Business Title"
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.tabBarController?.tabBar.isHidden = true
        
        
        let initialLocation = CLLocation(latitude: 40.730872, longitude: -74.003066)
        
        centerMapOnLocation(location: initialLocation)
        
        // Set map view delegate with controller
        self.businessDetailMapView.delegate = self
        
        let newYorkLocation = CLLocationCoordinate2DMake(40.730872, -74.003066)
        
        // Drop a pin
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = newYorkLocation
        dropPin.title = "New York City"
        businessDetailMapView.addAnnotation(dropPin)
        
        
        annotationView.annotation = dropPin
        annotationView.image = UIImage(named: "mappin-parking")
        annotationView.canShowCallout = true
        annotationView.isEnabled = true
        // Do any additional setup after loading the view.
    }
    
    func backButtonAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func rightBarButtonAction() {
        let socialShareAlert = self.storyboard?.instantiateViewController(withIdentifier: "hourseOfOperationShareView")
        socialShareAlert?.modalPresentationStyle = .overCurrentContext
        socialShareAlert?.modalTransitionStyle = .crossDissolve
        
        self.present(socialShareAlert!, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        annotationView.annotation = annotation
        
        return annotationView
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        businessDetailMapView.setRegion(coordinateRegion, animated: true)
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
