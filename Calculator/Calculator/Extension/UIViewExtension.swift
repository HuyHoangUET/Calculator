//
//  UIViewExtension.swift
//  Calculator
//
//  Created by Phạm Huy Hoàng on 26/06/2023.
//

import UIKit

extension UIView {
    func fixInView(_ container: UIView!) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func createGradientLayer(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
//        if (isHorizontal) {
//            gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
//            gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
//        } else {
//            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
//        }
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)//self.bounds
        gradientLayer.colors = colors
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addDashedBorder() {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.lineDashPattern = [NSNumber(value: 5)]
        
        // Setup the path
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0), transform: .identity)
        path.addLine(to: CGPoint(x: frame.size.width, y: 0), transform: .identity)
        
        shapeLayer.path = path
        
        layer.addSublayer(shapeLayer)
    }
    
    func dropShadow(scale: Bool = true, cornerRadius: CGFloat) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = cornerRadius

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func rotate(_ angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
    
    @available(iOS 11, *)
    func cornersView(maskedCorners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.maskedCorners = maskedCorners
    }
    
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

extension UIView {
    func addDashedBorderRec(_ color: UIColor = .white.withAlphaComponent(0.6)) {

    let shapeLayer:CAShapeLayer = CAShapeLayer()
    let frameSize = self.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
    shapeLayer.lineWidth = 2
    shapeLayer.lineJoin = CAShapeLayerLineJoin.round
    shapeLayer.lineDashPattern = [6,3]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

    self.layer.addSublayer(shapeLayer)
    }
    
    func removeAllSubLayerInView() {
        if let lstSubLayer = self.layer.sublayers {
            for item in lstSubLayer where item is CAShapeLayer {
                item.removeFromSuperlayer()
            }
        }
    }
}

extension UIView {
    static var identify: String {
        return String(describing: self)
    }
}

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}


extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach { $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerXInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    func nsWidth() -> NSLayoutConstraint? {
        for constraint in self.constraints {
            if (constraint.firstAttribute == .width && constraint.isActive && constraint.firstItem === self) {
                return constraint;
            }
        }
        return nil;
    }
    
    func nsHeight() -> NSLayoutConstraint? {
        for constraint in self.constraints {
            if (constraint.isKind(of: NSLayoutConstraint.self)) {
                if (constraint.firstAttribute == .height && constraint.isActive && constraint.firstItem === self) {
                    return constraint;
                }
            }
        }
        return nil;
    }
    
    func setNSHeightConstant(constant: CGFloat) {
        for constraint in self.constraints {
            if (constraint.isKind(of: NSLayoutConstraint.self)) {
                if (constraint.firstAttribute == .height && constraint.isActive && constraint.firstItem === self) {
                    constraint.constant = constant
                }
            }
        }
    }
    
    func nsHeightEqualSupperview() -> NSLayoutConstraint? {
        if let supperview = self.superview {
            for constraint in supperview.constraints {
                if ((constraint.firstItem === self || constraint.secondItem === self) && constraint.firstAttribute == .height && constraint.isActive) {
                    return constraint;
                }
            }
        }
        return nil;
    }
    
    func setNSWidthConstant(constant: CGFloat) {
        for constraint in self.constraints {
            if (constraint.isKind(of: NSLayoutConstraint.self)) {
                if (constraint.firstAttribute == .width && constraint.isActive && constraint.firstItem === self) {
                    constraint.constant = constant
                }
            }
        }
    }
    
    func nsWidthEqualSupperview() -> NSLayoutConstraint? {
        if let supperview = self.superview {
            for constraint in supperview.constraints {
                if ((constraint.firstItem === self || constraint.secondItem === self) && (constraint.firstAttribute == .width || constraint.secondAttribute == .width) && constraint.isActive) {
                    return constraint;
                }
            }
        }
        return nil;
    }

    func nsLeft() -> NSLayoutConstraint? {
        if let supperview = self.superview {
            for constraint in supperview.constraints {
                if ((constraint.firstItem === self && constraint.firstAttribute == .leading) || (constraint.secondItem === self && constraint.secondAttribute == .leading) && constraint.isActive) {
                    return constraint;
                }
            }
        }
        return nil;
    }
    
    func nsTop() -> NSLayoutConstraint? {
        if let supperview = self.superview {
            for constraint in supperview.constraints {
                if ((constraint.firstItem === self && constraint.firstAttribute == .top) || (constraint.secondItem === self && constraint.secondAttribute == .top) && constraint.isActive) {
                    return constraint;
                }
            }
        }
        return nil;
    }
    
    func nsRight() -> NSLayoutConstraint? {
        if let supperview = self.superview {
            for constraint in supperview.constraints {
                if ((constraint.firstItem === self && constraint.firstAttribute == .trailing) || (constraint.secondItem === self && constraint.secondAttribute == .trailing) && constraint.isActive) {
                    return constraint;
                }
            }
        }
        return nil;
    }
    
    func nsBottom() -> NSLayoutConstraint? {
        if let supperview = self.superview {
            for constraint in supperview.constraints {
                if ((constraint.firstItem === self && constraint.firstAttribute == .bottom) || (constraint.secondItem === self && constraint.secondAttribute == .bottom) && constraint.isActive) {
                    return constraint;
                }
            }
        }
        return nil;
    }
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {
    static func instantiateFromXib() -> Self {
        let dynamicMetatype = Self.self
        let bundle = Bundle(for: dynamicMetatype)
        let nib = UINib(nibName: "\(dynamicMetatype)", bundle: bundle)

        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {

            fatalError("Could not load view from nib file.")
        }
        return view
    }
}

private typealias SubviewTreeModifier = (() -> UIView)

public struct AppearanceOptions: OptionSet {
    
    public static let overlay = AppearanceOptions(rawValue: 1 << 0)
    public static let useAutoresize = AppearanceOptions(rawValue: 1 << 1)
    
    public let rawValue: UInt
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
}

extension UIView {
    
    fileprivate func addSubviewUsingOptions(_ options: AppearanceOptions, modifier: SubviewTreeModifier) {
        let subview = modifier()
        if options.union(.overlay) == .overlay {
            if options.union(.useAutoresize) != .useAutoresize {
                subview.translatesAutoresizingMaskIntoConstraints = false
                
                if #available(iOS 11.0, *) {
                    subview.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
                    subview.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
                    subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
                    subview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
                } else {
                    let views = dictionaryOfNames([subview])
                    
                    let horisontalConstraints = NSLayoutConstraint.constraints(
                        withVisualFormat: "|[subview]|",
                        options: [],
                        metrics: nil,
                        views: views
                    )
                    addConstraints(horisontalConstraints)
                    
                    let verticalConstraints = NSLayoutConstraint.constraints(
                        withVisualFormat: "V:|[subview]|",
                        options: [],
                        metrics: nil,
                        views: views
                    )
                    addConstraints(verticalConstraints)
                }
            } else {
                frame = bounds
                subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            }
        }
    }
    
    fileprivate func dictionaryOfNames(_ views: [UIView]) -> [String: UIView] {
        var container = [String: UIView]()
        for (_, value) in views.enumerated() {
            container["subview"] = value
        }
        return container
    }
    
    // MARK: - Interface methods
    
    public func addSubview(_ subview: UIView, options: AppearanceOptions) {
        if subview.superview == self {
            return
        }
        addSubviewUsingOptions(options) { [weak self] in
            self?.addSubview(subview)
            return subview
        }
    }
    
    public func insertSubview(_ subview: UIView, index: Int, options: AppearanceOptions) {
        if subview.superview == self {
            return
        }
        addSubviewUsingOptions(options) { [weak self] in
            self?.insertSubview(subview, at: index)
            return subview
        }
    }
}

extension UIView {
    func removeAllConstraints() {
        self.removeConstraints(self.constraints)
    }
}

@IBDesignable
extension UIView {
    public static func createFromXIB () -> Self {
        let nibName = String(describing: self)
        let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first
        return view as! Self
    }
    var xValue: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newValue) {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var xRight: CGFloat {
        get {
            return self.xValue + self.width
        }
    }
    var yValue: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newValue) {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    var yBottom: CGFloat {
        get {
            return self.yValue + self.height
        }
    }
    
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set(newValue) {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        set(newValue) {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    var height: CGFloat {
        get {
            return self.size.height
        }
        set(newValue) {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var width: CGFloat {
        get {
            return self.size.width
        }
        set(newValue) {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func customizeView(color: UIColor, cornerRadius: CGFloat) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
        
        subView.layer.cornerRadius = cornerRadius
        subView.layer.masksToBounds = true
        subView.clipsToBounds = true
    }
}
