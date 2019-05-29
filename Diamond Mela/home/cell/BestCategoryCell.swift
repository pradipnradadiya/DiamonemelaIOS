import UIKit

class BestCategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var imgTitle: UILabel!
    @IBOutlet weak var imgCategoryIcon: UIImageView!
    var bestCategoryData:HeaderItem.Data?{
        didSet{
            imgTitle.text=bestCategoryData?.name
            imgCategoryIcon.sd_setImage(with: URL(string: "\(bestCategoryData?.category_img ?? "")"), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
        
        }
        
    }
    
}
