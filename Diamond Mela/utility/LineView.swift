import UIKit

@IBDesignable
class LineView: UIView {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //retrieve from UserDefaults
        if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
            let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
            if theme == BLACK_THEME_KEY{
                self.backgroundColor=UIColor.transactionLineColorBlack
            }else if theme == WHITE_THEME_KEY{
                self.backgroundColor=UIColor.transactionLineColorWhite
            }else{
                self.backgroundColor=UIColor.transactionLineColorWhite
            }
            
        }
        
    }
    
    
    
}
