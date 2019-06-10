import UIKit

class BraceletsCell: UICollectionViewCell {
    var actionClick: (() -> Void)? = nil
    @IBOutlet weak var btnBracelet: UIButtonX!
    
    var braceletData:ProductDetailItem.BraceletsSize?{
        didSet{
            if braceletData?.label == ProductDetailVC.braceletProductValue{
                btnBracelet.borderColor = UIColor.selectButtonColor
                btnBracelet.borderWidth = 1
                btnBracelet.setTitleColor(UIColor.selectButtonColor, for: .normal)
            }else{
                btnBracelet.borderColor = UIColor.unSelectButtonColor
                btnBracelet.borderWidth = 1
                btnBracelet.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                
            }
            
            btnBracelet.setTitle(braceletData?.label, for: .normal)
        }
    }
    @IBAction func btnBraceletClick(_ sender: Any) {
        actionClick?()
    }
}
