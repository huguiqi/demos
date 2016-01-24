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
        var shoppingList:[String] = ["Eggs", "Milk"]
        //或者
//        var shoppingList = ["Eggs", "Milk"]
//
//        //在swift中没有可变和不可变数组的概念
        shoppingList.append("Flour");

//        shoppingList += "Baking Powder" //这种方法添加数组是不行的
        shoppingList += ["Baking Powder"]
        //你还可以以组的方式添加item
        shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
        //把第5、6个元素内容分别替换成Bananas、Apples,第7个元素被切掉了
        shoppingList[4...6] = ["Bananas", "Apples"]
        //将会返回["Eggs", "Milk", "Flour", "Baking Powder", "Bananas", "Apples"]
        print(shoppingList)
        for item in shoppingList{
            print(item);
        }
        
        for (index,value) in shoppingList.enumerate(){
            print("index:\(index) value:\(value)")
        }
        
    let apples = shoppingList.removeLast()
        print(apples)
        //oc的数组里的元素类型必须一样,而swift可以不同，用let初始化一个数组

        let arrays = ["cars",20,true]

        print(arrays)
    }
    
    func saygoodBye(greeting:String,withName:String)->String{
        return "say:\(greeting),my name is \(withName)";
    }
}
