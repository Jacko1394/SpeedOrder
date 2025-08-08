//  FirstViewController.swift
//  SpeedOrder App
//  Created by Jack Della on 21/01/2016.
//  Copyright © 2016 Jack Della. All rights reserved.

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate, firstView {
    
    //Reference to AppDelegate:
    let app = UIApplication.shared.delegate as! AppDelegate
    //AlertVIEW:::
    let drinkSelector = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let drinks = ["Coke", "Diet Coke", "Coke Zero", "Solo", "Lemonade", "Sunkist"]
    let errorMessage = UIAlertController(title: "ERROR", message: "Input customer details!", preferredStyle: .alert)
    let cancelMessage = UIAlertController(title: "CONFIRM", message: "Clear current order?", preferredStyle: .alert)
    let priceFormatter = NumberFormatter()
    
    var allowPrint = [false, true]
    var indexes = [String]()
    var arrayAddressText  = [String]()
    
    let addressesArrays = [
        //SUNBURY:
        ["Abelia Ct", "Acacia Ct", "Acheron Ct", "Adams Ct", "Agar Pl", "Ailsa Ct", "Ainsdale Ct", "Aitken St", "Albert Rd", "Alderman Cl", "Aldridge Dr", "Allen Ct", "Alpine Cl", "Anderson Rd", "Angas Ct", "Annois Ct", "Anthony St", "Archer Av", "Ardcloney Dr", "Ardoch Rd", "Argyle Pl", "Arran Ct", "Ash Ct", "Ashton Ct", "Atkinson Cl", "Atlanta Cl", "Augusta Cl", "Auld Ct", "Austin Ct", "Backhaus Av", "Baggy Green St", "Baker Ri", "Balbethan Dr", "Balliol Cmn", "Balmoral Cct", "Baltusrol Cl", "Banksia Ct", "Bannermann St", "Bannon Av", "Baradine Ct", "Barkly St", "Barnes Pl", "Barrington La", "Barton St", "Bass Ct", "Bates Ct", "Batman Av", "Bell Ct", "Belleview Dr", "Benaud Pl", "Bennett Ct", "Berrydale Rd", "Betula Tce", "Birchwood Pl", "Birkdale Ct", "Bishops Gtes", "Blackie La", "Blackman Cl", "Blackwood Pl", "Blaxland Dr", "Blind Creek Bvd", "Blue Wren Pl", "Bluebush Ct", "Bluegum Wy", "Blyton Cr", "Bolt Pl", "Bonnor St", "Bonny Brae Ct", "Boon Ct", "Border Bvd", "Bowen Ct", "Bowerbird Pl", "Boxwood Ct", "Boyd Ct", "Brack Ct", "Bradman Dr", "Braemar Ct", "Branigan Ct", "Brett Ct", "Briarwood Ct", "Brierly Ct", "Brook St", "Bruce Ct", "Buckland Wy", "Buckmaster St", "Bundanoon Av", "Bundoran Ct", "Burge Dr", "Burke Rd", "Bush Pl", "Buvelot Pl", "Buxton Pl", "Cadell Ct", "Cain St", "Caithness Cl", "Caitlyn St", "Calder Fwy", "Callander Cl", "Canterbury Av", "Carara Ct", "Carey Ct", "Carla Vw", "Carlson St", "Carnarvon Ct", "Carnoustie Dr", "Casey Av", "Casuarina Ct", "Cathrin Cl", "Cawl Ct", "Chappell Ct", "Charles St", "Charter Rd East", "Charter Rd West", "Cherry Hill Ct", "Chestnut Wy", "Chicola Cl", "Chifley Ct", "Churchill Pl", "Circular Dr", "Citriodora Cct", "City Vw", "Claret Ash Dr", "Clark Ct", "Clyde Ct", "Clydesdale Wy", "Coates Ct", "Cobaw Cr", "Cobblestone La", "College Pl", "Collins St", "Commerce Ct", "Condor Pl", "Cook Ct", "Coppelius Cl", "Cornish St", "Correa Wy", "Cotter Pl", "Counihan St", "Counsel Ct", "Cover Dr", "Cowper Cr", "Crawford Wy", "Crosbie Ct", "Cumberland Ch", "Cuming Pl", "Curtin Dr", "Curtis Av", "Cypress Point Ct", "Dadswell Ct", "Dalkeith Ct", "Dalrymple Rd", "Daly Cl", "Darbyshire St", "Dargie Ct", "Darling Ct", "Darryn Ct", "Darwin City St", "Davenport Dr", "Davies Ct", "Dawn Ct", "De Lisle Av", "Deakin St", "Denison Ct", "Denman Ct", "Deverall Rd", "Devon Park Cl", "Dobell Av", "Doig Pl", "Dolan Ct", "Donelly Cl", "Dornoch Dr", "Doutney Ct", "Dowling Ct", "Drysdale St", "Duncraig Gr", "Dundas Av", "Dunrossil Dr", "Durack Ct", "Dyson Dr", "Eadie St", "Earlington Cr", "Elizabeth Dr", "Emma Ct", "Emu Rd", "Enterprise Dr", "Ervine Cl", "Eton Cl", "Evans St", "Eyre St", "Fadden Gr", "Fairbairn Gr", "Fawcett Pl", "Fawkner St", "Felton Av", "Fenchurch St", "Fenton Hill Pde", "Fernshaw Pl", "Ferris St", "Finch La", "Fingleton Cr", "Firestone Ct", "Fisher Ct", "Fitzroy St", "Flamingo Pde", "Flinders St", "Florence La", "Fluke Mw", "Forde Ct", "Forrest St", "Forster Ct", "Fox Ct", "Fox Hollow Dr", "Francis Bvd", "Fraser Ct", "Free Pl", "Fremantle Rd", "Frontignac Ct", "Fulham Wy", "Fullbrook Dr", "Fuller Ct", "Fullwood Dr", "Gabbo Ct", "Galaxy Wy", "Ganton Ct", "Gap Rd", "Gellies Rd", "Gibbons St", "Gibson Ct", "Giffen Pl", "Gilchrist Cr", "Gill Pl", "Glenauburn Ct", "Gleneagles Dr", "Golf Links Dr", "Gordon St", "Gorton Ct", "Gosse Ct", "Gowrie Ct", "Grand Ridge Wy", "Grapeview Close", "Grapeview Grove", "Greenhill Ct", "Gregory Ct", "Grenache Ct", "Grey Ct", "Grout Cct", "Gruner St", "Gullane Dr", "Gurners La", "Hadlow Ct", "Haines Ct", "Hammersmith Ct", "Harbison La", "Harcombe Dr", "Harcourt Cl", "Harker St", "Harrow Ct", "Harvard Ct", "Hasluck Ct", "Hatfield Ct", "Hawke Pl", "Haxton Ct", "Healy Av", "Heatherbrae Cr", "Henty Ct", "Herbert Cr", "Heysen Dr", "Higgins Av", "Higgs Cct", "Highdale Cl", "Highgrove Dr", "Highlands Ct", "Hill Gr", "Hilltop Ct", "Hirst Ct", "Hobson Ct", "Hogan St", "Holcombe Dr", "Holloway Cl", "Holt St", "Homestead Wy", "Hood Cr", "Hopbush Av", "Horan Pl", "Horne St", "Hotham Ct", "Hoylake Ct", "Hughes Ct", "Hume St", "Ironbark Dr", "Isaacs Cl", "Isabella St", "Jackson St", "James Cl", "Jardine Cr", "Jelimar Ct", "John St", "June St", "Juniper La", "Karinya Ct", "Kathryn Ct", "Kavel Ct", "Keeper St", "Keith Av", "Kelbourne Gr", "Kelly St", "Kemp Pl", "Kendall Ct", "Kenway St", "Kereford Pl", "Kerri Ct", "Kerrisdale Pl", "Keswick Ri", "Kingsley Dr", "Kintore Cl", "Kippax St", "Kismet Rd", "Knightsbridge St", "Knox Ct", "Kookaburra Cl", "Koriella Dr", "La Perouse Cl", "Lachlan Ct", "Lakes Dr", "Lalor Cr", "Lambert Av", "Lancefield Rd", "Melbourne Lancefield Rd", "Landsborough Dr", "Landscape Pl", "Lark Ct", "Lassiter St", "Latrobe Ct", "Laureate Cl", "Laurel Ct", "Lauriston Wy", "Lawrence Av", "Lawson St", "Learmonth St", "Leichardt St", "Leith Ct", "Lewin St", "Ligar St", "Light Ct", "Lightwood Dr", "Lindrick Ct", "Lindsay Av", "Lindwall St", "Liquidamber Wy", "Lister Cr", "Lock Ct", "Logan Ct", "Long Dr", "Longmire Ct", "Longstaff Wy", "Lonsdale Pl", "Lorikeet La", "Louis Wy", "Luana La", "Lynn Ct", "Lyons Ct", "Lytham Ct", "Macdonald Pl", "Macedon St", "Magdalene Ct", "Maguire Dr", "Maiden St", "Malbec Ct", "Mallee Ct", "Manfred Ct", "Manna Gum Cl", "Manning Ct", "Manolive Ct", "Manrico Ct", "Marjorie Av", "Marsh Cr", "Marshall Cl", "Martens Ct", "Marylebone St", "Massie Cct", "Mawson Ct", "May Gr", "Mayfin Ct", "McCabe Cr", "McComb St", "McCosker St", "McCubbin Ct", "McDougall Rd", "McEwen Dr", "McGeorge Ct", "McGill Ct", "McInnes Cl", "McKell Av", "McLean Ct", "McMahon Ct", "Medinah Cl", "Melba Av", "Meldrum Ct", "Mellon Ct", "Menzies Dr", "Mere Ct", "Merion Ct", "Merlot Gr", "Merton Cl", "Milan Ct", "Milgate Tce", "Miller St", "Mitchells La", "Molvig Ri", "Monterey Ct", "Moore Rd", "Morris Ct", "Mounsey Ct", "Mount Dr", "Mountain Ash Dr", "Mowbray Ct", "Mudie Av", "Muirfield Dr", "Munch Pl", "Mundy Rd", "Mundy Rd", "Murdoch Ct", "Muscat Ct", "Nambour Dr", "Narani Ct", "Neill St", "Nichol St", "Nimo Ct", "Noble Wy", "Nolan Ct", "Norfolk Gr", "Norling Mw", "Norman Av", "Notre Dame Dr", "Nottinghill Ri", "O'brien St", "Oakdale La", "Oakmont Ct", "Obeid Dr", "Ochre Pl", "Officer Ct", "Old Riddell Rd", "Old Vineyard Rd", "Old Winery Rd", "Oldbury Av", "Olive Gr", "Olson Pl", "Omalley Ct", "Oneill Pl", "Orchardview Gr", "Oreilly Ct", "Oshanassy St", "Oswin Ct", "Outlook Wy", "Ovens Ct", "Owl Pl", "Oxford Cl", "Oxley St", "Pads Wy", "Page Pl", "Palmers Rd", "Palomino Dr", "Panoramic Pl", "Paperbark Av", "Parade Ct", "Park La", "Parkes Ct", "Parklea Ct", "Parkview Dr", "Pasley St", "Pebble Beach Ct", "Peggy St", "Penina Ct", "Peppercorn La", "Perceval St", "Peterhouse Ct", "Peters Rd", "Phillip Dr", "Pidgeon Ct", "Pinot Ct", "Pinto Wy", "Pioneer Rd", "Piping La", "Plante Ct", "Platypus Ct", "Pollard Pl", "Ponsford Pl", "Portmarnock Ct", "Portree Ct", "Possum Tail Run", "Powlett St", "Prendergast Rd", "Preston St", "Priorswood Wy", "Prospect Ct", "Protea Ct", "Pugh Ct", "Racecourse Rd", "Raes Rd", "Rainbow Ct", "Raine Ct", "Ramsay Ct", "Ranleigh Ri", "Red Robin La", "Reddan Ct", "Redpath Ct", "Redstone Hill Rd", "Rees Rd", "Regent St", "Reghon Dr", "Reiffel Av", "Reservoir Rd", "Rice Ct", "Richardson Av", "Riddell Rd", "Ridge Wy", "Rigby Ct", "Ritchie Ct", "Rivergum Pl", "Riverview Tce", "Roberts Ct", "Robina La", "Rogers Ct", "Rolling Meadows Dr", "Ronald Ct", "Rosapenna Cl", "Roseberry Av", "Ross Ct", "Rover St", "Rubicon Ct", "Rupertsdale Rd", "Ruthven St", "Ruyton Ct", "Ryder St", "Salesian Ct", "Saltash Ct", "Sambell Rd", "Sandleford Ct", "Sandpiper Gr", "Sassafras Dr", "Sauvignon Ct", "Saxonwood Dr", "Saxonwood La", "Schoolhouse La", "Scotch Ct", "Scott St", "Scullin Ct", "Seagull Pl", "Sebastian Pl", "Semillon Ct", "Settlement Rd", "Settlement Rd West", "Settlers Wy", "Severino Pl", "Shaw Ct", "Shepherds La", "Sherwood Ct", "Shetland Wy", "Shields St", "Shiraz Ct", "Silkyoak Gr", "Simpson Av", "Skye Ct", "Slater Ct", "Slim Ct", "Sloan Ct", "Smith Ct", "Solomon Ct", "Somerset St", "Sorbonne Dr", "Spavin Dr", "Spyglass Ct", "St Andrews Ct", "St Mellion Cl", "St Ronans Ct", "Stackpole Cr", "Stanford Ct", "Starflower Wy", "Starkie Rd", "Station St", "Stawell St", "Stewarts La", "Stockfeld St", "Stockwell Dr", "Stonehaven Cl", "Strachen Ct", "Stratford Cl", "Strathearn Dr", "Streeton Ct", "Stringer Ct", "Sturt St", "Sugar Gum Wy", "Sullivan Rd", "Sullivans Rd", "Sun View Ct", "Sunbrook Ct", "Sunbury Rd", "Sunish Ct", "Sunningdale Av", "Sussex Ct", "Sweep Ct", "Swift St", "Swift Parrot Cl", "Syme Ct", "Tabor Ct", "Talbot Pl", "Tanner Pl", "Tarrango Ct", "Tasman Ct", "Teal Ct", "Tennyson Ct", "Terence St", "The Avenue", "The Barb", "The Cotswolds", "The Glade", "The Granary", "The Heights", "The Hermitage", "The Link", "The Oaks", "The Old Stock Run", "The Parkway", "The Rise", "The Skyline", "The Strand", "The Trump Cl", "The Village Grn", "Thornton Av", "Timbertop Rd", "Timins St", "Timms Ct", "Torres Ct", "Tower Ct", "Towerbridge Ri", "Tracie Ct", "Track/trail", "Traminer Ct", "Tree Violet Ct", "Treefern Dr", "Trinity Ct", "Troon Ct", "Trott St", "Trumper Cr", "Tulsa Dr", "Turnberry Dr", "Turner Ct", "Twin Creek Ct", "Underhill Ct", "Valley View Cr", "Valley View Wy", "Vaughan St", "Verdelho Ct", "Viaduct Wy", "View Tce", "Vineyard Rd", "Vineyard Rd", "Wagtail Pl", "Wainwright Ct", "Walker Ct", "Wallaby Wk", "Waller Ct", "Walton Heath Ct", "Watersprite Bvd", "Watreloo Ri", "Watsons Rd", "Wattle Dr", "Waugh St", "Webb Ct", "Wellington Mw", "Wentworth Ct", "Wesley Ct", "Westall Cl", "Westminster Gr", "Westward Ho Dr", "Wheeler Ct", "Whitechapel Wy", "Whitty La", "Wicket St", "Wileman Rd", "Williams Ri", "Williamsons Rd", "Wills St", "Wilsons La", "Windarra Ct", "Windsor Ri", "Winged Foot Ct", "Winilba Rd", "Wirilda Ct", "Withers Cl", "Woodfield Pl", "Woodstock Cl", "Wright Ct", "Xavier Ct", "Yale Ct", "Yallop Cr", "Yarck Ct", "Yardley St", "Yellow Gum Bvd", "Yellow Wood Cl", "York Pl"],
    
        //BULLA:
        ["Access Rd", "Batey Ct", "Blackwells La", "Bourke St", "Cahill St", "Cemetery Rd", "Coghill St", "Coopers Rd", "Creasey Ct", "Glenara Dr", "Loemans Rd", "Oaklands Rd", "Quartz St", "Rawdon St", "School La", "Sharp St", "Somerton Rd", "Green St", "St Johns Rd", "Bulla Rd", "Trap St", "Uniting La"],
    
        //WILD-WOOD:
        ["Emu Creek Rd", "Emu Flats Rd", "Feehans Rd", "Gellies Rd", "Kanga Wy", "Southern Plains Rd", "Konagaderra Rd", "Wildwood Rd", "North Wildwood Rd", "South Wildwood Rd"],
        
        //DIGGERS-REST:
        ["Buckley Rd", "Bulla Diggers Rest Rd", "Cairns Pl", "Calder Fwy", "Calder Hwy", "Carl Pl", "Coimadai Rd", "Diggers Rest Coimadai Rd", "Colour Rd", "Cradle Rd", "Crinnion Rd", "Davis Rd", "Dillon Ct", "Duncans La", "Dundas St", "Edwards Rd", "Eureka Rd", "Flake Ct", "Gap Rd", "Gap Rd", "Glencoe Dr", "North Glitter Rd", "South Glitter Rd", "Hamilton St", "Holden Rd", "Houdini Dr", "Ingot Rd", "Lance Rd", "License Rd", "Lode Ct", "Maninga Park Ct", "Mark Ct", "McCleods Rd", "Miners Ct", "Morefield Ct", "Mt Aitken Rd", "Mullock Rd", "Napier St", "Old Vineyard Rd", "Pepper Ct", "Peppercorn Ct", "Plumpton Rd", "Precious Rd", "Punjel Dr", "Raglan St", "Regent St", "Romeo Ct", "School La", "Screen Rd", "Search Rd", "Shoring Rd", "Stake Rd", "Tame St", "Teppo Ct", "Thompsons Rd", "Townsings Rd", "Vineyard Rd", "Vineyard Rd", "Watsons Rd", "Welcome Rd", "Winch Rd"]
    ]
    
    
    //UI Object references:
    @IBOutlet weak var sizeSelector: UISegmentedControl!
    @IBOutlet weak var newItemLabel: UILabel!
    @IBOutlet weak var orderList: UITableView!
    @IBOutlet weak var menuList: UICollectionView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameNumLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var deliverySwitch: UISwitch!
    @IBOutlet weak var numOfItems: UILabel!
    @IBOutlet weak var priceTotal: UILabel!
    @IBOutlet weak var addressList: UITableView!
    @IBOutlet weak var halfhalfButton: UIButton!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var placeOrderButton: UIButton!
    
    
    //MY PROTOCOLS:
    func removeItem(_ index: Int) {
        app.removeFood(index)
        orderList.reloadData()
        numOfItems.text! = "\(app.order.foods.count)"
        //priceTotal.text! = "\(priceFormatter.string(from: NSNumber(app.order.priceTotal))!)"
        if(app.order.foods.count == 0) {app.useIndex = false}
    }
    func addMenuItem(_ index: Int, sender: AnyObject) {
        //Which button got pushed?:
        switch index {
        case 1...17, 35: //Pizza
            //Turn on selecter on, get it's size:
            sizeSelector.isEnabled = true
            let newSize = Size(rawValue: Size.sizeFromIndex[sizeSelector.selectedSegmentIndex])!
            app.newFood.size = newSize
            //Handles half-half pizzas, set new food:
            if(app.newFood.halfhalf) {app.newFood.item2 = MenuItems(rawValue: index)!}
            else {app.newFood.item = MenuItems(rawValue: index)!}
            if(newSize == .Small) {halfhalfButton.isEnabled = false}
            else {halfhalfButton.isEnabled = true}
            
            app.newFood.foodNotes = nil
        case 28...30:
            //Turns off selecter, sets size nil:
            sizeSelector.isEnabled = false
            app.newFood.size = nil
            //Handles half-half pizzas:
            if(app.newFood.halfhalf) {
                app.newFood.item2 = nil
                app.newFood.halfhalf = false
            }
            //Sets new food item:
            halfhalfButton.isEnabled = false
            app.newFood.item = MenuItems(rawValue: index)!
            
            //Display drink selection options:
            if let popoverController = drinkSelector.popoverPresentationController {
                popoverController.sourceView = sender as? UIView
                popoverController.sourceRect = sender.bounds
                self.present(drinkSelector, animated: false, completion: nil)
            }
            
        case 18...27, 32...34: //Pasta/chicken
            //Turns off selecter, sets size nil:
            sizeSelector.isEnabled = false
            app.newFood.size = nil
            //Handles half-half pizzas:
            if(app.newFood.halfhalf) {
                app.newFood.item2 = nil
                app.newFood.halfhalf = false
            }
            //Sets new food item:
            app.newFood.item = MenuItems(rawValue: index)!
            halfhalfButton.isEnabled = false
            app.newFood.foodNotes = nil
        case 31: //Gelati
            //Turns selecter on, get it's size:
            sizeSelector.isEnabled = true
            //app.newFood.size = app.sizeFromIndex(sizeSelector.selectedSegmentIndex)
            app.newFood.size = Size(rawValue: Size.sizeFromIndex[sizeSelector.selectedSegmentIndex])
            //Handles half-half pizzas:
            if(app.newFood.halfhalf) {
                app.newFood.item2 = nil
                app.newFood.halfhalf = false
            }
            //Sets new food item:
            app.newFood.item = MenuItems(rawValue: index)!
            halfhalfButton.isEnabled = false
            app.newFood.foodNotes = nil
        default: print("add menu item error")
        }
        //Updates label for the new food item:
        newItemLabel.text! = app.newFood.asString()
        
    }
    
    //Delivey switch:
    @IBAction func switchToDelivery(_ sender: AnyObject) {
        if(deliverySwitch.isOn) {
            nameNumLabel.text! = "Address:"
            nameTextField.placeholder! = "Address"
            app.order.delivery = true
            if(phoneTextField.text! == "") {allowPrint[1] = false}
            if(arrayAddressText.count > 1) {
                addressList.isHidden = false
                indexes = searchAddress(arrayAddressText[arrayAddressText.count - 1])
                addressList.reloadData()
            }
            
        } else {
            nameNumLabel.text! = "Name:"
            nameTextField.placeholder! = "Name / number"
            app.order.delivery = false
            allowPrint[1] = true
            addressList.isHidden = true
        }
        app.order.calcOrderPrice()
        //priceTotal.text! = "\(priceFormatter.string(from: NSNumber(app.order.priceTotal))!)"
        
    }
    
    //When editting text fields begin:
    @IBAction func nameTextEdit(_ sender: AnyObject) {allowPrint[0] = true}
    @IBAction func phoneTextEdit(_ sender: AnyObject) {allowPrint[1] = true}
    
    //Adds an item to the current order:
    @IBAction func onAddClick(_ sender: AnyObject) {
        app.updateOrder()
        numOfItems.text! = "\(app.order.foods.count)"
        //priceTotal.text! = "\(priceFormatter.string(from: NSNumber(app.order.priceTotal))!)"
        orderList.reloadData()
    }
    
    //Update when different size is selected:
    @IBAction func sizeChanged(_ sender: AnyObject) {
        let newSize = Size(rawValue: Size.sizeFromIndex[sizeSelector.selectedSegmentIndex])
        app.newFood.size = newSize
        
        if(newSize == .Small) {
            halfhalfButton.isEnabled = false
            if(app.newFood.halfhalf) {
                app.newFood.ingredients2 = nil
                app.newFood.halfhalf = false
            }
        } else {
            if(app.newFood.item == .gelati) {halfhalfButton.isEnabled = false}
            else {halfhalfButton.isEnabled = true}
        }
        newItemLabel.text! = app.newFood.asString()
    }
    
    //Finalises new order:
    @IBAction func makeOrder(_ sender: AnyObject) {
        if(app.order.foods.count == 0 || allowPrint != [true, true]) {
            self.present(errorMessage, animated: true, completion: nil)
        } else {
            if(app.order.delivery) {app.order.phoneNumber = phoneTextField.text!}
            else {app.order.phoneNumber = nil}
            if(phoneTextField.text! != "") {app.order.phoneNumber = phoneTextField.text!}
            if(app.editingOrder == nil) {app.orderList.append(app.order)}
            else {app.orderList[app.editingOrder!] = app.order}
            
            app.makeOrder(nameTextField.text!)
            pageReset()
        }
    }
    
    //When return on keyboard is pressed, hide it:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addressList.isHidden = true
        return true
    }
    //Hides address list if keyboard is put away (not return):
    func textFieldDidEndEditing(_ textField: UITextField) {addressList.isHidden = true}
    
    //When text is added to the address/name field:
    @IBAction func textFieldChanged(_ sender: AnyObject) {
        arrayAddressText = nameTextField.text!.split{$0 == " "}.map(String.init)
        if(deliverySwitch.isOn && arrayAddressText.count > 1) {
            addressList.isHidden = false
            indexes = searchAddress(arrayAddressText[arrayAddressText.count - 1])
            addressList.reloadData()
        }
        if(arrayAddressText.count == 1) {addressList.isHidden = true}
    }
    
    //Half-half button is pushed:
    @IBAction func halfHalfButton(_ sender: AnyObject) {newItemLabel.text! = app.halfHalfFood()}
    
    //Clear/cancel button is pushed:
    @IBAction func clearCancel(_ sender: AnyObject) {self.present(cancelMessage, animated: true, completion: nil)}
    
    //CollectionView FUNCTIONS:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return 35}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuList.dequeueReusableCell(withReuseIdentifier: "menuItem", for: indexPath) as! myMenuCell
        
        cell.index = (indexPath as NSIndexPath).row + 1
        cell.delegate = self
        cell.button.setTitle("\(cell.index)", for: UIControl.State())
        cell.itemLabel.text! = MenuItems.itemString[cell.index]
        
        switch cell.index {
        case 1...17, 28...30: break //do nothing
        case 18...25, 33...35: cell.button.setTitleColor(UIColor.orange, for: UIControl.State())
        case 26...27: cell.button.setTitleColor(UIColor.red, for: UIControl.State())
        case 31...32: cell.button.setTitleColor(UIColor.green, for: UIControl.State())
        default: print("menu item menu error")
        }
        return cell
    }
    
    //TableView FUNCTIONS:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == orderList) {
            //Orderlist TableView:
            let cell = orderList.dequeueReusableCell(withIdentifier: "pizzaItem") as! myCell
            
            cell.index = (indexPath as NSIndexPath).row
            cell.delegate = self
            //cell.priceLabel.text! = "\(priceFormatter.string(from: NSNumber(app.order.foods[(indexPath as NSIndexPath).row].price))!)"
            cell.pizzaLabel.text! = app.order.foods[(indexPath as NSIndexPath).row].asString()
            cell.indexLabel.text! = "\(cell.index + 1)."
            if(app.order.foods[(indexPath as NSIndexPath).row].item.rawValue < 18) {
                cell.pizzaDesc.text! = app.order.foods[(indexPath as NSIndexPath).row].desc()
            } else {cell.pizzaDesc.text! = ""}
            return cell
            
        //Address TableView:
        } else {
            let cell = addressList.dequeueReusableCell(withIdentifier: "addressItem") as! addressListCell
            var text = ""
            //for(var i = 0; i < arrayAddressText.count - 1; ++i) {}
            for i in 0 ..< arrayAddressText.count - 1 {
                text += arrayAddressText[i] + " "
            }
            
            cell.addressLabel.text! = text + indexes[(indexPath as NSIndexPath).row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == orderList) {return app.order.foods.count}
        else {return indexes.count}
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == orderList) {
            app.useIndex = true
            app.indexPath = indexPath
            tabBarController?.selectedIndex = 1
        } else {
            var text = ""
            for t in arrayAddressText {if(t != arrayAddressText[arrayAddressText.count - 1]) {text += t + " "}}
            text += indexes[(indexPath as NSIndexPath).row]
            nameTextField.text! = text
        }
    }
    
    //Searches thru address array based on string, returns found index numbers:
    func searchAddress(_ searchFor: String) -> [String]{
        let max = searchFor.count
        let place = ["", " (Bulla)", " (Wildwood)", " (Diggers)"]
        var foundIndexArray = [[Int](), [Int](), [Int](), [Int]()]
        var index = 0
        var x = 0
        var stringArray = [String]()
        
        for array in addressesArrays {
                index = 0
                for addresses in array {
                    if(max <= addresses.count) {
                        let tempArray = Array(addresses)
                        var newString = ""
                        //for(var i = 0; i < max; ++i) {newString += "\(tempArray[i])"}
                        for i in 0 ..< max {newString += "\(tempArray[i])"}
                        if(newString.caseInsensitiveCompare(searchFor) == ComparisonResult.orderedSame) {foundIndexArray[x].append(index)}
                }
                index += 1
            }
            x += 1
        }
        
        //for(x = 0; x < foundIndexArray.count; ++x) {
        for x in 0 ..< foundIndexArray.count {
            for i in foundIndexArray[x] {stringArray.append((addressesArrays[x])[i] + place[x])}
        }
        return stringArray
    }
    
    //Resets order page UI:
    func pageReset() {
        deliverySwitch.isOn = false
        nameNumLabel.text! = "Name:"
        nameTextField.placeholder! = "Name / number"
        nameTextField.text! = ""
        phoneTextField.text! = ""
        numOfItems.text! = "0"
        priceTotal.text! = "$0.00"
        allowPrint = [false, true]
        orderNumberLabel.text! = "[\(self.app.order.orderNumber)]"
        app.editingOrder = nil
        orderList.reloadData()
    }
    
    //CONTROLLER:
    override func viewDidAppear(_ animated: Bool) {
        app.useIndex = false
        //Did we load an old order?:
        if(app.editingOrder != nil) {
            nameTextField.text! = app.order.name
            if(app.order.delivery) {deliverySwitch.isOn = true}
            else {deliverySwitch.isOn = false}
            if(app.order.phoneNumber != nil) {phoneTextField.text! = app.order.phoneNumber!}
            else {phoneTextField.text! = ""}
            allowPrint = [true, true]
        }
        //Update UI:
        app.order.calcOrderPrice()
        //priceTotal.text! = "\(priceFormatter.string(from: NSNumber(app.order.priceTotal))!)"
        orderNumberLabel.text! = "[\(app.order.orderNumber)]"
        orderList.reloadData()
        
    }
    override func viewDidLoad() {
        priceFormatter.numberStyle = .currency
        orderList.layer.cornerRadius = 25
        orderList.clipsToBounds = true
        addressList.layer.cornerRadius = 30
        addressList.clipsToBounds = true
        menuList.layer.cornerRadius = 10
        menuList.clipsToBounds = true
        deliverySwitch.layer.cornerRadius = 15
        deliverySwitch.clipsToBounds = true
        placeOrderButton.layer.cornerRadius = 18
        placeOrderButton.clipsToBounds = true
        
        //Setup for Drink Selector:
        drinkSelector.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        for d in drinks {
            drinkSelector.addAction(UIAlertAction(title: d, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.app.newFood.foodNotes = d
                self.newItemLabel.text! = self.app.newFood.asString()
            }))
        }
        //Setup Error Message:
        errorMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //Setup Cancel Message:
        cancelMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.app.resetOrder()
            self.pageReset()
        }))
        
        cancelMessage.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
    }
    override func didReceiveMemoryWarning() {app.saveOrders()}
}//END OF FILE
