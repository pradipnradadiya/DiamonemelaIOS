import UIKit

class BraceletsCell: UICollectionViewCell {
    var actionClick: (() -> Void)? = nil
    @IBOutlet weak var btnBracelet: UIButtonX!
    
    var braceletData:ProductDetailItem.BraceletsSize?{
        didSet{
            
            
            //retrieve from UserDefaults
            if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
                let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
                if theme == BLACK_THEME_KEY{
                    if braceletData?.label == ProductDetailVC.braceletProductValue{
                        btnBracelet.borderColor = UIColor.selectButtonColor
                        btnBracelet.borderWidth = 1
                        btnBracelet.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnBracelet.backgroundColor = UIColor.dmlBlack
                    }else{
                        btnBracelet.borderColor = UIColor.transactionLineColorBlack
                        btnBracelet.borderWidth = 1
                        btnBracelet.setTitleColor(UIColor.dmlWhite, for: .normal)
                        btnBracelet.backgroundColor = UIColor.dmlBlack
                    }
                }else if theme == WHITE_THEME_KEY{
                    if braceletData?.label == ProductDetailVC.braceletProductValue{
                        btnBracelet.borderColor = UIColor.selectButtonColor
                        btnBracelet.borderWidth = 1
                        btnBracelet.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnBracelet.backgroundColor = UIColor.dmlWhite
                    }else{
                        btnBracelet.borderColor = UIColor.unSelectButtonColor
                        btnBracelet.borderWidth = 1
                        btnBracelet.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        btnBracelet.backgroundColor = UIColor.dmlWhite
                    }
                    
                }else{
                    if braceletData?.label == ProductDetailVC.braceletProductValue{
                        btnBracelet.borderColor = UIColor.selectButtonColor
                        btnBracelet.borderWidth = 1
                        btnBracelet.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnBracelet.backgroundColor = UIColor.dmlWhite
                    }else{
                        btnBracelet.borderColor = UIColor.unSelectButtonColor
                        btnBracelet.borderWidth = 1
                        btnBracelet.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        btnBracelet.backgroundColor = UIColor.dmlWhite
                    }
                }
                
            }
            
            
            
            
            btnBracelet.setTitle(braceletData?.label, for: .normal)
            
            
        }
    }
    @IBAction func btnBraceletClick(_ sender: Any) {
        actionClick?()
    }
}
