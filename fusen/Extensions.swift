//
//  Extensions.swift
//  fusen
//
//  Created by 志音 on 2021/04/13.
//

import Cocoa

extension NSWindow {
    
    var titleBarHeight: CGFloat {
        frame.height - contentRect(forFrameRect: frame).height
    }
    
}

extension NSWindowController {
    
    func showFloatingWindow(windowRect: CGRect, viewController: NSViewController, title: String) {
        let styleMask: NSWindow.StyleMask = [.titled, .nonactivatingPanel, .fullSizeContentView, .closable]
        let window = NSPanel(contentRect: windowRect, styleMask: styleMask, backing: .buffered, defer: true)
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.title = title
        window.center()
        window.isOpaque = false
        window.hasShadow = true
        window.isMovableByWindowBackground = false
        window.backgroundColor = NSColor.clear
        window.level = .mainMenu + 1
        viewController.view.setFrameSize(windowRect.size)
        window.contentViewController = viewController
        self.contentViewController = window.contentViewController
        self.window = window
        self.showWindow(self)
    }
}

@IBDesignable
extension NSView {
    
    open override func mouseDown(with event: NSEvent) {
        self.window?.makeFirstResponder(nil)
    }
    
    @IBInspectable var backgroundColor: NSColor? {
        get {
            guard let layer = layer, let backgroundColor = layer.backgroundColor else {return nil}
            return NSColor(cgColor: backgroundColor)
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            guard let layer = layer else {return 0}
            return layer.cornerRadius
        }
        set {
            wantsLayer = true
            layer?.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor: NSColor? {
        get {
            guard let layer = layer, let borderColor = layer.borderColor else {return nil}
            return NSColor(cgColor: borderColor)
        }
        set {
            wantsLayer = true
            layer?.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            guard let layer = layer else {return 0}
            return layer.borderWidth
        }
        set {
            wantsLayer = true
            layer?.borderWidth = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            guard let layer = layer else {return 0}
            return layer.shadowOpacity
        }
        set {
            wantsLayer = true
            shadow = NSShadow()
            layer?.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowColor: NSColor? {
        get {
            guard let layer = layer, let shadowColor = layer.shadowColor else {return nil}
            return NSColor(cgColor: shadowColor)
        }
        set {
            wantsLayer = true
            layer?.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            guard let layer = layer else {return CGSize.zero}
            return layer.shadowOffset
        }
        set {
            wantsLayer = true
            layer?.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            guard let layer = layer else {return 0}
            return layer.shadowRadius
        }
        set {
            wantsLayer = true
            layer?.shadowRadius = newValue
        }
    }
}

@IBDesignable class FusenButton: NSButton {
    @IBInspectable var bgColor: NSColor?
    @IBInspectable var textColor: NSColor?

    override func awakeFromNib() {
        if let textColor = textColor, let font = font {
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            let attributes = [
                NSAttributedString.Key.foregroundColor: textColor,
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.paragraphStyle: style
            ] as [NSAttributedString.Key : Any]
            let attributedTitle = NSAttributedString(string: title, attributes: attributes)
            self.attributedTitle = attributedTitle
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        if let bgColor = bgColor {
            bgColor.setFill()
            __NSRectFill(dirtyRect)
        }
        super.draw(dirtyRect)
    }
}
