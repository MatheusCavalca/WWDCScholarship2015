//
//  FutureView.swift
//  Matheus_Cavalca
//
//  Created by Matheus Cavalca on 17/04/15.
//  Copyright (c) 2015 Matheus Cavalca. All rights reserved.
//

import UIKit
import CoreLocation

class FutureView: UIView, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let limitTimerToHideProject = 5
    var currentTimeToHideProject = 0
    
    var boolStartedRanging = false
    var beaconFoundTimer = 0
    
    @IBOutlet var view_SecretProject: UIView!
    @IBOutlet var lblInstructionsBeacon: UILabel!
    
    //MARK: Scroll methods
    func handleScrollOnView(coeficient:CGFloat){
        if coeficient>=0.5 {
            self.alpha = (1.0 - coeficient) * 2
        }
        else{
            self.alpha = coeficient * 2
        }
    }
    
    
    //MARK: Location and iBeacon handlers
    func requestLocationAndTriggerRanging(){
        locationManager.delegate = self
    
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), identifier: "SecretProjectBeaconRegion")
        
        locationManager.startRangingBeaconsInRegion(region)
        
        boolStartedRanging = true
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        for var i=0; i<beacons.count; i++ {
            if let currentBeacon = beacons[i] as? CLBeacon {
                if currentBeacon.accuracy < 0.5 && currentBeacon.accuracy > 0{
                    showViewSecretProject()
                    beaconFoundTimer = 3
                }
            }
        }
        
        if beaconFoundTimer == 0 {
            hideViewSecretProject()
        }
        beaconFoundTimer-=1
    }
    
    
    //MARK: Secret project handlers
    func showViewSecretProject(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view_SecretProject.alpha = 1;
            self.lblInstructionsBeacon.alpha = 0;
        })
    }
    
    func hideViewSecretProject(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view_SecretProject.alpha = 0;
            self.lblInstructionsBeacon.alpha = 1;
        })
    }
    

}
