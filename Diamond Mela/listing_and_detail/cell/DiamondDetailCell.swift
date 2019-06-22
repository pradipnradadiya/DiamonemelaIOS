import UIKit

class DiamondDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblEstimatedValue: UILabel!
    @IBOutlet weak var lblCaratRate: UILabel!
    @IBOutlet weak var lblTotalWeight: UILabel!
    @IBOutlet weak var lblPieces: UILabel!
    @IBOutlet weak var lblQuality: UILabel!
    @IBOutlet weak var lblSetting: UILabel!
    @IBOutlet weak var lblShape: UILabel!
    @IBOutlet weak var lblDiamondIndex: UILabel!
    
    
    
    var diamondDetail : ProductDetailItem.Diamonddetails?{
        didSet{
            
            lblShape.text=diamondDetail?.shape
            lblSetting.text=diamondDetail?.setting
            lblQuality.text=diamondDetail?.quality
            lblPieces.text=diamondDetail?.pieces
            lblTotalWeight.text=diamondDetail?.totalweight
            lblCaratRate.text=diamondDetail?.caratrate
            lblEstimatedValue.text=diamondDetail?.estimatedprice
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
