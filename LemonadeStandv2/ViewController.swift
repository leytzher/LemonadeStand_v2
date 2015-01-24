//
//  ViewController.swift
//  LemonadeStandv2
//
//  Created by Leytzher on 1/24/15.
//  Copyright (c) 2015 Leytzher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	// Labels to update
	
	// Balance Container
	@IBOutlet weak var currentBalanceLabel: UILabel!
	@IBOutlet weak var currentLemonBalanceLabel: UILabel!
	@IBOutlet weak var currentIceCubesBalanceLabel: UILabel!
	
	// Purchase Container
	@IBOutlet weak var lemonToPurchase: UITextField!
	@IBOutlet weak var iceCubesToPurchase: UITextField!
	
	// Mixing Container
	
	@IBOutlet weak var lemonToMix: UITextField!
	@IBOutlet weak var iceCubesToMix: UITextField!
	
	//Lemonade taste
	@IBOutlet weak var lemonadeTaste: UILabel!
	
	// create balance instance
	var data:Balance!
	
	

	
	

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// initialize game
    self.initializeData()
	self.populateStatus(self.data)
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// Purchase functions

	@IBAction func buyLessLemon(sender: UIButton) {
	}
	
	@IBAction func buyMoreLemon(sender: UIButton) {
	}
	@IBAction func buyLessIce(sender: UIButton) {
	}
	@IBAction func buyMoreIce(sender: UIButton) {
	}
	
	
	
	
	// Mixing functions
	@IBAction func mixLessLemon(sender: UIButton) {
	}
	@IBAction func mixMoreLemon(sender: UIButton) {
	}
	
	@IBAction func mixLessIce(sender: UIButton) {
	}
	
	@IBAction func mixMoreIce(sender: UIButton) {
	}
	
	// Start day!
	
	@IBAction func startDay(sender: UIButton) {
	}
	
	
	// Helper functions
	
	// initialize data
	func initializeData(){
		data = Balance()
		data.iceCubes = 1
		data.lemons = 1
		data.money = 10.0
	}
	
	// populate status
	func populateStatus(data:Balance) {
		self.currentBalanceLabel.text = "$\(data.money)"
		self.currentLemonBalanceLabel.text = "\(data.lemons)"
		self.currentIceCubesBalanceLabel.text = "\(data.iceCubes)"
	}

}

