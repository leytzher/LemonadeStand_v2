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
	self.getLemonadeTaste()
		
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// Purchase functions

	@IBAction func buyLessLemon(sender: UIButton) {
		purchaseLessLemon()
		populateStatus(self.data)
	}
	
	@IBAction func buyMoreLemon(sender: UIButton) {
		purchaseLemon()
		populateStatus(self.data)
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
		// create clients:
		var clients:[Customer] = self.generateCustomers()
		// check lemonade taste:
		var lemonadeFlavour:String = "acidic"
		// sell lemonade:
		var isSold:Bool = sellLemonade(clients, lemonadeTaste: lemonadeFlavour)
		
		// NOT FINISHED
		
	}
	
	
	// Helper functions
	
	// initialize data
	func initializeData(){
		data = Balance()
		data.iceCubes = 1
		data.lemons = 1
		data.money = 10.0
		data.lemonsUsed = 0
		data.iceCubesUsed = 0
		
	}
	
	// populate status
	func populateStatus(data:Balance) {
		self.currentBalanceLabel.text = "$\(data.money)"
		self.currentLemonBalanceLabel.text = "\(data.lemons)"
		self.currentIceCubesBalanceLabel.text = "\(data.iceCubes)"
		self.lemonToMix.text = "\(data.lemonsUsed)"
		self.iceCubesToMix.text = "\(data.iceCubesUsed)"
	}
	
	// calculate how acid is the lemonade
	func lemonadeAcidIndex(lemon:Int, ice:Int)->CGFloat{
		if ice <= 0 {
			return CGFloat(0.0)
		} else { return CGFloat(lemon/ice)}
	}
	
	
	func lemonateTaste(lemonadeAcid:CGFloat)-> String{
		var taste:String!
		if (lemonadeAcid >= 0.0 && lemonadeAcid <= 0.4) {
			taste =  "Diluted"
		}
		else if (lemonadeAcid > CGFloat(0.4) && lemonadeAcid <= CGFloat(0.6)){
			taste =  "Neutral"
		}
		else if (lemonadeAcid > CGFloat(0.6) && lemonadeAcid <= CGFloat(1.0)){
			taste = "Acidic"
		}
		return taste
	}
	
	
	func getLemonadeTaste(){
		var acidIndex = lemonadeAcidIndex(data.iceCubesUsed, ice: data.lemonsUsed)
		var tasteString = lemonateTaste(acidIndex)
		//populate label
		self.lemonadeTaste.text = tasteString
	}
	
	
	func generateCustomers()->[Customer]{
		var myCustomersArray:[Customer]!
		for var i = 0; i < 5; ++i {
			var customer = Customer()
			myCustomersArray.append(customer)
		}		
		return myCustomersArray
	}
	
	func sellLemonade(customerList:[Customer], lemonadeTaste:String)->Bool {
		var decision:Bool!
		for client in customerList {
			if (lemonadeTaste == client.randomPreference()) {
				println("Paid")
				decision = true
			} else {
				println("I don't like it")
				decision = false
			}
		}
		return decision
	}
	
	func purchaseLemon(){
		// discount $2 from balance
		if data.money > 2.0{
			data.lemons += 1
			data.money -= 2.0
		} else {
			// display a message box "No more money to buy lemons"
			showAlertWithText(header: "Warning", message: "Not enough money to buy lemons.")
		}
	}

	func purchaseLessLemon(){
			// discount $2 from balance
			if data.lemons > 0 {
				data.lemons -= 1
				data.money += 2.0
			} else {
				// display a message box "No more money to buy lemons"
				showAlertWithText(header: "Warning", message: "You don't have lemons")
			}
	}
	
	func showAlertWithText(header: String = "Warning", message:String) {
		var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
		alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
		self.presentViewController(alert, animated: true, completion: nil)
	}
	

}