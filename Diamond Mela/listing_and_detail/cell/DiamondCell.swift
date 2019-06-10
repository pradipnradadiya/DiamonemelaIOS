import UIKit

class DiamondCell: UICollectionViewCell {
    
    @IBOutlet weak var btnDiamond: UIButtonX!
    var actionClick: (() -> Void)? = nil
    var diamondData : ProductDetailItem.Stone_clarity?{
        didSet{
            
            if diamondData?.title == ProductDetailVC.diamondValue{
                btnDiamond.borderColor = UIColor.selectButtonColor
                btnDiamond.borderWidth = 1
                btnDiamond.setTitleColor(UIColor.selectButtonColor, for: .normal)
            }else{
                btnDiamond.borderColor = UIColor.unSelectButtonColor
                btnDiamond.borderWidth = 1
                btnDiamond.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
            }
            
            btnDiamond.setTitle(diamondData?.title, for: .normal)
        }
    }
    
    @IBAction func btnDiamond(_ sender: Any) {
        actionClick?()
    }
}
