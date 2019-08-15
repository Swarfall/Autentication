//
//  MapViewController.swift
//  AuthenticationITEA
//
//  Created by admin on 7/24/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var authModel = AuthModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.round(corners: [.topLeft, .topRight], radius: 25)
        updateDataMarkerLocation(lat: authModel.lat ?? 0, long: authModel.long ?? 0)
    }
    
    @IBAction func didTapGoToProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.studentModel = authModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapGoToAuth(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MapViewController: GMSMapViewDelegate, CLLocationManagerDelegate {
    
    func setCurrentLocation() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func setMarker(long: CLLocationDegrees, lat: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.icon = UIImage(named: "marker")
        marker.position.latitude = lat
        marker.position.longitude = long
        marker.map = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let alert = UIAlertController(title: "Go to news?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (yesAction) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (noAction) in
            
        }))
        self.present(alert, animated: true, completion: nil)
        return true
    }
    
    func updateDataMarkerLocation(lat: Double, long: Double) {
        setMarker(long: long, lat: lat)
        setCurrentLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let camera = GMSCameraPosition.camera(withLatitude: self.authModel.lat ?? 0, longitude: self.authModel.long ?? 0, zoom: 17)
        self.mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
}

extension UIView {
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
