//
//  DefaultAppView.swift
//  WWDCScolarship
//
//  Created by Matheus Cavalca on 14/04/15.
//  Copyright (c) 2015 Matheus Cavalca. All rights reserved.
//

import UIKit

class DefaultAppView: UIView {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgScreenshots: UIImageView!
    var defaultImgY = CGFloat (0)
    @IBOutlet var imgAvailableStore: UIImageView!
    
    
    //MARK: Scroll methods
    func handleScrollOnView(coeficient:CGFloat){
        if defaultImgY == 0{
            defaultImgY = imgScreenshots.frame.origin.y
            
            var tapGesture = UITapGestureRecognizer(target: self, action: Selector("handleTapAvailableStore:"))
            imgAvailableStore.addGestureRecognizer(tapGesture)
            imgAvailableStore.userInteractionEnabled = true
            
        }
        
        if coeficient>=0.5 {
            imgScreenshots.frame = CGRectMake(imgScreenshots.frame.origin.x, defaultImgY + (coeficient-0.5) * imgScreenshots.frame.size.height, imgScreenshots.frame.size.width, imgScreenshots.frame.size.height)
            self.alpha = (1.0 - coeficient) * 2
        }
        else{
            imgScreenshots.frame = CGRectMake(imgScreenshots.frame.origin.x, defaultImgY - (coeficient-0.5) * imgScreenshots.frame.size.height, imgScreenshots.frame.size.width, imgScreenshots.frame.size.height)
            self.alpha = coeficient * 2
        }
    }

    
    //MARK: Gestures recognizers
    func handleTapAvailableStore (sender : AnyObject){
        var imgStore = sender.view as! UIImageView
    
        var indexBasedOnTag = imgStore.tag - Settings.getTagAvailableStoreButtons()
        var url:NSURL? = NSURL(string: Settings.getAppsItunesUrls()[indexBasedOnTag] as! String)
        UIApplication.sharedApplication().openURL(url!)
    }
    
}
