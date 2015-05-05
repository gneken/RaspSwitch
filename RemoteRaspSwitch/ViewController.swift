//
//  ViewController.swift
//  RemoteRaspSwitch
//
//  Created by Keng Jy Feng on 2015-04-01.
//  Copyright (c) 2015 gneken. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var server = Connection()
    var settings = ViewControllerSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        server.initiate()
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateSwitch"), userInfo: nil, repeats: false)
        switchOne.tintColor = UIColor.redColor()
        switchTwo.tintColor = UIColor.redColor()
        switchThree.tintColor = UIColor.redColor()
        switchFour.tintColor = UIColor.redColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        refreshText.title = "Refresh"
    }
    
    
    @IBAction func toViewEnhet1(sender: AnyObject) {
        
        let enhet1 = self.storyboard?.instantiateViewControllerWithIdentifier("enhet1") as! viewEnhet1
        self.navigationController?.pushViewController(enhet1, animated: true)
    }
    
    
    @IBAction func toViewEnhet2(sender: AnyObject) {
        
        let enhet2 = self.storyboard?.instantiateViewControllerWithIdentifier("enhet2") as! viewEnhet2
        self.navigationController?.pushViewController(enhet2, animated: true)
        
    }
    
    @IBAction func toggleSwitch(sender: UISwitch) {
        server.toggle(sender, nummer: sender.restorationIdentifier!)
    }
    
    
    @IBOutlet weak var refreshText: UIBarButtonItem!
    
    @IBAction func refreshSwitches(sender: UIBarButtonItem) {
        server.initiate()
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateSwitch"), userInfo: nil, repeats: false)
        refreshText.title = "Refreshed"
    }
    
    
    @IBOutlet weak var switchOne: UISwitch!
    @IBOutlet weak var switchTwo: UISwitch!
    @IBOutlet weak var switchThree: UISwitch!
    @IBOutlet weak var switchFour: UISwitch!
    
    func updateSwitch(){
        
        var array = server.getState()
        
        if (array[0] == "LOW"){
            switchOne.setOn(false, animated: true)
        } else if (array[0] == "HIGH") {
            switchOne.setOn(true, animated: true)
        } else {println("Fail")
            return}
        
        if (array[1] == "LOW"){
            switchTwo.setOn(false, animated: true)
        } else if (array[1] == "HIGH") {
            switchTwo.setOn(true, animated: true)
        } else {println("Fail")
            return}
        
        if (array[2] == "LOW"){
            switchThree.setOn(false, animated: true)
        } else if (array[2] == "HIGH") {
            switchThree.setOn(true, animated: true)
        } else {println("Fail")
            return}
        
        if (array[3] == "LOW"){
            switchFour.setOn(false, animated: true)
        } else if (array[3] == "HIGH") {
            switchFour.setOn(true, animated: true)
        } else {println("Fail")
            return}
    }
}

