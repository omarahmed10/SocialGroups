import UIKit

extension UIView{
    
    //    MARK:-  corner raduis
    @IBInspectable var cornerRadius: CGFloat{
        get{
            return self.layer.cornerRadius
        }
        
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    //    MARK:- border width
    @IBInspectable var borderWidth: CGFloat{
        get{
            return self.layer.borderWidth
        }
        
        set{
            self.layer.borderWidth = newValue
        }
    }
    
    //    MARK:- border color
    @IBInspectable var borderColor: UIColor?{
        get{
            let color = UIColor(cgColor: self.layer.borderColor!)
            return color
        }
        
        set{
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    //    MARK:- shadow
    @IBInspectable var shadowColor: UIColor?{
        get{
            let color = UIColor(cgColor: self.layer.shadowColor!)
            return color
        }
        
        set{
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowBluring: CGFloat{
        get{
            return self.layer.shadowRadius
        }
        
        set{
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize{
        get{
            return self.layer.shadowOffset
        }
        
        set{
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get{
            return self.layer.shadowOpacity
        }
        
        set{
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var maskShadowToBounds: Bool {
        get{
            return self.layer.masksToBounds
        }
        
        set{
            self.layer.masksToBounds = newValue
        }
    }
    

    
//    //    MARK:-  functions
//    private func setGradient (gradientColors: [CGColor], gradientLocations: [NSNumber]? ) {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = gradientColors
//        
//        if let lLocation  = gradientLocations {
//            gradientLayer.locations = lLocation
//        }
//        
//        gradientLayer.frame = self.bounds
//        
//        self.layer.insertSublayer(gradientLayer, at: 0)
//        self.layoutIfNeeded()
//    }
//    
//    //    private func getBlueGradientViewColors() -> [CGColor] {
//    //        return  [GradientViews.BLUE_GRADIENT_TOP_COLOR.cgColor, GradientViews.BLUE_GRADIENT_BOTTOM_COLOR.cgColor]
//    //    }
//    //
//    //    private func getOrangeGradientViewColors() -> [CGColor]{
//    //        return [GradientViews.ORANGE_GRADIENT_TOP_COLOR.cgColor, GradientViews.ORANGE_GRADIENT_BOTTOM_COLOR.cgColor]
//    //    }
//    //    private func getRedGradientViewColors() -> [CGColor]{
//    //         return [GradientViews.RED_GRADIENT_TOP_COLOR.cgColor, GradientViews.RED_GRADIENT_BOTTOM_COLOR.cgColor]
//    //    }
//    //
//    //    private func getGreenGradientViewColors() -> [CGColor]{
//    //         return [GradientViews.GREEN_GRADIENT_TOP_COLOR.cgColor, GradientViews.GREEN_GRADIENT_BOTTOM_COLOR.cgColor]
//    //    }
//    
//    
//    func setGradient(gradientColorType: GradienColor){
//        switch gradientColorType{
//        case .Main:
//            let mainCGGradientColors = [GradientViews.MAIN_FIRST_CG_COLOR, GradientViews.MAIN_SECOND_CG_COLOR, GradientViews.MAIN_THIRD_CG_COLOR, GradientViews.MAIN_FOURTH_CG_COLOR]
//            setGradient(gradientColors: mainCGGradientColors,gradientLocations: GradientViews.MAIN_GRADIENT_LOCATIONS)
//        case .WhitToBlack:
//            let whitToBlackCGGradientColors = [GradientViews.WHITE_TO_BLACK_FIRST_CG_COLOR, GradientViews.WHITE_TO_BLACK_SECOND_CG_COLOR, GradientViews.WHITE_TO_BLACK_THIRD_CG_COLOR]
//            
//            setGradient(gradientColors: whitToBlackCGGradientColors, gradientLocations: nil)
//        case .LightWhiteToLightGreen:
//            
//            let whitToBlackCGGradientColors = [ GradientViews.LIGHT_WHITE_TO_LIGHT_GREEN_SECOND_CG_COLOR,GradientViews.LIGHT_WHITE_TO_LIGHT_GREEN_FIRST_CG_COLOR]
//            
//            setGradient(gradientColors: whitToBlackCGGradientColors, gradientLocations: nil)
//        case .LightBlue:
//            let lightBlueCGGradientColors = [ GradientViews.LIGHT_BLUE_FIRST_CG_COLOR,GradientViews.LIGHT_BLUE_SECOND_CG_COLOR]
//            setGradient(gradientColors: lightBlueCGGradientColors, gradientLocations: GradientViews.LIGHT_BLUE_GRADIENT_LOCATIONS)
//        case .LightWhite:
//            let lightWhiteCGGradientColors = [ GradientViews.LIGHT_WHITE_SECOND_COLOR,GradientViews.LIGHT_WHITE_FIRST_COLOR]
//            setGradient(gradientColors: lightWhiteCGGradientColors, gradientLocations: GradientViews.LIGHT_WHITE_GRADIENT_LOCATIONS)
//        case .White:
//            let whiteCGGradientColors = [ GradientViews.WHITE_SECOND_COLOR, GradientViews.WHITE_FIRST_COLOR]
//            setGradient(gradientColors: whiteCGGradientColors, gradientLocations: GradientViews.WHITE_GRADIENT_LOCATIONS)
//        case .ModernWhite:
//            let modernWhiteCGGradientColors = [ GradientViews.MODERN_WHITE_SECOND_COLOR, GradientViews.MODERN_WHITE_FIRST_COLOR]
//            setGradient(gradientColors: modernWhiteCGGradientColors, gradientLocations: GradientViews.MODERN_WHITE_GRADIENT_LOCATIONS)
//        case .ModernBlue:
//            let modernBlueCGGradientColors = [ GradientViews.MODERN_BLUE_THIRD_COLOR, GradientViews.MODERN_BLUE_SECOND_COLOR, GradientViews.MODERN_BLUE_FIRST_COLOR]
//            setGradient(gradientColors: modernBlueCGGradientColors, gradientLocations: GradientViews.MODERN_BLUE_GRADIENT_LOCATIONS)
//            self.alpha = 0.24
//            //        case .Blue:
//            //            self.setGradient(gradientColors: self.getBlueGradientViewColors(), gradientLocations: GradientViews.BLUE_GRADIENT_LOCATIONS)
//            //
//            //        case .Orange:
//            //            self.setGradient(gradientColors: self.getOrangeGradientViewColors(), gradientLocations: GradientViews.ORANGE_GRADIENT_LOCATIONS)
//            //        case .Red:
//            //            self.setGradient(gradientColors: self.getRedGradientViewColors(), gradientLocations: GradientViews.RED_GRADIENT_LOCATIONS)
//            //        case .Green:
//            //            self.setGradient(gradientColors: self.getGreenGradientViewColors(), gradientLocations: GradientViews.GREEN_GRADIENT_LOCATIONS)
//            
//        }
//    }
//    
//    func fadeIn() {
//        // Move our fade out code from earlier
//        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
//            self.alpha = 1.0
//        }, completion: nil)
//    }
//    
//    
//    func fadeOut() {
//        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//            self.alpha = 0.0
//        }, completion: nil)
//    }
//    
//    
//    
//    func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
//        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
//            self.alpha = 1.0
//        }, completion: completion)
//        
//    }
//    
//    func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
//        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
//            self.alpha = 0.0
//        }, completion: completion)
//    }
//    
//    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
//        layer.masksToBounds = false
//        layer.shadowColor = color.cgColor
//        layer.shadowOpacity = opacity
//        layer.shadowOffset = offSet
//        layer.shadowRadius = radius
//        print("drop shadow \(self.bounds)")
//        layer.shadowPath = UIBezierPath(rect:self.bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
}



@IBDesignable
class GradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map{$0.cgColor}
//        layer.locations = [0.2,0.0]
    }
}
