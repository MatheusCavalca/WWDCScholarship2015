//
//  Settings.swift
//  WWDCScolarship
//
//  Created by Matheus Cavalca on 14/04/15.
//  Copyright (c) 2015 Matheus Cavalca. All rights reserved.
//

import UIKit

class Settings: NSObject {
    
    //MARK: Pannels and App information segment
    enum pannelType: Int {
        case AppView, InformationView, FutureView
    }
    
    static func getPannels() -> NSArray {
        var panels: NSArray = [
            "ImportantBackgroundsView",
            "InterestsView",
            "SkillsView",
            "IdealBeerAppView",
            "AddictingBoxAppView",
            "IdoneAppView",
            "WhadgetAppView",
            "VolkyAppView",
            "FutureView"
        ]
        return panels
    }
    
    static func getMatchColors() -> NSDictionary {
        return [
            "ImportantBackgroundsView": UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1),
            "InterestsView": UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1),
            "SkillsView": UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6),
            "IdealBeerAppView": UIColor(red: 244/255, green: 166/255, blue: 48/255, alpha: 1),
            "AddictingBoxAppView": UIColor(red: 214/255, green: 69/255, blue: 65/255, alpha: 1),
            "IdoneAppView": UIColor(red: 76/255, green: 130/255, blue: 176/255, alpha: 1),
            "WhadgetAppView": UIColor(red: 55/255, green: 192/255, blue: 180/255, alpha: 1),
            "VolkyAppView": UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1),
            "FutureView": UIColor(red: 210/255, green: 208/255, blue: 168/255, alpha: 1),
        ]
    }
    
    static func getMatchTitleText() -> NSDictionary {
        return [
            "ImportantBackgroundsView": "Main Experiences",
            "InterestsView": "Main Interests",
            "SkillsView": "Technical Skills",
            "IdealBeerAppView": "First iOS App",
            "AddictingBoxAppView": "First iOS Game",
            "IdoneAppView": "Second iOS App",
            "WhadgetAppView": "First Hit",
            "VolkyAppView": "First Shared App",
            "FutureView": "Future"
        ]
    }
    
    static func getAppsItunesUrls() -> NSArray {
        var panels: NSArray = [
            "https://itunes.apple.com/us/app/idealbeer/id853017592?mt=8",
            "https://itunes.apple.com/us/app/addicting-box/id870530946?mt=8",
            "https://itunes.apple.com/us/app/idone!/id949938483?mt=8",
            "https://itunes.apple.com/us/app/shortcut-for-whatsapp-more/id955092895?mt=8",
            "https://itunes.apple.com/us/app/volky/id946918706?mt=8"
        ]
        return panels
    }
    
    //MARK: tags segment
    static func getTagBottomButtons() -> Int{
        return 20
    }
    
    static func getTagAvailableStoreButtons() -> Int{
        return 10
    }
    
    
    //MARK: Profile animation segment
    static func getAnimatedProfileImages() -> NSArray{
        
        var arrayImages = NSMutableArray()
        for var i = 0; i < 130 ; i+=1{
            let strCurrentName = "profile_picture_" + String(i) + ".JPG"
            arrayImages.addObject(UIImage(named: strCurrentName)!)
        }
        
        return arrayImages
    }
    
    static func getAnimationProfileDuration() -> NSTimeInterval{
        return 13
    }
    
}
