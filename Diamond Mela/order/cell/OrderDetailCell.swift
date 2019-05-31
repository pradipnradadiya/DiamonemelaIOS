import UIKit

class OrderDetailCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQtyPrice: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblProductType: UILabel!
    @IBOutlet weak var lblStoneDetail: UILabel!
    @IBOutlet weak var lblMetalDetail: UILabel!
    @IBOutlet weak var lblSku: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    var orderDetailData:OrderDetailItem.Order_item?{
        didSet{
            
            lblPrice.text=orderDetailData?.product_rawtotal
            lblQtyPrice.text=orderDetailData?.product_price
            lblQty.text=orderDetailData?.product_qty
            lblProductType.text=orderDetailData?.product_type
            lblStoneDetail.text=orderDetailData?.product_stoneweight
            lblMetalDetail.text=orderDetailData?.product_metalweight
            lblSku.text=orderDetailData?.product_sku
            lblName.text=orderDetailData?.product_name
            
            imgProduct.sd_setImage(with: URL(string: (orderDetailData?.product_img)!), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
            
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
