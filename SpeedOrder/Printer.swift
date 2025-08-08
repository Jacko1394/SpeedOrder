//  Printer.swift
//  SpeedOrder
//  Created by Jack on 2/02/2016.
//  Copyright © 2016 Jack. All rights reserved.

class Printer: NSObject, Epos2PtrReceiveDelegate {

    var printing = false
    var printer = Epos2Printer(printerSeries:EPOS2_TM_T20.rawValue, lang:EPOS2_MODEL_ANK.rawValue)
    var result = EPOS2_SUCCESS.rawValue
    
    //Printer delegate response function:
    func onPtrReceive(_ printerObj: Epos2Printer!, code: Int32, status: Epos2PrinterStatusInfo!, printJobId: String!) {
        print("PRINTER: Response received" + "\(status)")
        result = (printer?.endTransaction())!
        result = (printer?.disconnect())!
        printer?.clearCommandBuffer()
        printer?.setReceiveEventDelegate(nil)
        printer = Epos2Printer(printerSeries:EPOS2_TM_T20.rawValue, lang:EPOS2_MODEL_ANK.rawValue)
        printing = false
    }
    
    //Function to generate order slips for store use:
    func createOrderSlip(_ order: Order) {
        //For formatting the time of order into time string:
        let format = DateFormatter()
        format.timeStyle = .short
        
        //Top border:
        var text = "----------------\n"
        result = (printer?.addTextAlign(EPOS2_ALIGN_CENTER.rawValue))!
        result = (printer?.addTextSize(3, height: 1))!
        result = (printer?.addText(text))!
        
        //Order number:
        text = "[\(order.orderNumber)]"
        result = (printer?.addTextSize(6, height: 4))!
        result = (printer?.addText(text))!
        
        //Order time:
        text = " \(format.string(from: order.timeDate as Date))\n"
        result = (printer?.addTextSize(2, height: 3))!
        result = (printer?.addText(text))!
        
        //Pickup/Delivery label:
        if(order.delivery == true) {text = "**DELIVERY**\n"}
        else {text = "**PICK-UP**\n"}
        
        result = (printer?.addTextSize(3, height: 3))!
        result = (printer?.addText(text))!
        result = (printer?.addTextAlign(EPOS2_ALIGN_LEFT.rawValue))!
        
        text = "----------------\n"
        result = (printer?.addTextSize(3, height: 1))!
        result = (printer?.addText(text))!
        
        //Loops to print out order items and descs:
        var didPastaLine = true
        for i in order.foods {
            result = (printer?.addTextAlign(EPOS2_ALIGN_LEFT.rawValue))!
            //Separates pizzas and pastas:
            if(i.item.rawValue > 17 && i.item.rawValue != 35 && didPastaLine) {
                text = "----------------\n"
                result = (printer?.addTextSize(3, height: 1))!
                result = (printer?.addText(text))!
                didPastaLine = false
            }
            
            //Prints various menuitems slightly differently:
            switch i.item.rawValue {
            case 1...17:
                //Pizza (size & number):
                text = "\n• " + i.asString() + "\n"
                result = (printer?.addTextSize(5, height: 4))!
                result = (printer?.addText(text))!
                
                if(i.halfhalf) {
                    if(i.ingredients.count > 0) {
                        //First half extras:
                        text = i.extras(false, asComma: false)
                        result = (printer?.addTextSize(2, height: 2))!
                        result = (printer?.addText(text))!
                    }
                    if(i.ingredients2 != nil) {
                        if(i.ingredients2!.count > 0) {
                            //Seoncd half extras:
                            result = (printer?.addTextAlign(EPOS2_ALIGN_RIGHT.rawValue))!
                            text = i.extras(true, asComma: false)
                            result = (printer?.addTextSize(2, height: 2))!
                            result = (printer?.addText(text))!
                        }
                    }
                } else {
                    //Pizza extras:
                    text = i.extras(false, asComma: false)
                    result = (printer?.addTextSize(2, height: 2))!
                    result = (printer?.addText(text))!
                }
            case 35:
                if(i.halfhalf) {
                    text = "\n• " + i.asString() + "\n"
                    result = (printer?.addTextSize(3, height: 4))!
                    result = (printer?.addText(text))!
                    if(i.ingredients.count > 0) {
                        //First half extras:
                        text = i.extras(false, asComma: false)
                        result = (printer?.addTextSize(2, height: 2))!
                        result = (printer?.addText(text))!
                    }
                    if(i.ingredients2 != nil) {
                        if(i.ingredients2!.count > 0) {
                            //Seoncd half extras:
                            result = (printer?.addTextAlign(EPOS2_ALIGN_RIGHT.rawValue))!
                            text = i.extras(true, asComma: false)
                            result = (printer?.addTextSize(2, height: 2))!
                            result = (printer?.addText(text))!
                        }
                    }
                } else {
                    text = "\n• " + i.asString() + "\n"
                    result = (printer?.addTextSize(4, height: 4))!
                    result = (printer?.addText(text))!
                    //Pizza extras:
                    text = i.extras(false, asComma: false)
                    result = (printer?.addTextSize(2, height: 2))!
                    result = (printer?.addText(text))!
                
                }
                
            case 18...27, 31...34: //Pastas and other:
                text = "• " + i.asString() + "\n"
                text += i.extras(false, asComma: false)
                
                result = (printer?.addTextSize(2, height: 2))!
                result = (printer?.addText(text))!
                
                
            case 28...30:
            text = "• " + i.asString() + "\n"
            
            result = (printer?.addTextSize(2, height: 2))!
            result = (printer?.addText(text))!
            default: print("Printering ERROR 1")
            }
        }
        
        //Bottom border:
        text = "----------------\n"
        result = (printer?.addTextSize(3, height: 1))!
        result = (printer?.addText(text))!
        
        //Customer details:
        if(order.delivery) {
            text = wordWrap("Address: \(order.name)", width: 24) + "\n"
            text += "Phone: \(order.phoneNumber!)\n"
        } else {
            text = "Name: \(order.name)\n"
            if(order.phoneNumber != nil) {text += "Phone: \(order.phoneNumber!)\n"}
        }
        
        //Price:
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        //text += "Total: " + formatter.string(from: NSNumber(order.priceTotal))! + "\n"
        result = (printer?.addTextAlign(EPOS2_ALIGN_LEFT.rawValue))!
        result = (printer?.addTextSize(2, height: 2))!
        result = (printer?.addText(text))!
        
        //Bottom border:
        text = "----------------"
        result = (printer?.addTextSize(3, height: 1))!
        result = (printer?.addText(text))!
        
        //Empty paper at the bottom:
        result = (printer?.addFeedLine(5))!
        result = (printer?.addCut(EPOS2_CUT_FEED.rawValue))!
        errorCheck(result)
    }
    
    //Function to generate delivery slips for store use:
    func createDeliverySlip(_ order: Order) {
        //For formatting the time of order into time string:
        let format = DateFormatter()
        format.timeStyle = .short
        
        //Address:
        var text = "\(order.name)"
        result = (printer?.addTextAlign(EPOS2_ALIGN_CENTER.rawValue))!
        result = (printer?.addTextSize(4, height: 3))!
        result = (printer?.addText(wordWrap(text, width: 12) + "\n"))!
        
        //Border:
        text = "----------------\n"
        result = (printer?.addTextSize(3, height: 1))!
        result = (printer?.addText(text))!
        
        //Price:
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        //text = "\(formatter.string(from: NSNumber(order.priceTotal))!)\n"
        result = (printer?.addTextSize(6, height: 3))!
        result = (printer?.addText(text))!
        
        //Print change of under price:
        var temp = 0.0
        while(temp < order.priceTotal) {temp += 50}
        //if(temp > 50) {text = "(\(formatter.string(from: temp - order.priceTotal)!)) change of $\(Int(temp))\n"}
        //else {text = "(\(formatter.string(from: temp - order.priceTotal)!))\n"}
        
        result = (printer?.addTextSize(2, height: 1))!
        result = (printer?.addText(text))!
        //Border:
        text = "----------------\n"
        result = (printer?.addTextSize(3, height: 1))!
        result = (printer?.addText(text))!
        
        text = ""
        
        for f in order.foods {
            switch f.item.rawValue {
            case 1...17, 35 : break
            case 18...34: text += f.asString() + "\n"
            default: print("fuck print error")
            }
            
        }
        result = (printer?.addTextSize(2, height: 2))!
        result = (printer?.addText(text))!
        
        //Empty paper at the bottom:
        result = (printer?.addFeedLine(5))!
        result = (printer?.addCut(EPOS2_CUT_FEED.rawValue))!
        errorCheck(result)
    }
    
    //Function that runs print sequence:
    func printOrder(_ order: Order) {
        if(printing == false) {
            //Only prints if not printing already:
            printing = true
            printer?.setReceiveEventDelegate(self)
            
            //Setup font/smoothing:
            result = (printer?.addTextSmooth(EPOS2_TRUE))!
            
            //Generates print data based on order:
            createOrderSlip(order)
            if(order.delivery) {createDeliverySlip(order)}
            
            //Connects to the printer:
            result = (printer?.connect("TCP:64:EB:8C:DF:F2:78", timeout: Int(EPOS2_PARAM_DEFAULT)))!
            result = (printer?.beginTransaction())!
            errorCheck(result)
            
            //Printer status:
            let status:Epos2PrinterStatusInfo = printer!.getStatus()
            if(status.connection == EPOS2_TRUE && status.online == EPOS2_TRUE) {
                result = (printer?.sendData(Int(EPOS2_PARAM_DEFAULT)))!
                errorCheck(result)
            } else {print("CONNECTION ERROR\n")}
        }
    }
    
    //
    func printSummary(_ orderList: [Order]) {
        if(printing == false) {
            //Only prints if not printing already:
            printing = true
            printer?.setReceiveEventDelegate(self)
            
            //Generates print data based on orderlist:
            createSummarySlip(orderList)
            
            //Connects to the printer:
            result = (printer?.connect("TCP:64:EB:8C:DF:F2:78", timeout: Int(EPOS2_PARAM_DEFAULT)))!
            result = (printer?.beginTransaction())!
            errorCheck(result)
            
            //Printer status:
            let status:Epos2PrinterStatusInfo = printer!.getStatus()
            if(status.connection == EPOS2_TRUE && status.online == EPOS2_TRUE) {
                result = (printer?.sendData(Int(EPOS2_PARAM_DEFAULT)))!
                errorCheck(result)
            } else {print("PRINTER: Connection Error\n")}
        }
    }
    
    //
    func createSummarySlip(_ orderList: [Order]) {
        let dateFormat = DateFormatter()
        let priceFormat = NumberFormatter()
        var total: Double = 0
        var pizzaCount = 0
        var orderCount = 0
        var orderDate = Date()
        
        dateFormat.timeStyle = .none
        dateFormat.dateStyle = .medium
        priceFormat.numberStyle = .currency
        if(orderList.count > 0) {orderDate = orderList[0].timeDate as Date}
        
        //Top border:
        var text = "------------------------\n"
        text += "Orders for: \(dateFormat.string(from: orderDate))\n"
        text += "------------------------\n"
        
        dateFormat.timeStyle = .short
        dateFormat.dateStyle = .none
        
        for o in orderList {
            orderCount += 1
            //text += "[\(o.orderNumber)] •\(dateFormat.string(from: o.timeDate as Date)) •\(priceFormat.string(from: NSNumber(o.priceTotal))!)\n"
            total += o.priceTotal
            //for f in o.foods {}
            for f in o.foods {
                if(f.item.rawValue < 18 || f.item.rawValue == 35) {pizzaCount += 1}
            }
        }
        
        text += "------------------------\n"
        text += "Num. of orders: \(orderCount)\n"
        text += "Pizzas Sold: \(pizzaCount)\n"
        //text += "Grand Total: \(priceFormat.string(from: NSNumber(total))!)\n"
        text += "------------------------"
        
        result = (printer?.addTextAlign(EPOS2_ALIGN_LEFT.rawValue))!
        result = (printer?.addTextSize(2, height: 1))!
        result = (printer?.addText(text))!
        
        //Empty paper at the bottom:
        result = (printer?.addFeedLine(5))!
        result = (printer?.addCut(EPOS2_CUT_FEED.rawValue))!
        errorCheck(result)
    }
    
    //
    func wordWrap(_ text: String, width: Int) -> String {
        let array = text.split{$0 == " "}.map(String.init)
        var newText = ""
        var count = 0
        
        for t in array {
            let wordLength = t.count
            if(wordLength + count > width) {
                newText += "\n" + t + " "
                count = wordLength + 1
            } else {
                newText += t + " "
                count += wordLength + 1
            }
        }
        return newText
    }
    
    //Error check function:
    func errorCheck(_ result:Int32) -> Bool {
        if(result != EPOS2_SUCCESS.rawValue) {
            print("PRINTER: Result Error\n")
            return false
        } else {return true}
    }
}//END OF FILE
