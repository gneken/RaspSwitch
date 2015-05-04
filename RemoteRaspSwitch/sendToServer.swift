//
//  sendToServer.swift
//  RemoteRaspSwitch
//
//  Created by Keng Jy Feng on 2015-04-10.
//  Copyright (c) 2015 gneken. All rights reserved.
//

import UIKit
import Foundation

class sendToServer{
 
    struct MyVariables {
        //static var iPaddr = "XXX.XXX.XXX.XXX"
//        var prefs = NSUserDefaults.standardUserDefaults()
//        prefs.setValue("XXX.XXX.XXX.XXX", forKey: "iPaddr")
    }
    
    func setIP(ip: UITextField!) -> String{
        let prefs = NSUserDefaults.standardUserDefaults()
    prefs.setValue(ip.text, forKey: "iPaddr")
//        MyVariables.iPaddr = ip.text
//        return MyVariables.iPaddr
        return prefs.stringForKey("iPaddr")!
    }
    
    func getIP()-> String {
        let prefs = NSUserDefaults.standardUserDefaults()
        if let addr = prefs.stringForKey("iPaddr"){
            prefs.stringForKey("iPaddr")!} else{
        prefs.setValue("XXX.XXX.XXX.XXX", forKey: "iPaddr")
        }
        return prefs.stringForKey("iPaddr")!
    //return MyVariables.iPaddr
    }

    func toServer(sender: UISwitch, nummer: String){
        var prefs = NSUserDefaults.standardUserDefaults()
        //let addr = MyVariables.iPaddr
        let addr = prefs.stringForKey("iPaddr")!
        let port = 9090
        
        var inp :NSInputStream?
        var out :NSOutputStream?
        
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
        
        let outputStream = out!
        
        var myString = String()
        
        if(sender.on == true){
            myString = "TOGGLE\n" + "ON unit " + nummer
        } else {
            myString = "TOGGLE\n" + "OFF unit " + nummer
        }
        
        outputStream.open()
        let data: NSData = myString.dataUsingEncoding(NSUTF8StringEncoding)!
        outputStream.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length)
    }
    
    func timerToServer(sender: UIButton, time: String, nummer: String){
        var prefs = NSUserDefaults.standardUserDefaults()
        //let addr = MyVariables.iPaddr
        let addr = prefs.stringForKey("iPaddr")!
        let port = 9090
        
        var inp :NSInputStream?
        var out :NSOutputStream?
        
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
        
        let outputStream = out!
        
        var myString = String()
        
        if(sender.currentTitle == "Turn On"){
            myString = "TIMER\n" + time + "\n" + "ON unit " + nummer
        } else {
            myString = "TIMER\n" + time + "\n" + "OFF unit " + nummer
        }
        
        outputStream.open()
        let data: NSData = myString.dataUsingEncoding(NSUTF8StringEncoding)!
        outputStream.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length)
    }
    
    
}