//
//  viewEnhet1.swift
//  RemoteRaspSwitch
//
//  Created by Keng Jy Feng on 2015-04-01.
//  Copyright (c) 2015 gneken. All rights reserved.
//

import UIKit

class viewEnhet1: UIViewController {
    
    var server = Connection()
    var theTime = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        server.initiate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func turnOnButton(sender: UIButton) {
        if theTime.isEmpty{displayTimers.text = "Enter A Time!"
        }else{
            server.timerToServer(sender, time: theTime, nummer: "1")
        }
    }
    
    
    @IBAction func turnOffButton(sender: UIButton) {
        if theTime.isEmpty{displayTimers.text = "Enter A Time!"
        }else{
            server.timerToServer(sender, time: theTime, nummer: "1")
        }
    }
    
    @IBOutlet weak var displayTimers: UITextView!
    @IBAction func selectTime(sender: UIDatePicker) {
        var timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        timeFormatter.dateFormat = "HH:mm"
        theTime = timeFormatter.stringFromDate(sender.date)
        displayTimers.text = timeFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func refreshTimers(sender: UIButton) {
        text = ""
        server.initiate()
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateTimers"), userInfo: nil, repeats: false)
    }
    
    var text = String()
    func updateTimers(){
        let array = server.getState()
        for index in 0..<array.count{
            if array[index] == "unit1"{
                text += array[index+1] + " " + array[index+2] + "\n"
            }
        }
        displayTimers.text = text
        
    }
    
}