import UIKit

class MyCartCell: UITableViewCell {
    
    @IBOutlet weak var lblSku: UILabel!
    
    @IBOutlet weak var btnPlus: UIButtonX!
    @IBOutlet weak var btnMinus: UIButtonX!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblStoneDetail: UILabel!
    @IBOutlet weak var lblMetalDetail: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var imgProduct: UIImageViewX!
    
    var actionBlockRemove: (() -> Void)? = nil
    var actionBlockPlus: (() -> Void)? = nil
    var actionBlockMinus: (() -> Void)? = nil
    
    var myCart:CartProductListItem.Data?{
        didSet{
            lblSku.attributedText = "Sku: \(myCart?.sku ?? "")".withBoldText(text: "Sku:")
            lblQty.text="\(myCart?.qty ?? 0)"
            lblPrice.text=priceFormat2("\(myCart?.price ?? "")")
            lblStoneDetail.attributedText="Stone Detail: \(myCart?.stonedetails ?? "")".withBoldText(text: "Stone Detail:")
            lblMetalDetail.attributedText="Metal Detail: \(myCart?.metaldetails ?? "")".withBoldText(text: "Metal Detail:")
//
            imgProduct.sd_setImage(with: URL(string: (myCart?.image)!), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
            
            
            if myCart?.ringsize != nil{
                lblSize.isHidden = false
                lblSize.attributedText="Ring Size: \(myCart?.ringsize ?? "")".withBoldText(text: "Ring Size:")
            }else if myCart?.bracelets != nil{
                 lblSize.isHidden = false
                lblSize.attributedText="Bracelet Size: \(myCart?.ringsize ?? "")".withBoldText(text: "Bracelet Size:")
            }else if myCart?.bangles != nil{
                 lblSize.isHidden = false
                lblSize.attributedText="Bangle Size: \(myCart?.ringsize ?? "")".withBoldText(text: "Bangle Size:")
            }else if myCart?.pendents != nil{
                 lblSize.isHidden = false
                lblSize.attributedText="Pendent Size: \(myCart?.ringsize ?? "")".withBoldText(text: "Pendent Size:")
            }else{
                lblSize.isHidden = true
            }
            
            
            if myCart?.product_type == "simple" {
                btnPlus.isHidden = true
                btnMinus.isHidden = true
            }else{
                btnPlus.isHidden = false
                btnMinus.isHidden = false
            }
        
            
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

    @IBAction func btnMinus(_ sender: Any) {
         self.actionBlockMinus?()
    }
    @IBAction func btnPlus(_ sender: Any) {
         self.actionBlockPlus?()
    }
    @IBAction func btnRemove(_ sender: Any) {
         self.actionBlockRemove?()
    }
}
