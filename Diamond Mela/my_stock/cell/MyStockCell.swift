import UIKit

class MyStockCell: UICollectionViewCell {
    
    @IBOutlet weak var lblGold: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSku: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    var actionBlockSaleProduct: (() -> Void)? = nil
    
    var myStockData:MyStockItem.Data?{
        didSet{
            imgProduct.sd_setImage(with: URL(string: (myStockData?.image)!), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
            
            lblName.text = myStockData?.sku
            lblSku.text = myStockData?.sku
            lblPrice.text = priceFormat2("\(myStockData?.price ?? "")")
            lblGold.text = myStockData?.metal_quality
        }
    }
    
    @IBAction func btnSale(_ sender: Any) {
        actionBlockSaleProduct?()
    }
}
