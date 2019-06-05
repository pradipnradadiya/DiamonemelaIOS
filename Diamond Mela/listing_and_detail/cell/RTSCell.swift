import UIKit

class RTSCell: UICollectionViewCell {
    
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblDiamondWeight: UILabel!
    @IBOutlet weak var lblStone: UILabel!
    @IBOutlet weak var lblMetal: UILabel!
    var categoryId:String = ""
    var rtsData:ProductDetailItem.Rts_slider?{
        didSet{
            
            lblMetal.text=rtsData?.metal_quality_value
            lblStone.text=rtsData?.rts_stone_quality
            lblDiamondWeight.text="\(rtsData?.diamond_weight ?? 0)"
            
        }
    }
    
}
