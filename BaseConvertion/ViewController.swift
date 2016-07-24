//
//  ViewController.swift
//  BaseConvertion
//
//  Created by Leo on 7/24/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nHexField: UITextField!
    @IBOutlet weak var nbitField: UITextField!
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var baseController: UISegmentedControl!
    
    @IBOutlet weak var outputUp: UILabel!
    
    @IBOutlet weak var outputDown: UILabel!
    
    @IBAction func fireButton(sender: AnyObject) {
        
        let nHexCount = Int(self.nHexField.text!)
        
        switch baseController.selectedSegmentIndex
        {
        case 0://Bin
            let dec = bin2dec(self.inputField.text!, signedConvert: 0)
            self.outputUp.text = "\(dec)"
            var hex = dec2hex(dec)
            if hex.length < nHexCount {
                for _ in 1...(nHexCount! - hex.length) {
                    hex = "0" + hex
                }
            }
            self.outputDown.text = "\(hex)"
            
        case 1://SBin
            
            let a = (self.inputField.text?.characters.first?.toInt())! - 48
            let dec = bin2dec(self.inputField.text!, signedConvert: a)
            self.outputUp.text = "\(dec)"
            let dec2 = bin2dec(self.inputField.text!, signedConvert: 0)
            var hex = dec2hex(dec2)
            if hex.length < nHexCount {
                for _ in 1...(nHexCount! - hex.length) {
                    hex = "0" + hex
                }
            }
            self.outputDown.text = "\(hex)"
            
        case 2:
            let bin = dec2bin(Int(self.inputField.text!)!)
            self.outputUp.text = "\(bin)"
            
            var hex = dec2hex(Int(self.inputField.text!)!)
            if hex.length < nHexCount {
                for _ in 1...(nHexCount! - hex.length) {
                    hex = "0" + hex
                }
            }
            self.outputDown.text = "\(hex)"
            
        case 3:
            var newInput:Int  = 0
            let pow2 = Int(pow(Double(2), Double(self.nbitField.text!)!))
            
            let tmpInput = Int(self.inputField.text!)! % pow2
        
            
            if (tmpInput < 0){
              newInput = tmpInput + pow2
            }
            else{
             newInput  = tmpInput
            }
            
            //let newInput = Int(self.inputField.text!)! % Int(pow(Double(2), Double(self.nbitField.text!)!))
            
            //print(newInput)
            //print(mod(-1,4))
            let bin = dec2bin(Int(newInput))
            self.outputUp.text = "\(bin)"
            
            var hex = dec2hex(Int(newInput))
            if hex.length < nHexCount {
                for _ in 1...(nHexCount! - hex.length) {
                    hex = "0" + hex
                }
            }
            self.outputDown.text = "\(hex)"
            
        case 4:
            let dec = hex2dec(self.inputField.text!)
            self.outputUp.text = "\(dec2bin(Int(dec)))"
            self.outputDown.text = "\(dec)"
        default:
            break
        }
        
    }
    
    
    override func viewDidLoad() {
        self.outputUp.text = "yo"
        self.outputDown.text = "man"
        super.viewDidLoad()
        self.inputField.clearButtonMode = .Always
        self.nbitField.hidden = true
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func statusChange(sender: AnyObject) {
        
        switch baseController.selectedSegmentIndex
        {
        case 0://Bin
            self.nHexField.hidden = false
            self.nbitField.hidden = true
            
        case 1://SBin
            self.nHexField.hidden = false
            self.nbitField.hidden = false
            
        case 2://Dec
            self.nHexField.hidden = false
            self.nbitField.hidden = true

            
        case 3://SDec
            self.nHexField.hidden = false
            self.nbitField.hidden = false

            
        case 4://Hex
            self.nbitField.hidden = true
            self.nHexField.hidden = true

            

        default:
            break
        }
    }


    
}

import Foundation
extension Character
{
    func toInt() -> Int
    {
        var intFromCharacter:Int = 0
        for scalar in String(self).unicodeScalars
        {
            intFromCharacter = Int(scalar.value)
        }
        return intFromCharacter
    }
}
//MARK: 十六进制 --> 十进制
func hex2dec(num:String) -> Int
{
    let str = num.uppercaseString
    var sum = 0
    for i in str.utf8 {
        sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
        if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
            sum -= 7
        }
    }
    return sum
}
//MARK:十进制  --> 十六进制
func dec2hex(num:Int) -> String {
    return String(format: "%0X", num)
}
//MARK: 十进制 -> 二进制
func dec2bin(var number:Int) -> String {
    var str = ""
    while number > 0 {
        str = "\(number % 2)" + str
        number /= 2
    }
    return str
}
//MARK: 二进制  ->  十进制
func bin2dec(num:String, signedConvert:Int) -> Int {
    var sum = 0
    for cc in num.characters
    {
        sum = sum * 2 + (cc.toInt() - 48)
    }
    
    if signedConvert == 1 {
        let a = num.length
        sum = sum - Int(pow(Double(2), Double(a)))
    }
    return sum
}

extension String {
    
    var length: Int { return characters.count}
    
}

