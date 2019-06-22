import UIKit

class PendentCell: UICollectionViewCell {
    var actionClick: (() -> Void)? = nil
    @IBOutlet weak var btnPendent: UIButtonX!
    var pendentData:ProductDetailItem.PendentEarring?{
        didSet{
            
            if pendentData?.label == ProductDetailVC.pendentValue{
                btnPendent.borderColor = UIColor.selectButtonColor
                btnPendent.borderWidth = 1
                btnPendent.setTitleColor(UIColor.selectButtonColor, for: .normal)
            }else{
                btnPendent.borderColor = UIColor.unSelectButtonColor
                btnPendent.borderWidth = 1
                btnPendent.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                
            }
            
            btnPendent.setTitle(pendentData?.label, for: .normal)
            
        }
        
    }
    
    @IBAction func btnPendentClick(_ sender: Any) {
        actionClick?()
    }
    
}
