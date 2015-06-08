//
//  DefaultInformationView.swift
//  Matheus_Cavalca
//
//  Created by Matheus Cavalca on 16/04/15.
//  Copyright (c) 2015 Matheus Cavalca. All rights reserved.
//

import UIKit

class DefaultInformationView: UIView {
    
    //MARK: Scroll methods
    func handleScrollOnView(coeficient:CGFloat){
        if coeficient>=0.5 {
            self.alpha = (1.0 - coeficient) * 2
        }
        else{
            self.alpha = coeficient * 2
        }
    }
    
}
