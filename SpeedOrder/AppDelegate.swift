//  AppDelegate.swift
//  SpeedOrder App
//  Created by Jack Della on 21/01/2016.
//  Copyright © 2016 Jack Della. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let printer = Printer()
    
    var window: UIWindow?
    var indexPath: IndexPath? = nil
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
        
        //for (var i = 0; i < order.foods.count; ++i) {
        for i in 0 ..< order.foods.count {
            switch order.foods[i].item.rawValue {
            case 1...17, 35: pizzas.append(order.foods[i])
            case 18...25: pastas.append(order.foods[i])
            case 26...34 : others.append(order.foods[i])
            default : print("APP: Sorting order error")
            }
        }
        //Updates item list to the new order:
        order.foods = [Food]()
        order.foods.append(contentsOf: pizzas)
        order.foods.append(contentsOf: pastas)
        order.foods.append(contentsOf: others)
    }
    func makeOrder(_ name: String) {
        //Finalize order:
        order.name = name
        order.timeDate = Date()
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
    func removeFood(_ index: Int) {
        order.priceTotal -= order.foods[index].price
        order.foods.remove(at: index)
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
                newFood.item2 = .capricciosa
            }
        }
        return newFood.asString()
    }
    
    //Application state handling functions:
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveOrders()
        print("APP: Background (saved)")
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        orderList = loadOrders()
        order.orderNumber = orderList.count + 1
        print("APP: Active (loaded)")
    }
    
    //Save and load order functions:
    func saveOrders(){
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: orderList), forKey: "orders")
    }
    func loadOrders() -> [Order]{
        let orderData = UserDefaults.standard.object(forKey: "orders") as? Data
        
        if let orderData = orderData {
            let orderList = NSKeyedUnarchiver.unarchiveObject(with: orderData) as? [Order]
            if let orderList = orderList {return orderList}
        }
        print("ERROR: Bunk order load")
        return [Order]()
    }
    
    
    
    
    
}//END OF FILE
