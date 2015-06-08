//
//  ViewController.swift
//  WWDCScolarship
//
//  Created by Matheus Cavalca on 14/04/15.
//  Copyright (c) 2015 Matheus Cavalca. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollInformations: UIScrollView!
    @IBOutlet var viewHeader: HeaderView!
    
    var arrayViews : NSMutableArray!
    var boolFirstViewAppear = true
    var boolStartedProfileAnimation = false
    var currentPage = 0
    
    
    //MARK: Loading methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.userInteractionEnabled = false
        
        arrayViews = NSMutableArray()
        
        scrollInformations.delegate = self
        
        handlePannelViewsToScroll()
        
        self.viewHeader.customSetup()
    }

    override func viewDidAppear(animated: Bool) {
        if boolFirstViewAppear {
            performFirstScrollAnimation()
            self.viewHeader.animateImgProfilePicture()
            boolFirstViewAppear = false
        }
    }
    
    func handlePannelViewsToScroll(){
        let pannels = Settings.getPannels()
        var offset:CGFloat = 0.0
        for var i = 0; i < pannels.count ; i++
        {
            let currentView = NSBundle.mainBundle().loadNibNamed(pannels[i] as! String, owner: nil, options: nil)[0] as! UIView
            currentView.frame = CGRectMake(offset, 0, currentView.frame.size.width, currentView.frame.size.height)
            currentView.backgroundColor = UIColor.clearColor()
            arrayViews.addObject(currentView)
            scrollInformations.addSubview(currentView)
            offset += currentView.frame.size.width
            scrollInformations.contentSize = CGSizeMake(offset, scrollInformations.frame.size.height)
        }
        
        let pageWidth = scrollInformations.frame.size.width
        scrollInformations.setContentOffset(CGPointMake(CGFloat(arrayViews.count-1)*pageWidth, scrollInformations.contentOffset.y), animated: false)
    }
    
    func performFirstScrollAnimation(){
        UIView.animateWithDuration(1.6, delay: 0.75, options: .CurveEaseOut , animations: {
            self.scrollInformations.contentOffset = CGPointMake(0, self.scrollInformations.contentOffset.y)
            self.viewHeader.mainScrollPannelsDidScroll(0)
            }, completion: { finished in
                self.view.userInteractionEnabled = true
                
                for var i = 1; i < self.arrayViews.count ; i+=1{
                    let currentView = self.arrayViews[i] as! UIView
                    self.fadeOutSubviews(currentView)
                }
                
                var currentBt : UIButton? = self.view.viewWithTag(Settings.getTagBottomButtons()) as? UIButton;
                currentBt?.enabled = true
                
                self.viewHeader.hideAditionalInformation()
        })
    }
    
    
    //MARK: Scroll methods
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //only allow scroll handler if the initial animation is finished
        if(view.userInteractionEnabled){
            let pageWidth = scrollView.frame.size.width
            
            let coeficientContent = (scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)
            let page = Int(floor(coeficientContent))
            let coeficientPag = coeficientContent - CGFloat(page)
            
            var pannels = Settings.getPannels()
            
            if page < pannels.count && page >= 0 {
                if arrayViews[page].isKindOfClass(DefaultInformationView){
                    var viewCurrentPaged = arrayViews[page] as? DefaultInformationView
                    viewCurrentPaged?.handleScrollOnView(CGFloat(coeficientPag))
                }
                else if arrayViews[page].isKindOfClass(DefaultAppView){
                        var viewCurrentPaged = arrayViews[page] as? DefaultAppView
                        viewCurrentPaged?.handleScrollOnView(CGFloat(coeficientPag))
                }
                else{
                    var viewCurrentPaged = arrayViews[page] as? FutureView
                    viewCurrentPaged?.handleScrollOnView(CGFloat(coeficientPag))
                    
                    if viewCurrentPaged?.boolStartedRanging != true {
                        viewCurrentPaged?.requestLocationAndTriggerRanging()
                    }
                }
                
                if page>0{
                    var viewLastPage = arrayViews[page-1] as! UIView
                    self.fadeOutSubviews(viewLastPage)
                }
                
                if page + 1 < pannels.count {
                    var viewNextPage = arrayViews[page+1] as! UIView
                    self.fadeOutSubviews(viewNextPage)
                }
                
                
                if page != currentPage {
                    handlePageChanged(page)
                }
                
                var currentBt : UIButton? = self.view.viewWithTag(page + Settings.getTagBottomButtons()) as? UIButton;
                currentBt?.enabled = true
            }
            
            viewHeader.mainScrollPannelsDidScroll(scrollView.contentOffset.x/pageWidth)
        }
    }
    
    func handlePageChanged(newPage: Int){
        let currentView = self.arrayViews[currentPage] as! UIView
        self.fadeOutSubviews(currentView)
        currentPage = newPage
    }
    
    
    //MARK: Auxiliar methods
    func fadeOutSubviews(desiredView: UIView){
        desiredView.alpha = 0
    }
    
    
    //MARK: Actions
    @IBAction func btIndicator_TouchUpInside(sender: AnyObject) {
        let pageWidth = scrollInformations.frame.size.width
        let coeficientContent = Float((scrollInformations.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0))
        let page = Int(floor(coeficientContent))
        
        scrollInformations.setContentOffset(CGPointMake(CGFloat(sender.tag - Settings.getTagBottomButtons())*pageWidth, scrollInformations.contentOffset.y), animated: true)
    }

    
}

