//  Order.swift
//  SpeedOrder
//  Created by Jack on 26/01/2016.
//  Copyright © 2016 Jack. All rights reserved.

//List of menu items:
enum MenuItems: Int {
    //Pizzas:
    case capricciosa = 1; case americana = 2; case margerita = 3
    case nedKelly = 4; case napoletana = 5; case hawaiian = 6
    case marinara = 7; case vegetarian = 8; case mexican = 9
    case aussie = 10; case peperoni = 11; case goonawarraSpecial = 12
    case chicken = 13; case meatLovers = 14; case johnySpecial = 15
    case mushroom = 16; case rjSpecial = 17
    //Pastas:
    case lasagna = 18; case spagBolognese = 19; case spagMarinara = 20
    case fettuccineCarb = 21; case ravioli = 22; case tortelloni = 23
    case gnocchi = 24; case vege_Pasta = 25
    //Other:
    case chickSchnit = 26; case chickParma = 27; case can = 28
    case med = 29; case large = 30; case gelati = 31
    case salad = 32; case chips = 33; case gb = 34; case gPizza = 35
    
    //Array:
    static let itemString = ["ERROR", "Capricciosa", "Americana",
        "Margerita", "Ned Kelly", "Napoletana", "Hawaiian", "Marinara",
        "Vegetarian", "Mexican", "Aussie", "Peperoni", "Goonawarra Special",
        "Chicken", "Meat Lovers", "Johny Special", "Mushroom", "RJ Special",
        "Lasagna", "Bolognese (Spag. only)", "Marinara (Spag. only)",
        "Fettuccine Carbonara", "Ravioli Bolognese", "Tortelloni Bolognese",
        "Gnocchi Bolognese", "Vegetarian Pasta", "Chicken Schnitzel",
        "Chicken Parma", "Can", "1.25L", "2L", "Gelati", "Salad", "Chips", "G/B", "Garlic Pizza"]
}

//List of pizza extras:
enum Ingredients: Int {
    //Extra ingredients:
    case tomatoSauce = 1; case bbqSauce = 2; case ham = 3
    case cheese = 4; case mushroom = 5; case onion = 6
    case capsicum = 7; case pineapple = 8; case bacon = 9
    case olive = 10; case kOlive = 11; case salami = 12
    case chicken = 13; case beef = 14; case prawn = 15
    case garlic = 16; case anchovie = 17; case oregano = 18
    case chilli = 19; case egg = 20; case clams = 21
    case gf = 22; case bbqBase = 23; case thinBase = 24
    //case UNKNOWNONE = 25; case UNKNOWNTWO = 26
    
    //Array of stings of each extra:
    static let extraString = ["ERROR", "Tomato sauce", "BBQ sauce", "Ham",
        "Cheese", "Mushroom", "Onion", "Capsicum", "Pineapple", "Bacon",
        "Olives", "Kalamata Olives", "Salami", "Chicken", "Beef", "Prawns",
        "Garlic", "Anchovies", "Oregano", "Chilli", "Egg", "Baby clams",
        "Gluten Free", "BBQ Base", "Thin Base", "", "[Clear]", "[-]", "[###]"]
    
    static let recipe = [
        //ERROR:
        [.tomatoSauce],
        //1 - Capricciosa:
        [.tomatoSauce, .cheese, .ham, .mushroom, .olive, .anchovie],
        //2 - Americana:
        [.tomatoSauce, .cheese, .ham, .salami, .onion],
        //3 - Margerita:
        [.tomatoSauce, .cheese, .oregano],
        //4 - Ned Kelly:
        [.tomatoSauce, .cheese, .ham, .beef, .onion],
        //5 - Napoletana:
        [.tomatoSauce, .cheese, .anchovie, .garlic],
        //6 - Hawaiin:
        [.tomatoSauce, .cheese, .ham, .pineapple],
        //7 - Marinara:
        [.tomatoSauce, .cheese, .clams, .prawn, .garlic],
        //8 - Vegetarian:
        [.tomatoSauce, .cheese, .mushroom, .onion, .capsicum, .olive],
        //9 - Mexican:
        [.tomatoSauce, .cheese, .ham, .capsicum, .salami, .olive],
        //10 - Aussie:
        [.tomatoSauce, .cheese, .ham, .bacon, .egg, .onion],
        //11 - Peperoni:
        [.tomatoSauce, .cheese, .salami, .chilli],
        //12 - Goonawarra Special:
        [.tomatoSauce, .cheese, .ham, .mushroom, .onion, .capsicum, .salami, .olive, .pineapple],
        //13 - Chicken:
        [.tomatoSauce, .cheese, .ham, .chicken, .mushroom],
        //14 - Meat Lovers:
        [.tomatoSauce, .cheese, .ham, .bacon, .beef, .salami],
        //15 - Johny's Special:
        [.tomatoSauce, .cheese, .ham, .mushroom, .onion, .salami, .prawn, .olive, .garlic],
        //16 - Mushroom Pizza:
        [.tomatoSauce, .cheese, .mushroom],
        //17 - RJ Special:
        [.tomatoSauce, .cheese, .beef, .salami, .bacon, .chicken, .bbqSauce],
        //Pastas:
        [.tomatoSauce, .cheese],
        [.tomatoSauce],
        [.prawn, .garlic],
        [.mushroom, .bacon, .garlic, .oregano],
        [.tomatoSauce],
        [.tomatoSauce],
        [.tomatoSauce],
        [.tomatoSauce, .mushroom, .onion, .capsicum],
        //Chicken items:
        [.tomatoSauce],
        [tomatoSauce, .cheese]
    ]
}

//List of item sizes:
enum Size: String {
    case Small = "S"
    case Large = "L"
    case Family = "F"
    case Other = ""
    
    static let sizeFromIndex = ["S", "L", "F", ""]
}

//Structure for extras/ingredients:
class Extra: NSObject, NSCoding {
    var minus = false
    var extra: Ingredients = .bbqSauce
    
    //Initializer:
    init(extra: Ingredients, minus: Bool) {
        self.minus = minus
        self.extra = extra
    }
    required init(coder aDecoder: NSCoder) {
        minus = aDecoder.decodeObject(forKey: "minus") as! Bool
        extra = Ingredients(rawValue: aDecoder.decodeObject(forKey: "extra") as! Int)!
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(minus, forKey: "minus")
        aCoder.encode(extra.rawValue, forKey: "extra")
    }
    
    
}
//Structure for each food item in an order:
class Food: NSObject, NSCoding {
    var price: Double = 0
    var size: Size? = .Small
    var item: MenuItems = .capricciosa
    var item2: MenuItems? = nil
    var foodNotes: String? = nil
    var foodNotes2: String? = nil
    var halfhalf = false
    var ingredients = [Extra]()
    var ingredients2: [Extra]? = nil
    
    override init() {}
    required init(coder aDecoder: NSCoder) {
        if(aDecoder.decodeObject(forKey: "size") as? String == nil) {size = nil}
        else {size = Size(rawValue: aDecoder.decodeObject(forKey: "size") as! String)}
        if(aDecoder.decodeObject(forKey: "item2") as? Int == nil) {item2 = nil}
        else {item2 = MenuItems(rawValue: (aDecoder.decodeObject(forKey: "item2") as? Int)!)}
        price = aDecoder.decodeDouble(forKey: "price")
        item = MenuItems(rawValue: (aDecoder.decodeObject(forKey: "item") as! Int))!
        foodNotes = aDecoder.decodeObject(forKey: "foodNotes") as? String
        foodNotes2 = aDecoder.decodeObject(forKey: "foodNotes2") as? String
        halfhalf = aDecoder.decodeObject(forKey: "halfhalf") as! Bool
        ingredients = aDecoder.decodeObject(forKey: "ingredients") as! [Extra]
        ingredients2 = aDecoder.decodeObject(forKey: "ingredients2") as? [Extra]

    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(price, forKey: "price")
        aCoder.encode(size?.rawValue, forKey: "size")
        aCoder.encode(item.rawValue, forKey: "item")
        aCoder.encode(item2?.rawValue, forKey: "item2")
        aCoder.encode(foodNotes, forKey: "foodNotes")
        aCoder.encode(foodNotes2, forKey: "foodNotes2")
        aCoder.encode(halfhalf, forKey: "halfhalf")
        aCoder.encode(ingredients, forKey: "ingredients")
        aCoder.encode(ingredients2, forKey: "ingredients2")
    }
    func copyWithZone(_ zone: NSZone?) -> AnyObject {
        let newFood = Food()
        newFood.price = self.price
        newFood.size = self.size
        newFood.item = self.item
        newFood.item2 = self.item2
        newFood.foodNotes = self.foodNotes
        newFood.foodNotes2 = self.foodNotes2
        newFood.halfhalf = self.halfhalf
        newFood.ingredients = self.ingredients
        newFood.ingredients2 = self.ingredients2
        return newFood
    }
    
    //Resets all extras for the food item:
    func clearExtras() {
        ingredients = [Extra]()
        if(halfhalf) {ingredients2 = [Extra]()}
        else {ingredients2 = nil}
        calcPrice()
    }
    
    //Add a new extra to the food item:
    func addNewExtra (_ extra: Extra, doingHalf: Bool) {
        var found = false
        var x = 0
        var NO = [Extra]()
        var plus = [Extra]()
        var ordered = [Extra]()
        
        //For second half:
        if(doingHalf) {
            //If second half has extras...
            if(ingredients2 != nil) {
                //Loop thru them...
                for i in ingredients2! {
                    //Check if what we are adding now is in there, and save it:
                    if(extra.extra == i.extra) {
                        found = true
                        break
                    }
                    x += 1
                }
            }
            if(found) {
                ingredients2![x] = extra
            }
            else {ingredients2!.append(extra)}
            
            //Ordering:
            for e in ingredients2! {
                if(e.minus) {NO.append(e)}
                else {plus.append(e)}
            }
            ordered.append(contentsOf: NO)
            ordered.append(contentsOf: plus)
            ingredients2 = ordered
        }
        
        //For single/first half pizza:
        else {
            for i in ingredients {
                //Check if what we are adding now is in there, and save it:
                if(extra.extra == i.extra) {
                    found = true
                    break
                }
                x += 1
            }
            if(found) {ingredients[x] = extra}
            else {ingredients.append(extra)}
            
            //Orders extras, NO @ top:
            for e in ingredients {
                if(e.minus) {NO.append(e)}
                else {plus.append(e)}
            }
            ordered.append(contentsOf: NO)
            ordered.append(contentsOf: plus)
            ingredients = ordered
            
        }
        //Make sure GF pizzas are large
        if(extra.extra == .gf) {size = .Large}
    }
    
    //Prints item desc:
    func desc() -> String {
        var text = MenuItems.itemString[item.rawValue]
        if(halfhalf) {text += "/" + MenuItems.itemString[item2!.rawValue]}
        return text
    }
    
    //Prints extras:
    func extras(_ halfhalf: Bool, asComma: Bool) -> String {
        var text = ""
        //Handles which half to print:
        if(halfhalf) { //Details for second half:
            if(ingredients2 != nil) {
                for e in ingredients2! {
                    var alreadyIn = false
                    if(item2!.rawValue < 28) {
                        for i in Ingredients.recipe[item2!.rawValue] {
                            if(i == e.extra) {
                                alreadyIn = true
                                break
                            }
                        }
                    }
                    //Adds - and + to extras:
                    if(e.minus) {
                        text += " - "
                    } else {
                        if(alreadyIn) {text += "ex "}
                        else {text += " + "}
                    }
                    text += Ingredients.extraString[e.extra.rawValue]
                    if(asComma) {text += ", "}
                    else {text += "\n"}
                }
            }
            //Appends any notes to desc:
            if(foodNotes2 != nil) {text += "##: " + foodNotes2! + "\n"}
            
        } else { //Details for solo pizza:
            for e in ingredients {
                var alreadyIn = false
                if(item.rawValue < 28) {
                    for i in Ingredients.recipe[item.rawValue] {
                        if(i == e.extra) {
                            alreadyIn = true
                            break
                        }
                    }
                }
                
                //Adds - and + to extras:
                if(e.minus) {
                    text += " - "
                } else {
                    if(alreadyIn) {text += "ex "}
                    else {text += " + "}
                }
                text += Ingredients.extraString[e.extra.rawValue]
                if(asComma) {text += ", "}
                else {text += "\n"}
            }
            //Appends any notes to desc:
            if(foodNotes != nil) {text += "##: " + foodNotes! + "\n"}
        }
        
        return text
    }
    
    //Prints nice string of the food item:
    func asString() -> String {
        switch item.rawValue {
        //Pizzas:
        case 1...17:
            
            var sizeOrGF = size!.rawValue
            for i in ingredients {if(i.extra == .gf) {sizeOrGF = "GF"}}
            
            if(halfhalf) {
                for i in ingredients2! {if(i.extra == .gf) {sizeOrGF = "GF"}}
                if(item2! == .gPizza) {
                    return sizeOrGF + "-\(item.rawValue)/Garlic"
                } else {
                    return sizeOrGF + "-\(item.rawValue)/\(item2!.rawValue)"
                }
            }
            else {return sizeOrGF + "-\(item.rawValue)"}
        //Pastas and others:
        case 18...27, 32...34: return MenuItems.itemString[item.rawValue]
        //Drinks
        case 28...30:
            if(foodNotes == nil) {return MenuItems.itemString[item.rawValue]}
            else {return MenuItems.itemString[item.rawValue] + " \(foodNotes!)"}
        //Gelati:
        case 31:
            switch size! {
            case .Small: return MenuItems.itemString[item.rawValue] + " (single)"
            case .Large: return MenuItems.itemString[item.rawValue] + " (double)"
            case .Family: return MenuItems.itemString[item.rawValue] + " (mixed)"
            case .Other: return "gelati text error"
            }
        case 35:
            if(halfhalf) {
                if(item2! == .gPizza) {
                    return size!.rawValue + "-Garlic/Garlic"
                } else {
                    return size!.rawValue + "-Garlic/\(item2!.rawValue)"
                }
            }
            else {
                return size!.rawValue + "-Garlic"
            }
        default: return "asString print error"
        }
    }
    
    //Gets the price off the current food item...
    func calcPrice() {
        //...based on what item it is:
        switch item.rawValue {
        case 1...17:
            switch size! { //Pizza size pricing:
            case .Small: price = 7
            case .Large: price = 9.5
            case .Family: price = 14
            case .Other: print("Size error happened!")
            }
            
            //Adds first half/single pizza extras:
            for e in ingredients {
                if(e.extra == .gf) {
                    price += 2
                }
                else {
                    if(e.minus != true) {
                        switch size! {
                        case .Small: price += 0.8
                        case .Large: price += 1
                        case .Family: price += 1.6
                        case .Other: print("sizie2 error happened!")
                        }
                    }
                }
            }
            //Adds half-half fee and second half extras:
            if(halfhalf) {
                price += 1.5
                for e in ingredients2! {
                    if(e.extra == .gf) {
                        price += 2
                    }
                    else {
                        if(e.minus != true) {
                            switch size! {
                            case .Small: price += 0.8
                            case .Large: price += 1
                            case .Family: price += 1.6
                            case .Other: print("sizie error happened!")
                            }
                        }
                    }
                }
            }
            
        case 18...27:
            switch item.rawValue {
                //Pasta, chicken other pricing:
            case 18...25: price = 9
            case 26...27: price = 13.5
            default: print("this will never happen")
            }
            //Adds first half/single pizza extras:
            for e in ingredients {if(e.minus != true) {price += 1}}
            
        case 28: price = 2.5
        case 29: price = 5
        case 30: price = 6
        //Gelati:
        case 31:
            switch size! {
            case .Small: price = 3
            case .Large: price = 4
            case .Family: price = 6
            case .Other: print("Gelati error happened!")
            }
        //Salad and Chips:
        case 32: price = 5.5
        case 33: price = 5
        case 34: price = 3.5
        //Garlic Pizzas:
        case 35:
            switch size! {
            case .Small: price = 6
            case .Large: price = 8
            case .Family: price = 14
            case .Other: print("Garlic pizza error happened!")
            }
            //Adds first half/single pizza extras:
            for e in ingredients {
                if(e.extra == .gf) {
                    price += 2
                }
                else {
                    if(e.minus != true) {
                        //if(item.rawValue ) {}
                        //ERROR COZ PASTA EXTRA HAVE NO SIZE:E:E:E:E?
                        switch size! {
                        case .Small: price += 0.8
                        case .Large: price += 1
                        case .Family: price += 1.6
                        case .Other: print("sizie2 error happened!")
                        }
                    }
                }
            }
            //Adds half-half fee and second half extras:
            if(halfhalf) {
                price += 1.5
                for e in ingredients2! {
                    if(e.extra == .gf) {
                        price += 2
                    }
                    else {
                        if(e.minus != true) {
                            switch size! {
                            case .Small: price += 0.8
                            case .Large: price += 1
                            case .Family: price += 1.6
                            case .Other: print("sizie error happened!")
                            }
                        }
                    }
                }
            }
        default: print("Item error happened!")
        }
    }
}
//Structure for each order:
class Order: NSObject, NSCoding {
    var orderNumber = 1
    var name = ""
    var timeDate = Date()
    var delivery = false
    var phoneNumber: String? = nil
    
    var priceTotal: Double = 0
    var foods = [Food]()
    
    //Adds new food item to the order:
    func addItem(_ item: Food) {
        priceTotal += item.price
        foods.append(item)
    }
    
    func calcOrderPrice() {
        var total: Double = 0
        if(delivery) {total += 4}
        for f in foods {total += f.price}
        priceTotal = total
    }
    
    override init() {}
    
    required init(coder aDecoder: NSCoder) {
        foods = aDecoder.decodeObject(forKey: "foods") as! [Food]
        orderNumber = aDecoder.decodeObject(forKey: "orderNumber") as! Int
        name = aDecoder.decodeObject(forKey: "name") as! String
        timeDate = aDecoder.decodeObject(forKey: "timeDate") as! Date
        delivery = aDecoder.decodeObject(forKey: "delivery") as! Bool
        phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as! String?
        priceTotal = aDecoder.decodeDouble(forKey: "priceTotal")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(foods, forKey: "foods")
        aCoder.encode(orderNumber, forKey: "orderNumber")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(timeDate, forKey: "timeDate")
        aCoder.encode(delivery, forKey: "delivery")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(priceTotal, forKey: "priceTotal")
    }
    
    
}//END OF FILE
