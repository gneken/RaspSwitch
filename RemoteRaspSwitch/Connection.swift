//
//  Connection.swift
//  RemoteRaspSwitch
//
//  Created by Keng Jy Feng on 2015-04-24.
//  Copyright (c) 2015 gneken. All rights reserved.
//

import Foundation
import UIKit


class Connection: NSObject, NSStreamDelegate {
    let prefs = NSUserDefaults.standardUserDefaults()
    var port = 9090
    var inputStream: NSInputStream?
    var outputStream: NSOutputStream?
    var message: String?
    var array = []
    
    func setIP(ip: UITextField!) -> String{
        prefs.setValue(ip.text, forKey: "iPaddr")
        return prefs.stringForKey("iPaddr")!
    }
    
    func getIP()-> String {
        if let addr = prefs.stringForKey("iPaddr"){
            prefs.stringForKey("iPaddr")!} else{
            prefs.setValue("XXX.XXX.XXX.XXX", forKey: "iPaddr")
        }
        return prefs.stringForKey("iPaddr")!
    }
    
    func getState() -> [String] {
        return array as! [String]
    }
    
    func connect(host: String, port: Int) {

        self.port = port
        
        NSStream.getStreamsToHostWithName(host, port: port, inputStream: &inputStream, outputStream: &outputStream)
        
        if inputStream != nil && outputStream != nil {
            
            inputStream!.delegate = self
            outputStream!.delegate = self
            
            inputStream!.scheduleInRunLoop(.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            outputStream!.scheduleInRunLoop(.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            
            inputStream!.open()
            outputStream!.open()
        }
    }
    
    func timerToServer(sender: UIButton, time: String, nummer: String){
        if(sender.currentTitle == "Turn On"){
            message = "TIMER\n" + "unit" + nummer + " ON" + "\n" + time + "\n"
        } else {
            message = "TIMER\n" + "unit" + nummer + " OFF" + "\n"  + time + "\n"
        }
        connect(prefs.stringForKey("iPaddr")!, port: port)
    }
    
    func toggle(sender: UISwitch, nummer: String) {
        if sender.on {
            message = "TOGGLE\n" + "unit" + nummer + " ON\n"
            println(message)
        } else {
            message = "TOGGLE\n" + "unit" + nummer + " OFF\n"
            println(message)
        }
        connect(prefs.stringForKey("iPaddr")!, port: port)
    }
    
    func initiate() {
        message = "INITIATE\n"
        connect(getIP(), port: port)
    }
    
    func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        
        if aStream === inputStream {
            switch eventCode {
            case NSStreamEvent.ErrorOccurred:
                println("input: ErrorOccurred: \(aStream.streamError?.description)")
            case NSStreamEvent.OpenCompleted:
                println("input: OpenCompleted")
            case NSStreamEvent.HasBytesAvailable:
                var buffer = [UInt8](count: 4096, repeatedValue: 0)
                while (inputStream!.hasBytesAvailable){
                    var len = inputStream!.read(&buffer, maxLength: buffer.count)
                    if(len > 0){
                        var output = NSString(bytes: &buffer, length: buffer.count, encoding: NSUTF8StringEncoding)
                        array = output!.componentsSeparatedByString(" ")
                        //println((array[0] as! String) + "test")
                    }
                }
            default:
                break
            }
        }
        else if aStream === outputStream {
            switch eventCode {
            case NSStreamEvent.ErrorOccurred:
                println("output: ErrorOccurred: \(aStream.streamError?.description)")
            case NSStreamEvent.OpenCompleted:
                println("output: OpenCompleted")
            case NSStreamEvent.HasSpaceAvailable:
                println(message)
                let data = message!.dataUsingEncoding(NSUTF8StringEncoding)!
                outputStream!.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length)
                outputStream!.close()
                //message = nil
                
            default:
                break
            }
        }
    }
}