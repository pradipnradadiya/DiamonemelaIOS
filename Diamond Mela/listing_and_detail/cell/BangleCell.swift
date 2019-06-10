import UIKit

class BangleCell: UICollectionViewCell {
    var actionClick: (() -> Void)? = nil
    @IBOutlet weak var btnBangle: UIButtonX!
    var bangleData:ProductDetailItem.BangleSize?{
        didSet{
            
            if bangleData?.label == ProductDetailVC.bangleProductValue{
                btnBangle.borderColor = UIColor.selectButtonColor
                btnBangle.borderWidth = 1
                btnBangle.setTitleColor(UIColor.selectButtonColor, for: .normal)
            }else{
                btnBangle.borderColor = UIColor.unSelectButtonColor
                btnBangle.borderWidth = 1
                btnBangle.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                
            }
            
            btnBangle.setTitle(bangleData?.label, for: .normal)
            
            
        }
    }
    
    @IBAction func btnBangleClick(_ sender: Any) {
        actionClick?()
    }
}
