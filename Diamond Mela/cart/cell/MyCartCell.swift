import UIKit

class MyCartCell: UITableViewCell {
    
    @IBOutlet weak var lblSku: UILabel!
    
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
            lblQty.text="\(myCart?.qty ?? 0)"
            lblPrice.text=priceFormat2("\(myCart?.price ?? "")")
            lblStoneDetail.text=myCart?.stonedetails
            lblMetalDetail.text=myCart?.metaldetails
//            lblSize.text=myCart?.ringsize
            imgProduct.sd_setImage(with: URL(string: (myCart?.image)!), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
            
            
            
            
            
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
