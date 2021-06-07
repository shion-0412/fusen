//
//  AppDelegate.swift
//  fusen
//
//  Created by 志音 on 2021/04/13.
//

import Cocoa

var globalFontSize: CGFloat = 14
var globalTransparent: Bool = false
var configWindowController: NSWindowController?

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    weak var pileViewControllerDelegate: PileViewControllerDelegate?

    @IBAction func clickPreferences(_ sender: Any) {
        if configWindowController == nil {
            configWindowController = NSWindowController()
            let storyboard = NSStoryboard.init(name: "Main", bundle: nil)
            let configViewController = storyboard.instantiateController(withIdentifier: "ConfigViewController") as! ConfigViewController
            let windowRect = CGRect(x: 100, y: 200, width: 260, height: 122)
            let styleMask: NSWindow.StyleMask = [.titled, .closable]
            let window = ConfigWindow(contentRect: windowRect, styleMask: styleMask, backing: .buffered, defer: true)
            window.collectionBehavior = [.fullScreenAuxiliary]
            window.title = "Preferences"
            window.center()
            configViewController.view.setFrameSize(windowRect.size)
            window.contentViewController = configViewController
            configWindowController!.contentViewController = window.contentViewController
            configWindowController!.window = window
            configWindowController!.showWindow(self)
        }
    }
    
    func changeFontSize() {
        pileViewControllerDelegate?.changeFontSize()
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
}

class ConfigWindow: NSWindow {
    
    override func orderOut(_ sender: Any?) {
        super.orderOut(sender)
        configWindowController = nil
        if let appDelegate = NSApp.delegate as? AppDelegate {
            appDelegate.changeFontSize()
        }
        UserDefaults.standard.setValue(Float(globalFontSize), forKey: "fontSize")
        UserDefaults.standard.setValue(globalTransparent, forKey: "transparent")
    }
    
}

protocol PileViewControllerDelegate: class {
    func changeFontSize()
}
