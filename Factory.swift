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
	
	class func initializeGame(data:Balance)->Balance{
		var data = Balance()
		data.money = 10.0
		data.iceCubes = 1
		data.lemons = 1
		
		return data
	}
}