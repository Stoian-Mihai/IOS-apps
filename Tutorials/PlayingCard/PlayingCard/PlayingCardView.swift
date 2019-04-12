//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Mihai Stoian on 11/04/2019.
//  Copyright © 2019 Mihai Stoian. All rights reserved.
//

import UIKit
@IBDesignable // Allows the storyboard to update and see the cards there
class PlayingCardView: UIView {
    
    //setNeedsDisplay  = redraw
    //In other words setNeedsDisplay() - calls draw function / setNeedsLayout - calls layoutSubviews
    //We need to use this because when we turn the phone in landscape mode we need te redraw and reposition all
    var rank: Int = 5 { didSet{setNeedsDisplay(); setNeedsLayout() }}
    var suit: String = "♥" { didSet{setNeedsDisplay(); setNeedsLayout() }}
    var isFaceUp: Bool = true { didSet{setNeedsDisplay(); setNeedsLayout() }}
    
    func updateViewWithCard(rank: Int, suit: String, isFaceUp: Bool){
        self.rank = rank
        self.suit = suit
        self.isFaceUp = isFaceUp
    }
    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString{
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font) // Scaling the font for the users bigger font settings
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center // putting the text in the center - we don't want to display the text in the left and the emoji in the middle
        return NSAttributedString(string: string, attributes: [.paragraphStyle:paragraphStyle, .font:font]) // returning the NSAtrString with the attributes that we created font(scaling to user settings) and paragraphStyle(centered text)
    }
    
    private var cornerString: NSAttributedString{
        return centeredAttributedString(rankString + "\n" + suit, fontSize: cornerFontSIze) //the string to display in the corner labels
    }
    private lazy var upperLeftCornerLabel = createCornerLabel()
    private lazy var lowerRightCornerLabel = createCornerLabel()
    
    private func createCornerLabel() -> UILabel{ // This function creates a label with inf number of lines and addes the label to the view
        let label = UILabel()
        label.numberOfLines = 0 // 0 means: use as many lines as you want label!
        addSubview(label)
        return label
    }
    
    private func configureCornerLabel(_ label: UILabel){
        label.attributedText = cornerString
        label.frame.size = CGSize.zero // clearing the size
        label.sizeToFit() // this method sizez the label to fit the text
        label.isHidden = !isFaceUp
    }
    
    override func layoutSubviews() { // We have to overload this function to configure the layout - this function is automatic called
        super.layoutSubviews()
        configureCornerLabel(upperLeftCornerLabel) // setting the string to the label
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset) //Positioning the label in upper left/ The offset moves the label a verry little bit to the right, because it will intersect with the edges of the view
        
        
        configureCornerLabel(lowerRightCornerLabel) // setting the string to the label
        
        lowerRightCornerLabel.transform = CGAffineTransform.identity
            .translatedBy(x: lowerRightCornerLabel.frame.size.width, y: lowerRightCornerLabel.frame.size.height) // we need to translate to the lower right because when we rotate it, it rotates by the origin point
            .rotated(by: CGFloat.pi) // rotating the label because we want it upside down
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY) // Positioning the label to lower right corner, but now the label will be drawn outside of our view, because the origin point(top left) of out label is the lower right corner point
            .offsetBy(dx: -cornerOffset, dy: -cornerOffset) // moving the drawing origin besides the corner
            .offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height) // move the drawing orign to the upper left corner of our label
        
        
        
    }
    //MARK: draw
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
        if isFaceUp{
            if let faceCardImage = UIImage(named: rankString + suit){ //adding an image to the view
                faceCardImage.draw(in: bounds.zoom(by: SizeRatio.faceCardImageSizeToBoundsSize))
            }
        } else {
            if let cardBackImage = UIImage(named:"cardback"){
                cardBackImage.draw(in: bounds)
            }
        }
    }
   

}

// This extensiton contains all the constants we use
extension PlayingCardView{
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeithgt: CGFloat = 0.06
        static let cornerOffsetTOCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    private var cornerRadius: CGFloat{
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeithgt
    }
    private var cornerOffset: CGFloat{
        return cornerRadius * SizeRatio.cornerOffsetTOCornerRadius
    }
    private var cornerFontSIze: CGFloat{
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    private var rankString: String{
        switch rank{
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
}

extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

// Moves a point by a certain offset
extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}

/// OUT OF ORDER
/*
 // this are test functions/ we draw a circle with contex and with bezier path
 func drawCircleWithContex(){
 if let contex = UIGraphicsGetCurrentContext(){
 contex.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
 contex.setLineWidth(5.0)
 UIColor.green.setFill()
 UIColor.red.setStroke()
 contex.strokePath()
 contex.fillPath()
 }
 }
 func drawCircleWithBezierPatch(){
 let path = UIBezierPath()
 path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
 path.lineWidth = 5.0
 UIColor.green.setFill()
 UIColor.red.setStroke()
 path.stroke()
 path.fill()
 }
 */
