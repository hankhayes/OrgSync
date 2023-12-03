//
//  AddLocationViewController.swift
//  OrgSync
//
//  Created by Hank Hayes on 11/28/23.
//

import UIKit
import MapKit
import CoreLocation

class AddLocationViewController: UIViewController, MKMapViewDelegate, UISearchResultsUpdating, CLLocationManagerDelegate, UISearchBarDelegate {
    
    var searchController = UISearchController(searchResultsController: nil)
    
    var matchingItems = [MKMapItem]()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup location manager
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
        
        let searchController = UISearchController()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 4000, longitudinalMeters: 4000)
        mapView.setRegion(region, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("text entered")
        
        if let searchText = searchController.searchBar.text {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchText
            
            let search = MKLocalSearch(request: request)
            search.start { (response, _) in
                guard let response = response else { return }
                self.matchingItems = response.mapItems
                // self.tableView.reloadData()
            }
        }
    }
}
