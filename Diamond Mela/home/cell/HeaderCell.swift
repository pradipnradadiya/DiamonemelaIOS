import UIKit


class HeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgMenuIcon: UIImageView!
    
    var headerData:HeaderItem.Data?{
        didSet{
            lblTitle.text=headerData?.name
            imgMenuIcon.sd_setImage(with: URL(string: "\(headerData?.icon_img ?? "")"), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
        }
    }
}

