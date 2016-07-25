//  AppDelegate.swift
//  SpeedOrder App
//  Created by Jack Della on 21/01/2016.
//  Copyright © 2016 Jack Della. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let printer = Printer()
    
    var window: UIWindow?
    var indexPath: NSIndexPath? = nil
    var useIndex = false
    var editingOrder: Int? = nil
    
    var orderList = [Order]()
    var newFood = Food()
    var order = Order()
    
    //Order/Food/Printer programs:
    func updateOrder() {
        //Sets price of food, adds it to item list:
        newFood.calcPrice()
        order.addItem(newFood.copy() as! Food)
        
        //Sorts order:
        var pizzas = [Food]()
        var pastas = [Food]()
        var others = [Food]()
        
        for (var i = 0; i < order.foods.count; ++i) {
            switch order.foods[i].item.rawValue {
            case 1...17, 35: pizzas.append(order.foods[i])
            case 18...25: pastas.append(order.foods[i])
            case 26...34 : others.append(order.foods[i])
            default : print("APP: Sorting order error")
            }
        }
        //Updates item list to the new order:
        order.foods = [Food]()
        order.foods.appendContentsOf(pizzas)
        order.foods.appendContentsOf(pastas)
        order.foods.appendContentsOf(others)
    }
    func makeOrder(name: String) {
        //Finalize order:
        order.name = name
        order.timeDate = NSDate()
        //Printer order:
        editingOrder = nil
        printer.printOrder(order)
        //Save and clear:
        resetOrder()
        saveOrders()
    }
    func resetOrder() {
        order = Order()
        order.orderNumber = orderList.count + 1
    }
    func removeFood(index: Int) {
        order.priceTotal -= order.foods[index].price
        order.foods.removeAtIndex(index)
    }
    func halfHalfFood() -> String {
        if(newFood.halfhalf) {
            newFood.item2 = nil
            newFood.ingredients2 = nil
            newFood.halfhalf = false
        } else {
            if(newFood.size != .Small) {
                newFood.halfhalf = true
                newFood.ingredients2 = [Extra]()
                newFood.item2 = .Capricciosa
            }
        }
        return newFood.asString()
    }
    
    //Application state handling functions:
    func applicationDidEnterBackground(application: UIApplication) {
        saveOrders()
        print("APP: Background (saved)")
    }
    func applicationDidBecomeActive(application: UIApplication) {
        orderList = loadOrders()
        order.orderNumber = orderList.count + 1
        print("APP: Active (loaded)")
    }
    
    //Save and load order functions:
    func saveOrders(){
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(orderList), forKey: "orders")
    }
    func loadOrders() -> [Order]{
        let orderData = NSUserDefaults.standardUserDefaults().objectForKey("orders") as? NSData
        
        if let orderData = orderData {
            let orderList = NSKeyedUnarchiver.unarchiveObjectWithData(orderData) as? [Order]
            if let orderList = orderList {return orderList}
        }
        print("ERROR: Bunk order load")
        return [Order]()
    }
    
    
    
    
    
}//END OF FILE