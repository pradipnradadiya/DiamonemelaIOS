import UIKit

class MetalCell: UICollectionViewCell {
    
    @IBOutlet weak var btnMetal: UIButton!
    @IBOutlet weak var viewBorder: UIViewX!
    
    var actionClick: (() -> Void)? = nil
    
    var metalData: [String] = [] {
        didSet{
            if metalData.first! == ProductDetailVC.metalValue{
                viewBorder.borderColor = UIColor.selectButtonColor
                viewBorder.borderWidth = 1
                btnMetal.setTitleColor(UIColor.selectButtonColor, for: .normal)
            }else{
                viewBorder.borderColor = UIColor.unSelectButtonColor
                viewBorder.borderWidth = 1
                btnMetal.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                
            }
            
            btnMetal.setTitle(metalData.first!, for: .normal)
            
        }
    }
    
    @IBAction func btnMetal(_ sender: Any) {
        actionClick?()
    }
}
