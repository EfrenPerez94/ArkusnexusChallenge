//
//  DetailViewController.swift
//  ArkusnexusChallenge
//
//  Created by Efrén Pérez Bernabe on 6/9/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

/// Detail Place View Controller. Shows the details for the place selected.
final class PlaceDetailViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Private properties
    private var place: Place?
    private var currentLocation: CLLocation?
    private var tableView: UITableView!
    private var placeDetailDataSource = PlaceDetailDataSource()
    private let mapView = MKMapView()
    private let annotation = MKPointAnnotation()
    private var coordinateRegion = MKCoordinateRegion()

    // MARK: - Initializers
    init(with place: Place, location: CLLocation) {
        self.place = place
        self.currentLocation = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "DETAIL"
        placeDetailDataSource.place = place
        mapSetup()
        tableViewSetup()
    }
    
    // MARK: - View Controller configuration
    /// Table View configuration.
    fileprivate func tableViewSetup() {
        let tableViewHeight = view.bounds.height - mapView.frame.height
        let yOrigin = mapView.frame.height + topBarHeight
        tableView = UITableView(frame: CGRect(x: 0, y: yOrigin, width: view.frame.width, height: tableViewHeight))
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: .placeCell)
        tableView.register(PlaceDetailTableViewCell.self, forCellReuseIdentifier: .placeDetailCell)
        tableView.dataSource = placeDetailDataSource
        view.addSubview(tableView)
    }
    
    /// Map configuration
    fileprivate func mapSetup() {
        
        let frame = CGRect(x: 0, y: topBarHeight, width: view.frame.width, height: view.frame.width * 0.75)
        mapView.frame = frame
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        let initialLocation = CLLocation(latitude: place?.latitude ?? 0, longitude: place?.longitude ?? 0)
        annotation.coordinate = CLLocationCoordinate2D(latitude: place?.latitude ?? 0, longitude: place?.longitude ?? 0)
        let regionRadius: CLLocationDistance = 500
        coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(annotation)
        
        view.addSubview(mapView)
    }
    
}

extension PlaceDetailViewController {
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return view.frame.height / 7
        } else {
            return view.frame.height / 12
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0, 1:
            let placemark = MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = place?.name ?? ""
            mapItem.openInMaps()
        case 2:
            var number = place?.phoneNumber.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil)
            number = place?.phoneNumber.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
            number = place?.phoneNumber.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            guard let url = URL(string: "telprompt://\(number ?? "911")") else {
                return
            }
            UIApplication.shared.open(url)
        case 3:
            if let url = URL(string: place?.site ?? ""),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        default: return
        }
    }

}
