//
//  AnohterViewController.swift
//  fusen
//
//  Created by 志音 on 2021/04/13.
//

import Cocoa

class StickyNoteViewController: NSViewController {

    @IBOutlet var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.font = .systemFont(ofSize: globalFontSize)
        if globalTransparent {
            textView.backgroundColor = NSColor(red: 255/255, green: 236/255, blue: 71/255, alpha: 0.85)
        } else {
            textView.backgroundColor = NSColor(red: 255/255, green: 236/255, blue: 71/255, alpha: 1)
        }
    }
    
    func changeFontSize() {
        textView.font = .systemFont(ofSize: globalFontSize)
    }
}
