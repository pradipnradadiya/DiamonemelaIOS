import UIKit

class RingCell: UICollectionViewCell {
    
    @IBOutlet weak var btnRingSize: UIButtonX!
    
    var ringSize : ProductDetailItem.Ringsize?{
        didSet{
            btnRingSize.setTitle(ringSize?.title, for: .normal)
        }
    }
    
    
}
