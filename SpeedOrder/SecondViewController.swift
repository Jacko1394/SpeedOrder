//  SecondViewController.swift
//  SpeedOrder App
//  Created by Jack Della on 21/01/2016.
//  Copyright © 2016 Jack Della. All rights reserved.

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    let dateFormat = NSDateFormatter()
    let priceFormat = NSNumberFormatter()
    let finaliseMsg = UIAlertController(title: "CONFIRM", message: "Finish /delete orders?", preferredStyle: .Alert)
    
    var nameArray = [UILabel]()
    
    @IBOutlet weak var ordersList: UITableView!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var endLabel1: UILabel!
    @IBOutlet weak var endLabel2: UILabel!
    
    @IBAction func endOrders(sender: AnyObject) {self.presentViewController(finaliseMsg, animated: true, completion: nil)}
    
    //TableView FUNCTIONS::::::::
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return app.orderList.count}
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ordersList.dequeueReusableCellWithIdentifier("orderCell") as! ordersCell
        cell.orderNumLabel.text! = "\(app.orderList[indexPath.row].orderNumber)."
        
        cell.nameLabel.text! = app.orderList[indexPath.row].name
        if(app.orderList[indexPath.row].delivery) {
            cell.nameLabel.shadowColor = UIColor(red: 1, green: 200/255, blue: 0, alpha: 1)
            cell.nameLabel.shadowOffset = CGSize(width: 2, height: -2)
        } else {
            cell.nameLabel.shadowColor = .clearColor()
            cell.nameLabel.shadowOffset = CGSize(width: 0, height: 0)
        }
        
        cell.numItemsLabel.text! = "\(app.orderList[indexPath.row].foods.count)"
        cell.timeLabel.text! = "\(dateFormat.stringFromDate(app.orderList[indexPath.row].timeDate))"
        cell.priceLabel.text! = "\(priceFormat.stringFromNumber(app.orderList[indexPath.row].priceTotal)!)"
        
        nameArray.append(cell.nameLabel)
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        app.order = app.orderList[indexPath.row]
        app.editingOrder = indexPath.row
        tabBarController?.selectedIndex = 0
    }
    
    //CONTROLLER
    override func viewDidAppear(animated: Bool) {
        ordersList.reloadData()
        orderNumberLabel.text! = "[\(app.orderList.count)]"
    }
    override func viewDidLoad() {
        priceFormat.numberStyle = .CurrencyStyle
        dateFormat.timeStyle = .NoStyle
        dateFormat.dateStyle = .FullStyle
        orderDateLabel.text! = "ORDERS: \(dateFormat.stringFromDate(NSDate()))"
        dateFormat.timeStyle = .ShortStyle
        dateFormat.dateStyle = .NoStyle
        dateFormat.timeStyle = .ShortStyle
        ordersList.layer.cornerRadius = 30
        ordersList.clipsToBounds = true
        endLabel1.layer.cornerRadius = 15
        endLabel1.clipsToBounds = true
        endLabel2.layer.cornerRadius = 15
        endLabel2.clipsToBounds = true
        
        //Setup Cancel Message:
        finaliseMsg.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.app.printer.printSummary(self.app.orderList)
            self.app.orderList = [Order]()
            self.app.order = Order()
            self.app.saveOrders()
            self.ordersList.reloadData()
            self.orderNumberLabel.text! = "[\(self.app.orderList.count)]"
        }))
        
        finaliseMsg.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
    }
    
    override func didReceiveMemoryWarning() {app.saveOrders()}
}//END OF FILE