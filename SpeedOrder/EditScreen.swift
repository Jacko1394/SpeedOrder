//  EditScreen.swift
//  SpeedOrder
//  Created by Jack on 1/02/2016.
//  Copyright © 2016 Jack. All rights reserved.

import UIKit

class EditScreen: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, editView {
    //Reference to the appdelegate:
    let app = UIApplication.shared.delegate as! AppDelegate
    let priceFormatter = NumberFormatter()
    let customExtra = UIAlertController(title: "Instructions:", message: "Insert custom instructions:", preferredStyle: .alert)
    
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
    func addExtraItem(_ index: Int) {
        if(app.order.foods.count != 0 && app.useIndex) {
            switch index {
            case 0...23:
                let newExtra = Extra(extra: Ingredients(rawValue: index + 1)!, minus: minusing)
                app.order.foods[(app.indexPath! as NSIndexPath).row].addNewExtra(newExtra, doingHalf: doingHalf)
                app.order.foods[(app.indexPath! as NSIndexPath).row].calcPrice()
                checkView()
            case 25: //Clear item:
                app.order.foods[(app.indexPath! as NSIndexPath).row].clearExtras()
                checkView()
            case 26:
                minusing = !minusing
                if(minusing) {extraCells[26].itemButton.backgroundColor = .darkGray}
                else {extraCells[26].itemButton.backgroundColor = .lightGray}
            case 27: self.present(customExtra, animated: true, completion: nil)
            default: print("extra item selection error")
            }
        }
    }
    
    //Updates the edit screen UI information:
    func checkView() {
        //Handles half-half optioning:
        if(app.order.foods[(app.indexPath! as NSIndexPath).row].halfhalf) {
            rightText.text! = app.order.foods[(app.indexPath! as NSIndexPath).row].extras(true, asComma: false)
            rightText.isHidden = false
            rightTitle.text! = MenuItems.itemString[app.order.foods[(app.indexPath! as NSIndexPath).row].item2!.rawValue]
            rightTitle.isHidden = false
        } else { //Solo pizza:
            rightText.isHidden = true
            rightTitle.isHidden = true
            leftText.backgroundColor = UIColor.lightGray
            rightText.backgroundColor = UIColor.groupTableViewBackground
        }
        
        //Left/solo pizza deets:
        leftText.text! = app.order.foods[(app.indexPath! as NSIndexPath).row].extras(false, asComma: false)
        leftTitle.text! = MenuItems.itemString[app.order.foods[(app.indexPath! as NSIndexPath).row].item.rawValue]
        mainItemLabel.text! = app.order.foods[(app.indexPath! as NSIndexPath).row].asString()
        
        //Loop thru cell menu buttons:
        for cell in extraCells {
            //Resets each button color:
            if(cell.index < 25) {cell.itemButton.backgroundColor = .clear}
            else {
                if(cell.index == 26) {
                    if(minusing) {cell.itemButton.backgroundColor = .darkGray}
                    else {cell.itemButton.backgroundColor = .lightGray}
                } else {cell.itemButton.backgroundColor = .lightGray}
            }
            
            //Which half to colour?:
            if(doingHalf) {
                //Loops thru the ingredients in the current pizza (half)
                if(app.order.foods[(app.indexPath! as NSIndexPath).row].item2!.rawValue < 28) {
                    for i in Ingredients.recipe[app.order.foods[(app.indexPath! as NSIndexPath).row].item2!.rawValue] {
                        //Changes colour if it's in the pizza:
                        if(cell.index + 1 == i.rawValue) {
                            cell.itemButton.backgroundColor = UIColor(red: 140/255, green: 1, blue: 125/255, alpha: 1)
                        }
                    }
                    //Adds the ingredients added by user:
                    //for(var i = 0; i < app.order.foods[app.indexPath!.row].ingredients2!.count; ++i) {
                    for i in 0 ..< app.order.foods[(app.indexPath! as NSIndexPath).row].ingredients2!.count {
                        if(app.order.foods[(app.indexPath! as NSIndexPath).row].ingredients2![i].extra.rawValue == cell.index + 1) {
                            if(app.order.foods[(app.indexPath! as NSIndexPath).row].ingredients2![i].minus) {
                                cell.itemButton.backgroundColor = UIColor(red: 1, green: 130/255, blue: 130/255, alpha: 1)
                            } else {
                                cell.itemButton.backgroundColor = UIColor(red: 140/255, green: 1, blue: 125/255, alpha: 1)
                            }
                        }
                    }
                }
            } else {
                //Loops thru the ingredients in the current pizza
                if(app.order.foods[(app.indexPath! as NSIndexPath).row].item.rawValue < 28) {
                    for i in Ingredients.recipe[app.order.foods[(app.indexPath! as NSIndexPath).row].item.rawValue] {
                        //Changes colour if it's in the pizza:
                        if(cell.index + 1 == i.rawValue) {
                            cell.itemButton.backgroundColor = UIColor(red: 140/255, green: 1, blue: 125/255, alpha: 1)
                        }
                    }
                }
                //Adds the ingredients added by user:
                //for(var i = 0; i < app.order.foods[app.indexPath!.row].ingredients.count; ++i) {
                for i in 0 ..< app.order.foods[(app.indexPath! as NSIndexPath).row].ingredients.count {
                    if(app.order.foods[(app.indexPath! as NSIndexPath).row].ingredients[i].extra.rawValue == cell.index + 1) {
                        if(app.order.foods[(app.indexPath! as NSIndexPath).row].ingredients[i].minus) {
                            cell.itemButton.backgroundColor = UIColor(red: 1, green: 130/255, blue: 130/255, alpha: 1)
                        } else {
                            cell.itemButton.backgroundColor = UIColor(red: 140/255, green: 1, blue: 125/255, alpha: 1)
                        }
                    }
                }
            }
        }
        
        orderList.reloadRows(at: [app.indexPath! as IndexPath], with: .none)
        orderList.selectRow(at: app.indexPath as IndexPath?, animated: animate, scrollPosition: .middle)
        animate = false
    }
    
    //TableView FUNCTIONS:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderList.dequeueReusableCell(withIdentifier: "editItem") as! myOrderCell
        cell.itemLabel.text! = app.order.foods[(indexPath as NSIndexPath).row].asString()
        cell.indexLabel.text! = "\((indexPath as NSIndexPath).row + 1)."
        cell.commaDescLabel.text! = app.order.foods[(indexPath as NSIndexPath).row].extras(false, asComma: true)
        //cell.priceLabel.text! = "\(priceFormatter.string(from: NSNumber(app.order.foods[(indexPath as NSIndexPath).row].price))!)"
        
        //itemCells.append(cell)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return app.order.foods.count}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        app.useIndex = true
        doingHalf = false
        minusing = false
        app.indexPath = indexPath
        leftText.backgroundColor = .lightGray
        rightText.backgroundColor = .groupTableViewBackground
        animate = true
        checkView()
    }
    
    //CollectionView FUNCTIONS:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return 28}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = extrasList.dequeueReusableCell(withReuseIdentifier: "extraItem", for: indexPath) as! extrasCell
        cell.index = (indexPath as NSIndexPath).row
        cell.delegate = self
        cell.itemButton.setTitle(Ingredients.extraString[cell.index + 1], for: UIControlState())
        cell.itemButton.setTitleColor(.black, for: UIControlState())
        cell.itemButton.layer.cornerRadius = 10
        cell.itemButton.clipsToBounds = true
        
        if((indexPath as NSIndexPath).row > 24) {
            cell.itemButton.backgroundColor = .lightGray
            if((indexPath as NSIndexPath).row == 27 && app.useIndex) {checkView()}
        }
        extraCells.append(cell)
        
        return cell
        
    }
    
    //Left right buttons for half-half:
    func leftPushed() {
        if(app.useIndex && app.order.foods[(app.indexPath! as NSIndexPath).row].halfhalf) {
            leftText.backgroundColor = .lightGray
            rightText.backgroundColor = .groupTableViewBackground
            doingHalf = false
            checkView()
        }
    }
    func rightPushed() {
        if(app.useIndex && app.order.foods[(app.indexPath! as NSIndexPath).row].halfhalf) {
            leftText.backgroundColor = .groupTableViewBackground
            rightText.backgroundColor = .lightGray
            doingHalf = true
            checkView()
        }
    }
    
    //CONTROLLER:
    override func viewDidLoad() {
        //var singleTap = UITapGestureRecognizer(target: self, action: "leftPushed")
        var singleTap = UITapGestureRecognizer(target: self, action: #selector(EditScreen.leftPushed))
        leftText.addGestureRecognizer(singleTap)
        singleTap = UITapGestureRecognizer(target: self, action: #selector(EditScreen.rightPushed))
        rightText.addGestureRecognizer(singleTap)
        
        orderList.layer.cornerRadius = 25
        leftText.layer.cornerRadius = 5
        rightText.layer.cornerRadius = 5
        extrasList.layer.cornerRadius = 10
        orderList.clipsToBounds = true
        orderList.clipsToBounds = true
        orderList.clipsToBounds = true
        extrasList.clipsToBounds = true
        priceFormatter.numberStyle = .currency
        
        customExtra.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        customExtra.addTextField(configurationHandler: {(text: UITextField!) in self.tempCustomText = text})
        customExtra.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
            if(self.doingHalf) {
                self.app.order.foods[(self.app.indexPath! as NSIndexPath).row].foodNotes2 = self.tempCustomText.text!
            } else {
                self.app.order.foods[(self.app.indexPath! as NSIndexPath).row].foodNotes = self.tempCustomText.text!
            }
            self.checkView()
        }))
    }
    override func viewDidAppear(_ animated: Bool) {
        doingHalf = false
        minusing = false
        leftText.backgroundColor = .lightGray
        rightText.backgroundColor = .groupTableViewBackground
        orderList.reloadData()
        if(app.useIndex) {
            orderList.selectRow(at: app.indexPath as IndexPath?, animated: true, scrollPosition: .middle)
            checkView()
        } else {
            //Reset button colours:
            for cell in extraCells {
                if(cell.index > 24) {cell.itemButton.backgroundColor = .lightGray}
                else {cell.itemButton.backgroundColor = .clear}
            }
            mainItemLabel.text! = "..."
            leftTitle.text! = "..."
            leftText.text! = "+"
            rightTitle.isHidden = true
            rightText.isHidden = true
        }
        orderLabel.text! = "ORDER: [\(app.order.orderNumber)]"
        
    }
    override func didReceiveMemoryWarning() {app.saveOrders()}
}//END OF FILE
