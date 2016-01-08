//
//  SwiftClassDemo.swift
//  Objc_demo
//
//  Created by sam on 16/1/8.
//  Copyright © 2016年 WF. All rights reserved.
//

import Foundation

class SwiftClassDemo: NSObject {

    func sayHello()->Void{
        print("hello");
    }
    
    func saygoodBye(greeting:String,withName:String)->String{
        return "say:\(greeting),my name is \(withName)";
    }
}
