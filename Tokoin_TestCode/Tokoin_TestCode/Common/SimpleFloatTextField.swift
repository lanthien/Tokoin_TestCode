//
//  SimpleFloatTextField.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/7/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import UIKit

class SimpleFloatTextField: UITextField {
    @IBInspectable var borderColor: UIColor = .gray
    @IBInspectable var edittingBorderColor: UIColor = .blue
    @IBInspectable var originPlaceHolderColor: UIColor = .gray
    @IBInspectable var floatLabelColor: UIColor = .black
    @IBInspectable var borderWidth: CGFloat = 0
    var floatLabelFont: UIFont = UIFont.systemFont(ofSize: 11)
    
    private var floatLabel: UILabel!
    private let leftPadding: CGFloat = 36
    private var borderShape: CAShapeLayer?
    
    private var isFloatting: Bool {
        return isEditing || (text?.count ?? 0) > 0
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            let size = self.bounds.size
            let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: size.height))
            self.leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 8, y: size.height / 2 - 10, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = leftImage
            iconContainerView.addSubview(imageView)
            self.leftView = iconContainerView
            self.showFloatLabel(self.isFloatting)
            self.drawBorder(isFloating: self.isFloatting)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        createUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //Draw border
        self.showFloatLabel(self.isFloatting)
        self.drawBorder(isFloating: self.isFloatting)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Draw border
        self.showFloatLabel(self.isFloatting)
        self.drawBorder(isFloating: self.isFloatting)
    }
    
    private func createUI() {
        self.clipsToBounds = false
        self.borderStyle = .none
        //Setup float label
        self.floatLabel = UILabel()
        self.floatLabel.font = self.font
        self.floatLabel.textAlignment = .center
        self.addSubview(self.floatLabel)
        self.setTitleFloatLabel(nil)
    }
    
    private func setTitleFloatLabel(_ text: String?) {
        self.floatLabel.text = placeholder
        self.floatLabel.sizeToFit()
        self.floatLabel.frame.origin.x = 8
        self.floatLabel.center.y = self.frame.size.height / 2
        self.showFloatLabel(false)
        if let placeHolder = self.placeholder {
            let attr = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.clear])
            self.attributedPlaceholder = attr
        }
    }
    
    override var placeholder: String? {
        didSet {
            self.setTitleFloatLabel(placeholder)
        }
    }
    
    override var text: String? {
        didSet {
            self.showFloatLabel(self.isFloatting)
            self.drawBorder(isFloating: self.isFloatting)
        }
    }
    override func becomeFirstResponder() -> Bool {
        let become = super.becomeFirstResponder()
        self.showFloatLabel(true)
        self.drawBorder(isFloating: true)
        return become
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        let resign = super.resignFirstResponder()
        if let text = self.text {
            if text.count == 0 {
                self.showFloatLabel(false)
                self.drawBorder(isFloating: false)
            } else {
                self.showFloatLabel(true)
                self.drawBorder(isFloating: true)
            }
        } else {
            self.showFloatLabel(false)
            self.drawBorder(isFloating: false)
        }
        return resign
    }
    
    private func showFloatLabel(_ floating: Bool) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let strongSelf = self else { return }
            if floating {
                // Set position of float label when editting text field
                strongSelf.floatLabel.textColor = strongSelf.floatLabelColor
                strongSelf.floatLabel.font = strongSelf.floatLabelFont
                strongSelf.floatLabel.sizeToFit()
                let labelHeight = strongSelf.floatLabel.bounds.size.height
                strongSelf.floatLabel.frame.origin = CGPoint(x: 12, y: -labelHeight / 2)
                strongSelf.floatLabel.frame.size.width += 20
            } else {
                // Set position of float label when not editting text field
                strongSelf.floatLabel.textColor = strongSelf.originPlaceHolderColor
                strongSelf.floatLabel.font = strongSelf.font
                strongSelf.floatLabel.sizeToFit()
                strongSelf.floatLabel.center.y = strongSelf.frame.size.height / 2
                if strongSelf.leftImage != nil {
                    strongSelf.floatLabel.frame.origin.x = strongSelf.leftPadding
                } else {
                    strongSelf.floatLabel.frame.origin.x = 0
                }
            }
        }
    }
    
    private func drawBorder(isFloating: Bool) {
        let size = self.bounds.size
        let bezierPath: UIBezierPath
        if !isFloating {
            bezierPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        } else {
            bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 12, y: 0))
            bezierPath.addLine(to: CGPoint(x: 0, y: 0))
            bezierPath.addLine(to: CGPoint(x: 0, y: size.height))
            bezierPath.addLine(to: CGPoint(x: size.width, y: size.height))
            bezierPath.addLine(to: CGPoint(x: size.width, y: 0))
            bezierPath.addLine(to: CGPoint(x: floatLabel.frame.maxX, y: 0))
        }
        bezierPath.lineWidth = self.borderWidth
        borderShape?.removeFromSuperlayer()
        borderShape = CAShapeLayer()
        borderShape?.path = bezierPath.cgPath
        let x = self.isEditing ? self.edittingBorderColor : self.borderColor
        borderShape?.strokeColor = x.cgColor
        borderShape?.fillColor = nil
        self.layer.insertSublayer(borderShape!, at: 0)
    }
}
