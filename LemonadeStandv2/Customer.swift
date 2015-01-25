//
//  Customer.swift
//  LemonadeStandv2
//
//  Created by Leytzher on 1/24/15.
//  Copyright (c) 2015 Leytzher. All rights reserved.
//

import Foundation
import UIKit

class Customer{

	func randomPreference()->String{
		var customerPreference:String!
		var randomNumber = CGFloat(arc4random_uniform(UInt32(10)))/10.0
		
		if (randomNumber >= 0 && randomNumber <= 0.4) {
			customerPreference = "Acidic"
		} else if (randomNumber > 0.4 && randomNumber <= 0.6) {
			customerPreference = "Neutral"
		} else if (randomNumber > 0.6 && randomNumber <= 1.0) {
			customerPreference = "Diluted"
		}
		return customerPreference
	}

}