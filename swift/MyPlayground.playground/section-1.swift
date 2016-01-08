// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/** 
* var声明与let声明变量的区别:
* 1,var声明值可变的变量，let则声明不可变的常量用的居多
*
**/
var myVarible = 42
myVarible = 50;

let myConstant = 42;
//注释打开则会编译出错
//myConstant = 50


//浮点型转换
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble:Double = 70
let explicitFloat:Float = 4

//字符串连接的方式
var label = "The width is "
var width = 90
var width2 = 10
var labelWidth = label + String(width)
let widthPix = " cm"
let labelWidth2 = "The width is \(width + width2)" + widthPix

//array
var shoppingList = ["aa","肥皂","soap"]
shoppingList[1] = "cat"
shoppingList
//map
var occupations = ["phone":"110","code":"120333","zip":"22222"]
occupations["code"]
occupations["code"] = "120"

//for iterate
var tempScore = 0;
let individualScores = [100,89,45,60]
for score in individualScores{
    if score >= 60 {
        tempScore += 3
    }else{
        tempScore += 1;
    }
}
tempScore

//String mark optionValue type
var optionName:String?="John Applessed"
var greeting = "hello!"
if let name = optionName{
    greeting = "Hello, \(name)"
}
greeting



@objc(MySwift)
class MySwiftClass:NSObject {
    var enabled:Bool{
        @objc(isEnabled) get{
            return true;
        }
    }
    
}

print("hello,is ok")

let sparklingHeart = "\u{1F496}";


var param? String
param = "I'm king,you are my queen"
