import UIKit

class SliderCell: UICollectionViewCell {
    
    @IBOutlet weak var imgProduct: UIImageView!
    
    
    var slider: [String] = [] {
        didSet{
            imgProduct.sd_setImage(with: URL(string: (slider.first!)), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
            
        }
        
    }
    
}
