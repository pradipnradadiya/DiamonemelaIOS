import UIKit
import JVFloatLabeledTextField

@IBDesignable
class JTextfiled: JVFloatLabeledTextField {
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //retrieve from UserDefaults
        if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
            let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
            if theme == BLACK_THEME_KEY{
                self.floatingLabelTextColor = UIColor.dmlWhite
                self.floatingLabelActiveTextColor = UIColor.dmlWhite
                self.placeholderColor = UIColor.dmlWhite
                self.textColor = UIColor.dmlWhite
                
            }else if theme == WHITE_THEME_KEY{
                self.floatingLabelTextColor = UIColor.dmlBlack
                self.floatingLabelActiveTextColor = UIColor.dmlBlack
                self.placeholderColor = UIColor.dmlBlack
                self.textColor = UIColor.dmlBlack
                
            }else{
                self.floatingLabelTextColor = UIColor.dmlBlack
                self.floatingLabelActiveTextColor = UIColor.dmlBlack
                self.placeholderColor = UIColor.dmlBlack
                self.textColor = UIColor.dmlBlack
                
            }
        }
    }
}
