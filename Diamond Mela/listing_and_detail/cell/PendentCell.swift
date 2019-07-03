import UIKit

class PendentCell: UICollectionViewCell {
    var actionClick: (() -> Void)? = nil
    @IBOutlet weak var btnPendent: UIButtonX!
    var pendentData:ProductDetailItem.PendentEarring?{
        didSet{
            
            
            //retrieve from UserDefaults
            if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
                let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
                if theme == BLACK_THEME_KEY{
                    if pendentData?.label == ProductDetailVC.pendentValue{
                        btnPendent.borderColor = UIColor.selectButtonColor
                        btnPendent.borderWidth = 1
                        btnPendent.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnPendent.backgroundColor = UIColor.dmlBlack
                    }else{
                        btnPendent.borderColor = UIColor.transactionLineColorBlack
                        btnPendent.borderWidth = 1
                        btnPendent.setTitleColor(UIColor.dmlWhite, for: .normal)
                        btnPendent.backgroundColor = UIColor.dmlBlack
                        
                    }
                }else if theme == WHITE_THEME_KEY{
                    
                    if pendentData?.label == ProductDetailVC.pendentValue{
                        btnPendent.borderColor = UIColor.selectButtonColor
                        btnPendent.borderWidth = 1
                        btnPendent.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnPendent.backgroundColor = UIColor.dmlWhite
                    }else{
                        btnPendent.borderColor = UIColor.unSelectButtonColor
                        btnPendent.borderWidth = 1
                        btnPendent.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        btnPendent.backgroundColor = UIColor.dmlWhite
                        
                    }
                    
                }else{
                    if pendentData?.label == ProductDetailVC.pendentValue{
                        btnPendent.borderColor = UIColor.selectButtonColor
                        btnPendent.borderWidth = 1
                        btnPendent.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnPendent.backgroundColor = UIColor.dmlWhite
                    }else{
                        btnPendent.borderColor = UIColor.unSelectButtonColor
                        btnPendent.borderWidth = 1
                        btnPendent.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        btnPendent.backgroundColor = UIColor.dmlWhite
                        
                    }
                }
                
            }
            
            
            
            
            btnPendent.setTitle(pendentData?.label, for: .normal)
            
        }
        
    }
    
    @IBAction func btnPendentClick(_ sender: Any) {
        actionClick?()
    }
    
}
