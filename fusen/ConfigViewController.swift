//
//  ConfigViewController.swift
//  fusen
//
//  Created by 志音 on 2021/04/13.
//

import Cocoa

class ConfigViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var fontSizeStepper: NSStepper!
    @IBOutlet weak var fontSizeTextField: NSTextField!
    @IBOutlet weak var transparentButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontSizeTextField.delegate = self
        fontSizeStepper.floatValue = Float(globalFontSize)
        fontSizeTextField.stringValue = globalFontSize.description
        if globalTransparent {
            transparentButton.state = .on
        } else {
            transparentButton.state = .off
        }
    }
    
    @IBAction func clickFontSizeStepper(_ sender: NSStepper) {
        fontSizeTextField.stringValue = fontSizeStepper.stringValue
        globalFontSize = CGFloat(fontSizeStepper.floatValue)
    }
    
    func controlTextDidEndEditing(_ obj: Notification) {
        guard let textField = obj.object as? NSTextField else { return }
        guard textField.identifier == fontSizeTextField.identifier else { return }
        let newSizeValue = textField.stringValue.replacingOccurrences(of: ",", with: "")
        let number = NumberFormatter().number(from: newSizeValue)
        var newSize = CGFloat(truncating: number!)
        if textField.identifier == fontSizeTextField.identifier {
            let minSize = CGFloat(fontSizeStepper.minValue)
            let maxSize = CGFloat(fontSizeStepper.maxValue)
            if newSize < minSize {
                fontSizeTextField.stringValue = minSize.description
                newSize = minSize
            }
            if maxSize < newSize {
                fontSizeTextField.stringValue = maxSize.description
                newSize = maxSize
            }
            fontSizeStepper.stringValue = newSize.description
            globalFontSize = newSize
        }
    }
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            let sizeTextFieldValue = fontSizeTextField.stringValue.replacingOccurrences(of: ",", with: "")
            if let number = NumberFormatter().number(from: sizeTextFieldValue){
                var newSize = CGFloat(truncating: number)
                let minSize = CGFloat(fontSizeStepper.minValue)
                let maxSize = CGFloat(fontSizeStepper.maxValue)
                if newSize < minSize {
                    fontSizeTextField.stringValue = minSize.description
                    newSize = minSize
                }
                if maxSize < newSize {
                    fontSizeTextField.stringValue = maxSize.description
                    newSize = maxSize
                }
                fontSizeStepper.stringValue = newSize.description
                globalFontSize = newSize
            } else {
                fontSizeTextField.stringValue = fontSizeStepper.stringValue
            }
            self.view.window?.makeFirstResponder(nil)
            return true
        }
        return false
    }
    
    @IBAction func clickTransparentButton(_ sender: NSButton) {
        if sender.state == .on {
            globalTransparent = true
        } else {
            globalTransparent = false
        }
    }
    
}
