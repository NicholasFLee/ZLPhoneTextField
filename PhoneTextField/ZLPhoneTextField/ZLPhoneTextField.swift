//
//  ZLPhoneTextField.swift
//  PhoneTextField
//
//  Created by Nicholas Lee on 2017/1/15.
//  Copyright © 2017年 Nicholas Lee. All rights reserved.
//

import UIKit

enum Separator: String {
    case hyphen = "-"
    case blank = " "
}

class ZLPhoneTextField: UITextField, UITextFieldDelegate {
    
    let cSet = CharacterSet.init(charactersIn: "0123456789")
    let separator: Separator
    
    init(separator: Separator) {
        self.separator = separator
        super.init(frame: CGRect.zero)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.rangeOfCharacter(from: self.cSet.inverted) != nil {
            return false
        }
        if (textField.text?.characters.count)! + string.characters.count - range.length > 13 {
            return false
        }
        if (range.location == 3 || range.location == 8) && range.length == 1 {
            setCursorPosition(input: self, position: range.location)
            return false
        }
        var newString = textField.text!
        if range.length == 1 {
            newString.remove(at: newString.index(newString.startIndex, offsetBy: range.location))
        } else {
            newString.insert(Character.init(string), at: newString.index(newString.startIndex, offsetBy: range.location))
        }
        if newString.characters.last?.description == separator.rawValue {
            newString.remove(at: (newString.index(before: newString.endIndex)))
            textField.text = newString
            return false
        }
        var rawStr = newString.replacingOccurrences(of: separator.rawValue, with: "")
        if rawStr.characters.count > 7 {
            rawStr.insert(Character.init(separator.rawValue), at: rawStr.index(rawStr.startIndex, offsetBy: 7))
        }
        if rawStr.characters.count > 2 {
            rawStr.insert(Character.init(separator.rawValue), at: rawStr.index(rawStr.startIndex, offsetBy: 3))
            if rawStr.characters.last?.description == separator.rawValue {
                rawStr.remove(at: (rawStr.index(before: rawStr.endIndex)))
            }
            textField.text = rawStr
            if range.length == 1 {
                setCursorPosition(input: self, position: range.location)
            } else if range.location == 3 || range.location == 8 {
                setCursorPosition(input: self, position: range.location + 2)
            } else {
                setCursorPosition(input: self, position: range.location + 1)
            }
            return false
        }
        return true
    }
    
    private func setCursorPosition(input: UITextField, position: Int) {
        let position = input.position(from: input.beginningOfDocument, offset: position)!
        input.selectedTextRange = input.textRange(from: position, to: position)
    }
    
    func getNumber() -> String {
        var r = ""
        let _ = self.text?.characters.filter({ (c) -> Bool in
            if c.description != separator.rawValue {
                r.append(c)
            }
            return true
        })
        return r
    }
    
    
    
    
}
