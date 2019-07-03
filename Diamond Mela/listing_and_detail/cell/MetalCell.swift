import UIKit

class MetalCell: UICollectionViewCell {
    
    @IBOutlet weak var btnMetal: UIButton!
    @IBOutlet weak var viewBorder: UIViewX!
    
    var actionClick: (() -> Void)? = nil
    
    var metalData: [String] = [] {
        didSet{
            
            //retrieve from UserDefaults
            if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
                let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
                if theme == BLACK_THEME_KEY{
                    if metalData.first! == ProductDetailVC.metalValue{
                        viewBorder.borderColor = UIColor.selectButtonColor
                        viewBorder.borderWidth = 1
                        btnMetal.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        viewBorder.backgroundColor = UIColor.dmlBlack
                    }else{
                        viewBorder.borderColor = UIColor.transactionLineColorBlack
                        viewBorder.borderWidth = 1
                        btnMetal.setTitleColor(UIColor.dmlWhite, for: .normal)
                        viewBorder.backgroundColor = UIColor.dmlBlack
                    }
                }else if theme == WHITE_THEME_KEY{
                    if metalData.first! == ProductDetailVC.metalValue{
                        viewBorder.borderColor = UIColor.selectButtonColor
                        viewBorder.borderWidth = 1
                        btnMetal.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        viewBorder.backgroundColor = UIColor.dmlWhite
                    }else{
                        viewBorder.borderColor = UIColor.unSelectButtonColor
                        viewBorder.borderWidth = 1
                        btnMetal.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        viewBorder.backgroundColor = UIColor.dmlWhite
                    }
                }else{
                    if metalData.first! == ProductDetailVC.metalValue{
                        viewBorder.borderColor = UIColor.selectButtonColor
                        viewBorder.borderWidth = 1
                        btnMetal.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        viewBorder.backgroundColor = UIColor.dmlWhite
                    }else{
                        viewBorder.borderColor = UIColor.unSelectButtonColor
                        viewBorder.borderWidth = 1
                        btnMetal.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        viewBorder.backgroundColor = UIColor.dmlWhite
                    }
                }
                
            }
            
            
            
            
            
            
            
            btnMetal.setTitle(metalData.first!, for: .normal)
            
        }
    }
    
    @IBAction func btnMetal(_ sender: Any) {
        actionClick?()
    }
}
