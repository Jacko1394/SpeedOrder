//  SecondViewController.swift
//  SpeedOrder App
//  Created by Jack Della on 21/01/2016.
//  Copyright © 2016 Jack Della. All rights reserved.

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let app = UIApplication.shared.delegate as! AppDelegate
    let dateFormat = DateFormatter()
    let priceFormat = NumberFormatter()
    let finaliseMsg = UIAlertController(title: "CONFIRM", message: "Finish / delete orders?", preferredStyle: .alert)
    
    var nameArray = [UILabel]()
    
    @IBOutlet weak var ordersList: UITableView!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var endLabel1: UILabel!
    @IBOutlet weak var endLabel2: UILabel!
    
    @IBAction func endOrders(_ sender: AnyObject) {self.present(finaliseMsg, animated: true, completion: nil)}
    
    //TableView FUNCTIONS::::::::
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return app.orderList.count}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersList.dequeueReusableCell(withIdentifier: "orderCell") as! ordersCell
        cell.orderNumLabel.text! = "\(app.orderList[(indexPath as NSIndexPath).row].orderNumber)."
        
        cell.nameLabel.text! = app.orderList[(indexPath as NSIndexPath).row].name
        if(app.orderList[(indexPath as NSIndexPath).row].delivery) {
            cell.nameLabel.shadowColor = UIColor(red: 1, green: 200/255, blue: 0, alpha: 1)
            cell.nameLabel.shadowOffset = CGSize(width: 2, height: -2)
        } else {
            cell.nameLabel.shadowColor = .clear
            cell.nameLabel.shadowOffset = CGSize(width: 0, height: 0)
        }
        
        cell.numItemsLabel.text! = "\(app.orderList[(indexPath as NSIndexPath).row].foods.count)"
        cell.timeLabel.text! = "\(dateFormat.string(from: app.orderList[(indexPath as NSIndexPath).row].timeDate as Date))"
        //cell.priceLabel.text! = "\(priceFormat.string(from: NSNumber(app.orderList[(indexPath as NSIndexPath).row].priceTotal))!)"
        
        nameArray.append(cell.nameLabel)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        app.order = app.orderList[(indexPath as NSIndexPath).row]
        app.editingOrder = (indexPath as NSIndexPath).row
        tabBarController?.selectedIndex = 0
    }
    
    //CONTROLLER
    override func viewDidAppear(_ animated: Bool) {
        ordersList.reloadData()
        orderNumberLabel.text! = "[\(app.orderList.count)]"
    }
    override func viewDidLoad() {
        priceFormat.numberStyle = .currency
        dateFormat.timeStyle = .none
        dateFormat.dateStyle = .full
        orderDateLabel.text! = "ORDERS: \(dateFormat.string(from: Date()))"
        dateFormat.timeStyle = .short
        dateFormat.dateStyle = .none
        dateFormat.timeStyle = .short
        ordersList.layer.cornerRadius = 30
        ordersList.clipsToBounds = true
        endLabel1.layer.cornerRadius = 15
        endLabel1.clipsToBounds = true
        endLabel2.layer.cornerRadius = 15
        endLabel2.clipsToBounds = true
        
        //Setup Cancel Message:
        finaliseMsg.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.app.printer.printSummary(self.app.orderList)
            self.app.orderList = [Order]()
            self.app.order = Order()
            self.app.saveOrders()
            self.ordersList.reloadData()
            self.orderNumberLabel.text! = "[\(self.app.orderList.count)]"
        }))
        
        finaliseMsg.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    }
    
    override func didReceiveMemoryWarning() {app.saveOrders()}
}//END OF FILE
