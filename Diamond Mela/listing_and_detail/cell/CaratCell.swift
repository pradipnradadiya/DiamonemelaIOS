import UIKit

class CaratCell: UICollectionViewCell {
    
    @IBOutlet weak var btnCarat: UIButtonX!
   var actionClick: (() -> Void)? = nil
    
    var caratData: [String] = [] {
        didSet{
            
            
            //retrieve from UserDefaults
            if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
                let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
                if theme == BLACK_THEME_KEY{
                    if caratData.first! == ProductDetailVC.caratValue{
                        btnCarat.borderColor = UIColor.selectButtonColor
                        btnCarat.borderWidth = 1
                        btnCarat.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnCarat.backgroundColor = UIColor.dmlBlack
                    }else{
                        btnCarat.borderColor = UIColor.transactionLineColorBlack
                        btnCarat.borderWidth = 1
                        btnCarat.setTitleColor(UIColor.dmlWhite, for: .normal)
                        btnCarat.backgroundColor = UIColor.dmlBlack
                        
                    }
                }else if theme == WHITE_THEME_KEY{
                    if caratData.first! == ProductDetailVC.caratValue{
                        btnCarat.borderColor = UIColor.selectButtonColor
                        btnCarat.borderWidth = 1
                        btnCarat.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnCarat.backgroundColor = UIColor.dmlWhite
                    }else{
                        btnCarat.borderColor = UIColor.unSelectButtonColor
                        btnCarat.borderWidth = 1
                        btnCarat.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        btnCarat.backgroundColor = UIColor.dmlWhite
                        
                    }
                    
                }else{
                    if caratData.first! == ProductDetailVC.caratValue{
                        btnCarat.borderColor = UIColor.selectButtonColor
                        btnCarat.borderWidth = 1
                        btnCarat.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnCarat.backgroundColor = UIColor.dmlWhite
                    }else{
                        btnCarat.borderColor = UIColor.unSelectButtonColor
                        btnCarat.borderWidth = 1
                        btnCarat.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        btnCarat.backgroundColor = UIColor.dmlWhite
                        
                    }
                }
                
            }
            
            
            
            
        btnCarat.setTitle(caratData.first!, for: .normal)
            
        }
    }
    
    @IBAction func btnCarat(_ sender: Any) {
        actionClick?()
    }
}
