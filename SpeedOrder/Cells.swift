//  Cells.swift
//  SpeedOrder
//  Created by Jack on 26/01/2016.
//  Copyright © 2016 Jack. All rights reserved.

import UIKit

//Delegate protocol definitions:
protocol firstView {
    func removeItem(index: Int)
    func addMenuItem(index: Int, sender: AnyObject)
}
protocol editView {func addExtraItem(index: Int)}

//FirstViewController customcells::::::::::::::::::::::::::::::::
//Current order list cell:
class myCell: UITableViewCell {
    var delegate: firstView?
    var index = 0
    
    @IBOutlet weak var pizzaLabel: UILabel!
    @IBOutlet weak var pizzaDesc: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBAction func removeButton(sender: AnyObject) {delegate?.removeItem(index)}
}

//Cell of menuitem select:
class myMenuCell: UICollectionViewCell {
    var delegate: firstView?
    var index = 0
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBAction func menuItemSelect(sender: AnyObject) {delegate?.addMenuItem(index, sender: sender)}
}

//Cell of the address list:
class addressListCell: UITableViewCell {
    @IBOutlet weak var addressLabel: UILabel!
}

//EditScreen customcells::::::::::::::::::::::::::::::::::::::::::
//Current order list cells for edit screen:
class myOrderCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var commaDescLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}

//Extra ingredients menu options cells:
class extrasCell: UICollectionViewCell {
    var delegate: editView?
    var index = 0
    
    @IBOutlet weak var itemButton: UIButton!
    @IBAction func buttonPress(sender: AnyObject) {delegate?.addExtraItem(index)}
}

//SecondViewController custom cells:
//Cell of the ordersList:
class ordersCell: UITableViewCell {
    @IBOutlet weak var orderNumLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numItemsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
}//END OF FILE