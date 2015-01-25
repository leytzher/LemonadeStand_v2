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
		purchaseLessIce()
		populateStatus(self.data)
	}
	@IBAction func buyMoreIce(sender: UIButton) {
		purchaseMoreIce()
		populateStatus(self.data)
	}
	
	
	
	
	// Mixing functions
	@IBAction func mixLessLemon(sender: UIButton) {
		self.removeLemon()
		populateStatus(self.data)
		self.getLemonadeTaste()
	}
	@IBAction func mixMoreLemon(sender: UIButton) {
		self.addLemon()
		populateStatus(self.data)
		self.getLemonadeTaste()
	}
	
	@IBAction func mixLessIce(sender: UIButton) {
		self.removeIce()
		populateStatus(self.data)
		self.getLemonadeTaste()
	}
	
	@IBAction func mixMoreIce(sender: UIButton) {
		self.addIce()
		populateStatus(self.data)
		self.getLemonadeTaste()
	}
	
	// Start day!
	
	@IBAction func startDay(sender: UIButton) {
		// reset purchases
		data.lemonsInCart = 0
		data.iceCubesInCart = 0
		// create clients:
		var clients:[Customer] = self.generateCustomers()
		// check lemonade taste:
		var acidIndex = lemonadeAcidIndex(data.lemonsUsed, ice: data.iceCubesUsed)
		var tasteString = lemonateTaste(acidIndex)

		
		// sell lemonade:
		var lemonadeSold = self.sellLemonade(clients, lemonadeTaste: tasteString)
		data.money += lemonadeSold
		
		populateStatus(self.data)
		
		if data.money == 0 {
			showAlertWithText(header: "Game Over", message: "You don't have money. Game Over.")
		}
		
		
		
		
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
		data.iceCubesInCart = 0
		data.lemonsInCart = 0
		data.inStock = 0
		
	}
	
	// populate status
	func populateStatus(data:Balance) {
		self.currentBalanceLabel.text = "$\(data.money)"
		self.currentLemonBalanceLabel.text = "\(data.lemons)"
		self.currentIceCubesBalanceLabel.text = "\(data.iceCubes)"
		self.lemonToMix.text = "\(data.lemonsUsed)"
		self.iceCubesToMix.text = "\(data.iceCubesUsed)"
		self.iceCubesToPurchase.text = "\(data.iceCubesInCart)"
		self.lemonToPurchase.text = "\(data.lemonsInCart)"
		
	}
	
	// calculate how acid is the lemonade
	func lemonadeAcidIndex(lemon:Int, ice:Int)->CGFloat{
		if (ice == 0 && lemon == 0) { return CGFloat(1.0) }
		else if ((ice == 0) && (lemon > 0)) {
			return CGFloat(1.1)
		} else { return CGFloat(lemon/ice)}
	}
	
	
	func lemonateTaste(lemonadeAcid:CGFloat)-> String{
		var taste:String!
		if (lemonadeAcid < CGFloat(1.0)) {
			taste =  "Diluted"
		}
		else if (lemonadeAcid > CGFloat(1.0)){
			taste =  "Acidic"
		}
		else {
			taste = "Neutral"
		}
		return taste
	}
	
	
	func getLemonadeTaste(){
		var acidIndex = lemonadeAcidIndex(data.lemonsUsed, ice: data.iceCubesUsed)
		var tasteString = lemonateTaste(acidIndex)
		//populate label
		self.lemonadeTaste.text = tasteString
		
	}
	
	
	
	func generateCustomers()->[Customer]{
		var myCustomersArray:[Customer]=[]
		for var i = 0; i < 5; ++i {
			var customer = Customer()
			myCustomersArray.append(customer)
		}		
		return myCustomersArray
	}
	
	func sellLemonade(customerList:[Customer], lemonadeTaste:String)->Double {
		var decision:Bool!
		var clientNumber = customerList.count
		var lemonadesSold:Int = 0
		var moneyMade:Double = 0.0
		mixLemonade()
		if data.inStock == 0 {
			showAlertWithText(header: "Warning", message: "No Lemonade to sell")
		} else {
			for client in customerList {
				if (lemonadeTaste == client.randomPreference()) {
				
					println("Paid!")
					lemonadesSold += 1
					data.iceCubesUsed = 0
					data.lemonsUsed = 0
				} else {
				
				println("Didn't buy")
			}
		}
		}
		moneyMade = Double(lemonadesSold)
		return moneyMade
	}
	
	func purchaseLemon(){
		// discount $2 from balance
		if data.money >= 2.0{
			data.lemons += 1
			data.money -= 2.0
			data.lemonsInCart += 1
		} else {
			// display a message box "No more money to buy lemons"
			showAlertWithText(header: "Warning", message: "Not enough money to buy lemons.")
		}
	}

	func purchaseLessLemon(){
			// discount $2 from balance
			if data.lemonsInCart > 0 {
				data.lemons -= 1
				data.money += 2.0
				data.lemonsInCart -= 1
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
	
	func purchaseMoreIce(){
		if data.money >= 1.0 {
			data.iceCubes += 1
			data.money -= 1.0
			data.iceCubesInCart += 1
		} else {
			showAlertWithText(header: "Warning", message: "Not enough money to buy ice cubes")
		}
	}
	
	func purchaseLessIce(){
		if data.iceCubesInCart > 0 {
			data.iceCubes -= 1
			data.money += 1.0
			data.iceCubesInCart -= 1
		} else {
			showAlertWithText(header: "Warning", message: "You don't have ice cubes")
		}
	}
	
	func addLemon(){
		// check if data.lemons >0
		if data.lemons > 0 {
		// add 1 lemon to mix
			data.lemonsUsed += 1
		// take away 1 lemon from balance
			data.lemons -= 1
		// else print warning
		} else {
			showAlertWithText(header: "Warning", message: "You don't have lemons")
		}
	}
	
	func removeLemon(){
		if data.lemonsUsed > 0 {
			data.lemonsUsed -= 1
			data.lemons += 1
		} else {
			showAlertWithText(header: "Warning", message: "No more lemons to remove")
		}
	}
	
	func addIce(){
		if data.iceCubes > 0 {
			data.iceCubesUsed += 1
			data.iceCubes -= 1
		} else {
			showAlertWithText(header: "Warning", message: "You don't have ice")
		}
		
	}
	
	func removeIce(){
		if data.iceCubesUsed > 0 {
			data.iceCubesUsed -= 1
			data.iceCubes += 1
		} else {
			showAlertWithText(header: "Warning", message: "No more ice cubes to remove")
		}
	}
	
	func mixLemonade(){
		if (data.lemonsUsed == 0 && data.iceCubesUsed == 0) {
			data.inStock = 0
			showAlertWithText(header: "Warning", message: "No More Lemonade to sell")
		} else if (data.iceCubesUsed == 0){
			showAlertWithText(header: "Warning", message: "You are selling only lemon juice! Please add some ice cubes!")
		} else if (data.lemonsUsed == 0){
			showAlertWithText(header: "Warning", message: "You are selling ice cubes! Please add some lemons")
		}
		else {
			data.inStock = 1
		}
	}
	
	func resetMix(){
		
		data.iceCubesUsed = 0
		data.lemonsUsed = 0
		data.inStock = 0
	}

}