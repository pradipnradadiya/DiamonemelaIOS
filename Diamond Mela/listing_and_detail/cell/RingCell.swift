import UIKit

class RingCell: UICollectionViewCell {
    
    @IBOutlet weak var btnRingSize: UIButtonX!
    
//    var data = ProductDetailVC()
    
    var actionClick: (() -> Void)? = nil
    var ringSize : ProductDetailItem.Ringsize?{
        didSet{
            if ringSize?.title == ProductDetailVC.ringValue{
                btnRingSize.borderColor = UIColor.selectButtonColor
                btnRingSize.borderWidth = 1
                btnRingSize.setTitleColor(UIColor.selectButtonColor, for: .normal)
                ProductDetailVC.ringOptionId = (ringSize?.option_id)!
                ProductDetailVC.ringOptionTypeId = (ringSize?.option_type_id)!
            }else{
                btnRingSize.borderColor = UIColor.unSelectButtonColor
                btnRingSize.borderWidth = 1
                btnRingSize.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                
            }
            
            btnRingSize.setTitle(ringSize?.title, for: .normal)
            
            
        }
    }
    
    @IBAction func btnRingClick(_ sender: Any) {
        actionClick?()
    }
    
}
