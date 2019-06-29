
import UIKit

@IBDesignable
class BlackWhiteTextLabel: UILabel {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //retrieve from UserDefaults
        if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
            let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
            if theme == BLACK_THEME_KEY{
                self.textColor = UIColor.dmlWhite
            }else if theme == WHITE_THEME_KEY{
                self.textColor = UIColor.dmlBlack
            }else{
               self.textColor = UIColor.dmlBlack
            }
            
        }
        
        
        
        
    }
    
    
    
    @IBInspectable var blacktxtColor: UIColor = UIColor.blackColor() {
        didSet {
            self.textColor = blacktxtColor
        }
    }
    
    
    
    @IBInspectable var whitetxtColor: UIColor = UIColor.whiteColor() {
        didSet {
            self.textColor = whitetxtColor
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var rotationAngle: CGFloat = 0 {
        didSet {
            self.transform = CGAffineTransform(rotationAngle: rotationAngle * .pi / 180)
        }
    }
    
    // MARK: - Shadow Text Properties
    
    @IBInspectable public var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
    @IBInspectable public var shadowColorLayer: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColorLayer.cgColor
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable public var shadowOffsetLayer: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            layer.shadowOffset = shadowOffsetLayer
        }
    }
    

}
