import UIKit

@IBDesignable
class ViewBlackwhite: UIView {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //retrieve from UserDefaults
        if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
            let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
            if theme == BLACK_THEME_KEY{
                self.backgroundColor=UIColor.dmlWhite
            }else if theme == WHITE_THEME_KEY{
                self.backgroundColor=UIColor.dmlBlack
            }else{
                self.backgroundColor=UIColor.dmlBlack
            }
            
        }
        
    }
  
}
