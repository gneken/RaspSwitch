//
//  viewEnhet2.swift
//  RemoteRaspSwitch
//
//  Created by Keng Jy Feng on 2015-04-01.
//  Copyright (c) 2015 gneken. All rights reserved.
//

import UIKit

class viewEnhet2: UIViewController {
    
    var server = Connection()
    var theTime = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        server.initiate()
        displayTimers.text = " "
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var buttonOn: UIButton!
    
    
    @IBAction func selectTime(sender: UIDatePicker) {
        var timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        timeFormatter.dateFormat = "HH:mm"
        theTime = timeFormatter.stringFromDate(sender.date)
        displayTimers.text = timeFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func turnOnButton(sender: UIButton) {
        if theTime.isEmpty{displayTimers.text = "Enter A Time!"
        }else{
            server.timerToServer(sender, time: theTime, nummer: "2")
        }
        
    }
    
    @IBAction func turnOffButton(sender: UIButton) {
        if theTime.isEmpty{displayTimers.text = "Enter A Time!"
        }else{
            server.timerToServer(sender, time: theTime, nummer: "2")
        }
    }
    

    @IBAction func refreshTimers(sender: UIButton) {
        text = ""
        server.initiate()
        updateTimers()
    }
    
    @IBOutlet weak var displayTimers: UITextView!
    
    var text = String()
    func updateTimers(){
        let array = server.getState()
//        for element in array{
//        println("\(element) ")
//            if element == "unit2"{
//                displayTime.text = element
//            }
//        }
        
        for index in 0..<array.count{
            if array[index] == "unit2"{
                text += array[index+1] + " " + array[index+2] + "\n"
            }
        }
        displayTimers.text = text
        

    }
    
}
