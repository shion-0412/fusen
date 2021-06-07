//
//  ViewController.swift
//  fusen
//
//  Created by 志音 on 2021/04/13.
//

import Cocoa

class PileViewController: NSViewController, NSTextViewDelegate, PileViewControllerDelegate {

    @IBOutlet var textView: NSTextView!
    var fusenCount: Int = 1
    var viewControllers = [StickyNoteViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "fontSize") == nil {
            globalFontSize = 14
        } else {
            globalFontSize = CGFloat(UserDefaults.standard.float(forKey: "fontSize"))
        }
        if UserDefaults.standard.object(forKey: "transparent") == nil {
            globalTransparent = false
        } else {
            globalTransparent = UserDefaults.standard.bool(forKey: "transparent")
        }
        textView.delegate = self
        textView.font = .systemFont(ofSize: globalFontSize)
        textView.backgroundColor = NSColor(red: 255/255, green: 236/255, blue: 71/255, alpha: 1)
        if let appDelegate = NSApp.delegate as? AppDelegate {
            appDelegate.pileViewControllerDelegate = self
        }
    }
    
    @IBAction func showFusen(_ sender: Any) {
        self.view.window?.makeFirstResponder(nil)
        let stickyNoteViewController = self.storyboard?.instantiateController(withIdentifier: "StickyNoteViewController") as! StickyNoteViewController
        viewControllers.append(stickyNoteViewController)
        let windowController = NSWindowController()
        let titleBarHeight: CGFloat = self.view.window?.titleBarHeight != nil ? self.view.window!.titleBarHeight : 0
        let sticykNoteString = NSLocalizedString("sticky_note", comment: "")
        windowController.showFloatingWindow(windowRect: CGRect(x: 100, y: 200, width: 300, height: 300 + titleBarHeight),
                                            viewController: stickyNoteViewController,
                                            title: "\(sticykNoteString) \(fusenCount)")
        fusenCount += 1
        stickyNoteViewController.textView.string = textView.string
    }
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            self.view.window?.makeFirstResponder(nil)
            return true
        }
        return false
    }
    
    func changeFontSize() {
        textView.font = .systemFont(ofSize: globalFontSize)
        viewControllers.forEach {
            $0.changeFontSize()
        }
    }

}

