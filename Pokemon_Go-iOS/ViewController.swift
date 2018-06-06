//
//  ViewController.swift
//  Pokemon_Go-iOS
//
//  Created by Med Salmen Saadi on 6/2/18.
//  Copyright © 2018 Med Salmen Saadi. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView : GMSMapView!
    let locationManager = CLLocationManager()
    var ListPockemon=[Pockemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //zoom value must be between 1-20
        let camera = GMSCameraPosition.camera(withLatitude: 43, longitude: -77, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        
        mapView.delegate = self
        
        LoadPockemons()
        
        self.locationManager.requestAlwaysAuthorization()
        //get acces location permission
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate=self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("you tapped at, latitude : \(coordinate.latitude), longitude : \(coordinate.longitude)")
    }
    
    var locValue: CLLocationCoordinate2D=CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //don't update location if the player don't moove
        if manager.location!.coordinate.latitude==locValue.latitude &&
            manager.location!.coordinate.longitude==locValue.longitude {
            return
        }
        
        locValue=manager.location!.coordinate
        print("user update at, latitude : \(locValue.latitude), longitude : \(locValue.longitude)")
        
        //clear the map
        self.mapView.clear()
        //add the pockemon catch man
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        marker.title = "Salmen"
        marker.snippet = "here is player location"
        marker.icon = UIImage(named: "mario")
        marker.map = self.mapView
        
        // add pockemons
        var index=0
        for pockemon in ListPockemon{
            if pockemon.isCatch==false {
                let marker1=GMSMarker()
                marker1.position=CLLocationCoordinate2D(latitude:pockemon.latitude!, longitude: pockemon.longitude!)
                marker1.title=pockemon.name!
                marker1.snippet="\(pockemon.des!), his power is \(pockemon.power!)"
                marker1.icon=UIImage(named:pockemon.Image!)
                marker1.map=self.mapView
                
                // if he find a pockemon
                if  (Double(locValue.latitude).roundTo(places: 4) == Double(pockemon.latitude!).roundTo(places: 4)) &&
                    (Double(locValue.longitude).roundTo(places: 4) == Double(pockemon.longitude!).roundTo(places: 4))
                {
                    ListPockemon[index].isCatch=true
                    AlerDialog(power:pockemon.power!)
                }
            }
            index=index+1
        }
        
        //zoom value must be between 1-20
        let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 14.7)
        self.mapView.camera=camera
    }
    
    func LoadPockemons(){
        self.ListPockemon.append(Pockemon(latitude:  37.7789994893035,longitude: -122.401846647263, Image: "Charmander",name:"Charmander",des: "Charmander living in japan",power:55))
        self.ListPockemon.append(Pockemon(latitude: 37.7949568502667, longitude:  -122.410494089127, Image: "Bulbasaur",name:"Bulbasaur",des: "Bulbasaur living in usa",power:90.5))
        self.ListPockemon.append(Pockemon(latitude:  37.7816621152613, longitude:-122.41225361824  , Image: "Squirtle",name:"Squirtle",des: "Squirtle living in tunisia",power:33.5))
    }
    
    var TotalGain=0.0
    //show later
    func AlerDialog(power:Double){
        self.TotalGain=self.TotalGain + power
        let alert = UIAlertController(title: "Coins", message: "Catch new pokemon with power \(power)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,
                                      handler: { action in
                                        print("+ one")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
