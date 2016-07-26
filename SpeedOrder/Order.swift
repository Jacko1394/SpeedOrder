//  Order.swift
//  SpeedOrder
//  Created by Jack on 26/01/2016.
//  Copyright © 2016 Jack. All rights reserved.

//List of menu items:
enum MenuItems: Int {
    //Pizzas:
    case Capricciosa = 1; case Americana = 2; case Margerita = 3
    case NedKelly = 4; case Napoletana = 5; case Hawaiian = 6
    case Marinara = 7; case Vegetarian = 8; case Mexican = 9
    case Aussie = 10; case Peperoni = 11; case GoonawarraSpecial = 12
    case Chicken = 13; case MeatLovers = 14; case JohnySpecial = 15
    case Mushroom = 16; case RJSpecial = 17
    //Pastas:
    case Lasagna = 18; case SpagBolognese = 19; case SpagMarinara = 20
    case FettuccineCarb = 21; case Ravioli = 22; case Tortelloni = 23
    case Gnocchi = 24; case Vege_Pasta = 25
    //Other:
    case ChickSchnit = 26; case ChickParma = 27; case Can = 28
    case med = 29; case large = 30; case Gelati = 31
    case Salad = 32; case Chips = 33; case GB = 34; case GPizza = 35
    
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
    case TomatoSauce = 1; case BBQSauce = 2; case Ham = 3
    case Cheese = 4; case Mushroom = 5; case Onion = 6
    case Capsicum = 7; case Pineapple = 8; case Bacon = 9
    case Olive = 10; case KOlive = 11; case Salami = 12
    case Chicken = 13; case Beef = 14; case Prawn = 15
    case Garlic = 16; case Anchovie = 17; case Oregano = 18
    case Chilli = 19; case Egg = 20; case Clams = 21
    case GF = 22; case BBQBase = 23; case ThinBase = 24
    //case UNKNOWNONE = 25; case UNKNOWNTWO = 26
    
    //Array of stings of each extra:
    static let extraString = ["ERROR", "Tomato sauce", "BBQ sauce", "Ham",
        "Cheese", "Mushroom", "Onion", "Capsicum", "Pineapple", "Bacon",
        "Olives", "Kalamata Olives", "Salami", "Chicken", "Beef", "Prawns",
        "Garlic", "Anchovies", "Oregano", "Chilli", "Egg", "Baby clams",
        "Gluten Free", "BBQ Base", "Thin Base", "", "[Clear]", "[-]", "[###]"]
    
    static let recipe = [
        //ERROR:
        [.TomatoSauce],
        //1 - Capricciosa:
        [.TomatoSauce, .Cheese, .Ham, .Mushroom, .Olive, .Anchovie],
        //2 - Americana:
        [.TomatoSauce, .Cheese, .Ham, .Salami, .Onion],
        //3 - Margerita:
        [.TomatoSauce, .Cheese, .Oregano],
        //4 - Ned Kelly:
        [.TomatoSauce, .Cheese, .Ham, .Beef, .Onion],
        //5 - Napoletana:
        [.TomatoSauce, .Cheese, .Anchovie, .Garlic],
        //6 - Hawaiin:
        [.TomatoSauce, .Cheese, .Ham, .Pineapple],
        //7 - Marinara:
        [.TomatoSauce, .Cheese, .Clams, .Prawn, .Garlic],
        //8 - Vegetarian:
        [.TomatoSauce, .Cheese, .Mushroom, .Onion, .Capsicum, .Olive],
        //9 - Mexican:
        [.TomatoSauce, .Cheese, .Ham, .Capsicum, .Salami, .Olive],
        //10 - Aussie:
        [.TomatoSauce, .Cheese, .Ham, .Bacon, .Egg, .Onion],
        //11 - Peperoni:
        [.TomatoSauce, .Cheese, .Salami, .Chilli],
        //12 - Goonawarra Special:
        [.TomatoSauce, .Cheese, .Ham, .Mushroom, .Onion, .Capsicum, .Salami, .Olive, .Pineapple],
        //13 - Chicken:
        [.TomatoSauce, .Cheese, .Ham, .Chicken, .Mushroom],
        //14 - Meat Lovers:
        [.TomatoSauce, .Cheese, .Ham, .Bacon, .Beef, .Salami],
        //15 - Johny's Special:
        [.TomatoSauce, .Cheese, .Ham, .Mushroom, .Onion, .Salami, .Prawn, .Olive, .Garlic],
        //16 - Mushroom Pizza:
        [.TomatoSauce, .Cheese, .Mushroom],
        //17 - RJ Special:
        [.TomatoSauce, .Cheese, .Beef, .Salami, .Bacon, .Chicken, .BBQSauce],
        //Pastas:
        [.TomatoSauce, .Cheese],
        [.TomatoSauce],
        [.Prawn, .Garlic],
        [.Mushroom, .Bacon, .Garlic, .Oregano],
        [.TomatoSauce],
        [.TomatoSauce],
        [.TomatoSauce],
        [.TomatoSauce, .Mushroom, .Onion, .Capsicum],
        //Chicken items:
        [.TomatoSauce],
        [TomatoSauce, .Cheese]
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
    var extra: Ingredients = .BBQSauce
    
    //Initializer:
    init(extra: Ingredients, minus: Bool) {
        self.minus = minus
        self.extra = extra
    }
    required init(coder aDecoder: NSCoder) {
        minus = aDecoder.decodeObjectForKey("minus") as! Bool
        extra = Ingredients(rawValue: aDecoder.decodeObjectForKey("extra") as! Int)!
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(minus, forKey: "minus")
        aCoder.encodeObject(extra.rawValue, forKey: "extra")
    }
    
    
}
//Structure for each food item in an order:
class Food: NSObject, NSCoding {
    var price: Double = 0
    var size: Size? = .Small
    var item: MenuItems = .Capricciosa
    var item2: MenuItems? = nil
    var foodNotes: String? = nil
    var foodNotes2: String? = nil
    var halfhalf = false
    var ingredients = [Extra]()
    var ingredients2: [Extra]? = nil
    
    override init() {}
    required init(coder aDecoder: NSCoder) {
        if(aDecoder.decodeObjectForKey("size") as? String == nil) {size = nil}
        else {size = Size(rawValue: aDecoder.decodeObjectForKey("size") as! String)}
        if(aDecoder.decodeObjectForKey("item2") as? Int == nil) {item2 = nil}
        else {item2 = MenuItems(rawValue: (aDecoder.decodeObjectForKey("item2") as? Int)!)}
        price = aDecoder.decodeDoubleForKey("price")
        item = MenuItems(rawValue: (aDecoder.decodeObjectForKey("item") as! Int))!
        foodNotes = aDecoder.decodeObjectForKey("foodNotes") as? String
        foodNotes2 = aDecoder.decodeObjectForKey("foodNotes2") as? String
        halfhalf = aDecoder.decodeObjectForKey("halfhalf") as! Bool
        ingredients = aDecoder.decodeObjectForKey("ingredients") as! [Extra]
        ingredients2 = aDecoder.decodeObjectForKey("ingredients2") as? [Extra]

    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeDouble(price, forKey: "price")
        aCoder.encodeObject(size?.rawValue, forKey: "size")
        aCoder.encodeObject(item.rawValue, forKey: "item")
        aCoder.encodeObject(item2?.rawValue, forKey: "item2")
        aCoder.encodeObject(foodNotes, forKey: "foodNotes")
        aCoder.encodeObject(foodNotes2, forKey: "foodNotes2")
        aCoder.encodeObject(halfhalf, forKey: "halfhalf")
        aCoder.encodeObject(ingredients, forKey: "ingredients")
        aCoder.encodeObject(ingredients2, forKey: "ingredients2")
    }
    func copyWithZone(zone: NSZone) -> AnyObject {
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
    func addNewExtra (extra: Extra, doingHalf: Bool) {
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
            ordered.appendContentsOf(NO)
            ordered.appendContentsOf(plus)
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
            ordered.appendContentsOf(NO)
            ordered.appendContentsOf(plus)
            ingredients = ordered
            
        }
        //Make sure GF pizzas are large
        if(extra.extra == .GF) {size = .Large}
    }
    
    //Prints item desc:
    func desc() -> String {
        var text = MenuItems.itemString[item.rawValue]
        if(halfhalf) {text += "/" + MenuItems.itemString[item2!.rawValue]}
        return text
    }
    
    //Prints extras:
    func extras(halfhalf: Bool, asComma: Bool) -> String {
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
            for i in ingredients {if(i.extra == .GF) {sizeOrGF = "GF"}}
            
            if(halfhalf) {
                for i in ingredients2! {if(i.extra == .GF) {sizeOrGF = "GF"}}
                if(item2! == .GPizza) {
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
                if(item2! == .GPizza) {
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
                if(e.extra == .GF) {
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
                    if(e.extra == .GF) {
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
                if(e.extra == .GF) {
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
                    if(e.extra == .GF) {
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
    var timeDate = NSDate()
    var delivery = false
    var phoneNumber: String? = nil
    
    var priceTotal: Double = 0
    var foods = [Food]()
    
    //Adds new food item to the order:
    func addItem(item: Food) {
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
        foods = aDecoder.decodeObjectForKey("foods") as! [Food]
        orderNumber = aDecoder.decodeObjectForKey("orderNumber") as! Int
        name = aDecoder.decodeObjectForKey("name") as! String
        timeDate = aDecoder.decodeObjectForKey("timeDate") as! NSDate
        delivery = aDecoder.decodeObjectForKey("delivery") as! Bool
        phoneNumber = aDecoder.decodeObjectForKey("phoneNumber") as! String?
        priceTotal = aDecoder.decodeDoubleForKey("priceTotal")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(foods, forKey: "foods")
        aCoder.encodeObject(orderNumber, forKey: "orderNumber")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(timeDate, forKey: "timeDate")
        aCoder.encodeObject(delivery, forKey: "delivery")
        aCoder.encodeObject(phoneNumber, forKey: "phoneNumber")
        aCoder.encodeDouble(priceTotal, forKey: "priceTotal")
    }
    
    
}//END OF FILE