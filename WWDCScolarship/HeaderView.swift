//
//  HeaderView.swift
//  Matheus_Cavalca
//
//  Created by Matheus Cavalca on 16/04/15.
//  Copyright (c) 2015 Matheus Cavalca. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    @IBOutlet var imgProfilePicture: UIImageView!
    @IBOutlet var scrollTitle: UIScrollView!
    
    var lblInformation : UILabel!
    var btFacetime : UIButton!
    var btImessage : UIButton!
    var btEmail : UIButton!
    
    
    //MARK: Loading and setup methods
    func customSetup() {
        handleImgProfilePicture()
        handleAditionalInformation()
        handleTitlesToScroll()
    }

    func handleImgProfilePicture(){
        imgProfilePicture.layer.cornerRadius = imgProfilePicture.frame.width/2
        imgProfilePicture.clipsToBounds = true
        
        var tapGesture = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
        imgProfilePicture.addGestureRecognizer(tapGesture)
        imgProfilePicture.userInteractionEnabled = true
    }
    
    func handleTitlesToScroll(){
        let pannels = Settings.getPannels()
        var offset:CGFloat = 0.0
        for var i = 0; i < pannels.count ; i++
        {
            var lblTitle = UILabel(frame: CGRectMake(5, offset, 240, 30))
            lblTitle.alpha = 1
            lblTitle.text = Settings.getMatchTitleText().objectForKey(pannels[i]) as? String
            lblTitle.textColor = Settings.getMatchColors().objectForKey(pannels[i]) as! UIColor
            lblTitle.font = UIFont(name: "Helvetica", size: 23.0)
            scrollTitle.addSubview(lblTitle)
            offset += lblTitle.frame.size.height
            scrollTitle.contentSize = CGSizeMake(scrollTitle.frame.size.height, offset)
        }
        
        let pageHeight = scrollTitle.frame.size.height
        scrollTitle.setContentOffset(CGPointMake(scrollTitle.contentOffset.x, CGFloat(pannels.count-1)*pageHeight + 5),
            animated: false)
    }
    
    
    func handleAditionalInformation(){
        lblInformation = UILabel(frame: CGRectMake(0, 0, 190, 55))
        lblInformation.center = imgProfilePicture.center
        lblInformation.textAlignment = NSTextAlignment.Center
        lblInformation.alpha = 0
        lblInformation.text = "Brazilian, 21 years old \n iOS Developer"
        lblInformation.textColor = UIColor(white: 1.0, alpha: 1.0)
        lblInformation.font = UIFont(name: "Helvetica", size: 17.0)
        lblInformation.numberOfLines = 2
        self.addSubview(lblInformation)
        
        btFacetime = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        btFacetime.frame = CGRectMake(0, 0, 50, 50)
        btFacetime.center = imgProfilePicture.center
        btFacetime.alpha = 0
        btFacetime.setBackgroundImage(UIImage(named: "icon_facetime"), forState: UIControlState.Normal)
        btFacetime.addTarget(self, action: "btFacetime_TouchUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btFacetime)
        
        btImessage = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        btImessage.frame = CGRectMake(0, 0, 50, 50)
        btImessage.center = imgProfilePicture.center
        btImessage.alpha = 0
        btImessage.setBackgroundImage(UIImage(named: "icon_imessage"), forState: UIControlState.Normal)
        btImessage.addTarget(self, action: "btImessage_TouchUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btImessage)
        
        btEmail = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        btEmail.frame = CGRectMake(0, 0, 50, 50)
        btEmail.center = imgProfilePicture.center
        btEmail.alpha = 0
        btEmail.setBackgroundImage(UIImage(named: "icon_email"), forState: UIControlState.Normal)
        btEmail.addTarget(self, action: "btEmail_TouchUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btEmail)
        
        self.bringSubviewToFront(imgProfilePicture)
        
        showAditionalInformation()
    }
    
    func animateImgProfilePicture(){
        imgProfilePicture.animationImages = Settings.getAnimatedProfileImages() as [AnyObject]
        imgProfilePicture.animationDuration = Settings.getAnimationProfileDuration()
        imgProfilePicture.startAnimating()
    }
    
    func mainScrollPannelsDidScroll(coeficient: CGFloat){
        scrollTitle.contentOffset = CGPointMake(0, coeficient*scrollTitle.frame.size.height)
    }
    
    
    //MARK: Gestures recognizers and actions
    func imageTapped(img: AnyObject)
    {
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseOut , animations: {
            self.imgProfilePicture.transform = CGAffineTransformMakeScale(1.1, 1.1)
            
            }, completion: { finished in
                UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseOut , animations: {
                    self.imgProfilePicture.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    
                    }, completion: nil
                )
        })
        if lblInformation.alpha == 0{
            showAditionalInformation()
        }
        else{
            hideAditionalInformation()
        }
    }

    func btFacetime_TouchUpInside (sender : AnyObject){
        var url:NSURL? = NSURL(string: "facetime:matheus.cavalca@acad.pucrs.br")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func btImessage_TouchUpInside (sender : AnyObject){
        var url:NSURL? = NSURL(string: "sms:matheus.cavalca@acad.pucrs.br")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func btEmail_TouchUpInside (sender : AnyObject){
        var url:NSURL? = NSURL(string: "mailto:matheus.cavalca@acad.pucrs.br")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    
    
    //MARK: Additional information handlers
    func showAditionalInformation(){
        let distanceImgProfileBorderRight = (self.frame.size.width - imgProfilePicture.center.x)
        let coeficientRight = distanceImgProfileBorderRight/7
        
        let distanceImgProfileBorderLeft = imgProfilePicture.frame.origin.x
        let coeficientLeft = distanceImgProfileBorderLeft/2
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut , animations: {
            self.btEmail.center = CGPointMake(coeficientRight*2 + self.frame.size.width/2, self.imgProfilePicture.center.y)
            self.btEmail.alpha = 1
            
            self.btFacetime.center = CGPointMake(coeficientRight*4 + self.frame.size.width/2, self.imgProfilePicture.center.y)
            self.btFacetime.alpha = 1
            
            self.btImessage.center = CGPointMake(coeficientRight*6 + self.frame.size.width/2, self.imgProfilePicture.center.y)
            self.btImessage.alpha = 1
            
            self.lblInformation.center = CGPointMake(coeficientLeft, self.imgProfilePicture.center.y)
            self.lblInformation.alpha = 1
            }, completion: { finished in
        })
    }
    
    func hideAditionalInformation(){
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut , animations: {
            self.lblInformation.center = self.imgProfilePicture.center
            self.lblInformation.alpha = 0
            
            self.btFacetime.center = self.imgProfilePicture.center
            self.btFacetime.alpha = 0
            
            self.btImessage.center = self.imgProfilePicture.center
            self.btImessage.alpha = 0
            
            self.btEmail.center = self.imgProfilePicture.center
            self.btEmail.alpha = 0
            
            }, completion: { finished in
        })
    }
}
