import UIKit

class SliderCell: UICollectionViewCell {
    
    @IBOutlet weak var imgProduct: UIImageView!
    var count:Int = 0
    
    var slider: [String] = [] {
        didSet{
            imgProduct.sd_setImage(with: URL(string: (slider[count])), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
            count += 1
        }
    }
    
}
