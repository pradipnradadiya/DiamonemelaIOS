import UIKit

class DiamondCell: UICollectionViewCell {
    
    @IBOutlet weak var btnDiamond: UIButtonX!
    
    var diamondData : ProductDetailItem.Stone_clarity?{
        didSet{
            btnDiamond.setTitle(diamondData?.title, for: .normal)
        }
    }
    
}
