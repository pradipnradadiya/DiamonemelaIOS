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
             lblName.text="\(orderDetailData?.product_name ?? "")"
            
            
            lblPrice.text="\(priceFormat2("\(orderDetailData?.product_rawtotal ?? "")"))"
            
            lblQtyPrice.text="\(priceFormat2("\(orderDetailData?.product_price ?? "")"))"
            
            let qty = Int(Float(orderDetailData?.product_qty as! String)!)
            
            lblQty.attributedText="QTY: \(qty)".withBoldText(text: "QTY:")
            
            lblProductType.attributedText="Product Type: \(orderDetailData?.product_type ?? "")".withBoldText(text: "Product Type:")
            lblStoneDetail.attributedText="Stone Weight: \(orderDetailData?.product_stoneweight ?? "")".withBoldText(text: "Stone Weight:")
            lblMetalDetail.attributedText="Metal Detail: \(orderDetailData?.product_metalweight ?? "")".withBoldText(text: "Metal Detail:")
            lblSku.attributedText="Sku: \(orderDetailData?.product_sku ?? "")".withBoldText(text: "Sku:")
                       
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


//extension String {
//    func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
//        let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
//        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
//        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
//        let range = (self as NSString).range(of: text)
//        fullString.addAttributes(boldFontAttribute, range: range)
//        return fullString
//    }}
