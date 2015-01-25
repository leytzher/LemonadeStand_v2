//
//  Factory.swift
//  LemonadeStandv2
//
//  Created by Leytzher on 1/24/15.
//  Copyright (c) 2015 Leytzher. All rights reserved.
//

import Foundation
import UIKit

class Factory{
	
	class func createCustomer() -> [Customer] {
		
		let kNumberOfCustomers = 5
		var clients:[Customer] = []
		
		for var i=0; i < kNumberOfCustomers; ++i {
			var slot = Customer()
			clients.append(slot)
		}
		return clients
	}
}
