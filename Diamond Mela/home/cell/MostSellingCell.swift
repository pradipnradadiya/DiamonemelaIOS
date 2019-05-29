import UIKit

class MostSellingCell: UICollectionViewCell {
    
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgMostSellingProduct: UIImageView!
    var mostSellingData:MostSellingProductItem.Data?{
        didSet{
            lblProductName.text=mostSellingData?.name
            lblProductPrice.text=mostSellingData?.custom_price
            
            imgMostSellingProduct.sd_setImage(with: URL(string: "\(IMAGE_URL)catalog/product\(mostSellingData?.thumbnail ?? "")"), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
        }
    }
}
