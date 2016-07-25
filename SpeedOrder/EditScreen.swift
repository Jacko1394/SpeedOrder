//  EditScreen.swift
//  SpeedOrder
//  Created by Jack on 1/02/2016.
//  Copyright © 2016 Jack. All rights reserved.

import UIKit

class EditScreen: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, editView {
    //Reference to the appdelegate:
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    let priceFormatter = NSNumberFormatter()
    let customExtra = UIAlertController(title: "Instructions:", message: "Insert custom instructions:", preferredStyle: .Alert)
    
    //Extras and order list views:
    @IBOutlet weak var orderList: UITableView!
    @IBOutlet weak var extrasList: UICollectionView!
    //Extras textfields:
    @IBOutlet weak var leftText: UITextView!
    @IBOutlet weak var rightText: UITextView!
    //New item label:
    @IBOutlet weak var mainItemLabel: UILabel!
    //Pizza halfs names:
    @IBOutlet weak var leftTitle: UILabel!
    @IBOutlet weak var rightTitle: UILabel!
    //Order number label:
    @IBOutlet weak var orderLabel: UILabel!
    
    
    //Reference to the extras menu item cells:
    var extraCells = [extrasCell]()
    //var itemCells = [myOrderCell]()
    var doingHalf = false
    var minusing = false
    var animate = false
    var tempCustomText = UITextField()

    //When extr button is pushed:
    func addExtraItem(index: Int) {
        if(app.order.foods.count != 0 && app.useIndex) {
            switch index {
            case 0...23:
                let newExtra = Extra(extra: Ingredients(rawValue: index + 1)!, minus: minusing)
                app.order.foods[app.indexPath!.row].addNewExtra(newExtra, doingHalf: doingHalf)
                app.order.foods[app.indexPath!.row].calcPrice()
                checkView()
            case 25: //Clear item:
                app.order.foods[app.indexPath!.row].clearExtras()
                checkView()
            case 26:
                minusing = !minusing
                if(minusing) {extraCells[26].itemButton.backgroundColor = .darkGrayColor()}
                else {extraCells[26].itemButton.backgroundColor = .lightGrayColor()}
            case 27: self.presentViewController(customExtra, animated: true, completion: nil)
            default: print("extra item selection error")
            }
        }
    }
    
    //Updates the edit screen UI information:
    func checkView() {
        //Handles half-half optioning:
        if(app.order.foods[app.indexPath!.row].halfhalf) {
            rightText.text! = app.order.foods[app.indexPath!.row].extras(true, asComma: false)
            rightText.hidden = false
            rightTitle.text! = MenuItems.itemString[app.order.foods[app.indexPath!.row].item2!.rawValue]
            rightTitle.hidden = false
        } else { //Solo pizza:
            rightText.hidden = true
            rightTitle.hidden = true
            leftText.backgroundColor = UIColor.lightGrayColor()
            rightText.backgroundColor = UIColor.groupTableViewBackgroundColor()
        }
        
        //Left/solo pizza deets:
        leftText.text! = app.order.foods[app.indexPath!.row].extras(false, asComma: false)
        leftTitle.text! = MenuItems.itemString[app.order.foods[app.indexPath!.row].item.rawValue]
        mainItemLabel.text! = app.order.foods[app.indexPath!.row].asString()
        
        //Loop thru cell menu buttons:
        for cell in extraCells {
            //Resets each button color:
            if(cell.index < 25) {cell.itemButton.backgroundColor = .clearColor()}
            else {
                if(cell.index == 26) {
                    if(minusing) {cell.itemButton.backgroundColor = .darkGrayColor()}
                    else {cell.itemButton.backgroundColor = .lightGrayColor()}
                } else {cell.itemButton.backgroundColor = .lightGrayColor()}
            }
            
            //Which half to colour?:
            if(doingHalf) {
                //Loops thru the ingredients in the current pizza (half)
                if(app.order.foods[app.indexPath!.row].item2!.rawValue < 28) {
                    for i in Ingredients.recipe[app.order.foods[app.indexPath!.row].item2!.rawValue] {
                        //Changes colour if it's in the pizza:
                        if(cell.index + 1 == i.rawValue) {
                            cell.itemButton.backgroundColor = UIColor(red: 140/255, green: 1, blue: 125/255, alpha: 1)
                        }
                    }
                    //Adds the ingredients added by user:
                    for(var i = 0; i < app.order.foods[app.indexPath!.row].ingredients2!.count; ++i) {
                        if(app.order.foods[app.indexPath!.row].ingredients2![i].extra.rawValue == cell.index + 1) {
                            if(app.order.foods[app.indexPath!.row].ingredients2![i].minus) {
                                cell.itemButton.backgroundColor = UIColor(red: 1, green: 130/255, blue: 130/255, alpha: 1)
                            } else {
                                cell.itemButton.backgroundColor = UIColor(red: 140/255, green: 1, blue: 125/255, alpha: 1)
                            }
                        }
                    }
                }
            } else {
                //Loops thru the ingredients in the current pizza
                if(app.order.foods[app.indexPath!.row].item.rawValue < 28) {
                    for i in Ingredients.recipe[app.order.foods[app.indexPath!.row].item.rawValue] {
                        //Changes colour if it's in the pizza:
                        if(cell.index + 1 == i.rawValue) {
                            cell.itemButton.backgroundColor = UIColor(red: 140/255, green: 1, blue: 125/255, alpha: 1)
                        }
                    }
                }
                //Adds the ingredients added by user:
                for(var i = 0; i < app.order.foods[app.indexPath!.row].ingredients.count; ++i) {
                    if(app.order.foods[app.indexPath!.row].ingredients[i].extra.rawValue == cell.index + 1) {
                        if(app.order.foods[app.indexPath!.row].ingredients[i].minus) {
                            cell.itemButton.backgroundColor = UIColor(red: 1, green: 130/255, blue: 130/255, alpha: 1)
                        } else {
                            cell.itemButton.backgroundColor = UIColor(red: 140/255, green: 1, blue: 125/255, alpha: 1)
                        }
                    }
                }
            }
        }
        
        orderList.reloadRowsAtIndexPaths([app.indexPath!], withRowAnimation: .None)
        orderList.selectRowAtIndexPath(app.indexPath, animated: animate, scrollPosition: .Middle)
        animate = false
    }
    
    //TableView FUNCTIONS:
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = orderList.dequeueReusableCellWithIdentifier("editItem") as! myOrderCell
        cell.itemLabel.text! = app.order.foods[indexPath.row].asString()
        cell.indexLabel.text! = "\(indexPath.row + 1)."
        cell.commaDescLabel.text! = app.order.foods[indexPath.row].extras(false, asComma: true)
        cell.priceLabel.text! = "\(priceFormatter.stringFromNumber(app.order.foods[indexPath.row].price)!)"
        
        //itemCells.append(cell)
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return app.order.foods.count}
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        app.useIndex = true
        doingHalf = false
        minusing = false
        app.indexPath = indexPath
        leftText.backgroundColor = .lightGrayColor()
        rightText.backgroundColor = .groupTableViewBackgroundColor()
        animate = true
        checkView()
    }
    
    //CollectionView FUNCTIONS:
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return 28}
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = extrasList.dequeueReusableCellWithReuseIdentifier("extraItem", forIndexPath: indexPath) as! extrasCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.itemButton.setTitle(Ingredients.extraString[cell.index + 1], forState: .Normal)
        cell.itemButton.setTitleColor(.blackColor(), forState: .Normal)
        cell.itemButton.layer.cornerRadius = 10
        cell.itemButton.clipsToBounds = true
        
        if(indexPath.row > 24) {
            cell.itemButton.backgroundColor = .lightGrayColor()
            if(indexPath.row == 27 && app.useIndex) {checkView()}
        }
        extraCells.append(cell)
        
        return cell
        
    }
    
    //Left right buttons for half-half:
    func leftPushed() {
        if(app.useIndex && app.order.foods[app.indexPath!.row].halfhalf) {
            leftText.backgroundColor = .lightGrayColor()
            rightText.backgroundColor = .groupTableViewBackgroundColor()
            doingHalf = false
            checkView()
        }
    }
    func rightPushed() {
        if(app.useIndex && app.order.foods[app.indexPath!.row].halfhalf) {
            leftText.backgroundColor = .groupTableViewBackgroundColor()
            rightText.backgroundColor = .lightGrayColor()
            doingHalf = true
            checkView()
        }
    }
    
    //CONTROLLER:
    override func viewDidLoad() {
        var singleTap = UITapGestureRecognizer(target: self, action: "leftPushed")
        leftText.addGestureRecognizer(singleTap)
        singleTap = UITapGestureRecognizer(target: self, action: "rightPushed")
        rightText.addGestureRecognizer(singleTap)
        orderList.layer.cornerRadius = 25
        leftText.layer.cornerRadius = 5
        rightText.layer.cornerRadius = 5
        extrasList.layer.cornerRadius = 10
        orderList.clipsToBounds = true
        orderList.clipsToBounds = true
        orderList.clipsToBounds = true
        extrasList.clipsToBounds = true
        priceFormatter.numberStyle = .CurrencyStyle
        
        customExtra.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        customExtra.addTextFieldWithConfigurationHandler({(text: UITextField!) in self.tempCustomText = text})
        customExtra.addAction(UIAlertAction(title: "OK", style: .Default, handler: {(alert: UIAlertAction!) in
            if(self.doingHalf) {
                self.app.order.foods[self.app.indexPath!.row].foodNotes2 = self.tempCustomText.text!
            } else {
                self.app.order.foods[self.app.indexPath!.row].foodNotes = self.tempCustomText.text!
            }
            self.checkView()
        }))
    }
    override func viewDidAppear(animated: Bool) {
        doingHalf = false
        minusing = false
        leftText.backgroundColor = .lightGrayColor()
        rightText.backgroundColor = .groupTableViewBackgroundColor()
        orderList.reloadData()
        if(app.useIndex) {
            orderList.selectRowAtIndexPath(app.indexPath, animated: true, scrollPosition: .Middle)
            checkView()
        } else {
            //Reset button colours:
            for cell in extraCells {
                if(cell.index > 24) {cell.itemButton.backgroundColor = .lightGrayColor()}
                else {cell.itemButton.backgroundColor = .clearColor()}
            }
            mainItemLabel.text! = "..."
            leftTitle.text! = "..."
            leftText.text! = "+"
            rightTitle.hidden = true
            rightText.hidden = true
        }
        orderLabel.text! = "ORDER: [\(app.order.orderNumber)]"
        
    }
    override func didReceiveMemoryWarning() {app.saveOrders()}
}//END OF FILE