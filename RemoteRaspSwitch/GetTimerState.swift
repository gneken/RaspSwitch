//
//  GetTimerState.swift
//  RemoteRaspSwitch
//
//  Created by Keng Jy Feng on 2015-05-06.
//  Copyright (c) 2015 gneken. All rights reserved.
//

import Foundation

class GetTimerState{

    var server = Connection()
    var newArray = [String()]
    func getArray()->[String]{
        return newArray as [String]
    }
    func updateTimers(){
        
        let array = server.getState()
        for index in 0..<array.count{
            dump(array)
            if array[index] == "unit1"{
                newArray.append(array[index+1] + " " + array[index+2] + "\n")
            }
        }
    }
    
    
}