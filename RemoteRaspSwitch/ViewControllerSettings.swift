//
//  ViewControllerSettings.swift
//  RemoteRaspSwitch
//
//  Created by Keng Jy Feng on 2015-04-21.
//  Copyright (c) 2015 gneken. All rights reserved.
//

import UIKit

class ViewControllerSettings: UIViewController {
    
    var server = Connection()
    @IBOutlet weak var ipAdress: UITextField!
    @IBOutlet weak var currIP: UITextField!
    @IBOutlet var currentIP: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateIP()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateIP(){
       var cIP = server.getIP()
       self.currIP.text = cIP
    }
    
    
    @IBAction func sendIP(sender: AnyObject) {
        
       let iPaddr = server.setIP(ipAdress)
        self.currIP.text = iPaddr
        
    }
    

}
