import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var imgBannerImage: UIImageView!
    var bannerData:BannerItem.Slider_image?{
        didSet{
            imgBannerImage.sd_setImage(with: URL(string: "\(IMAGE_URL)\(bannerData?.image_url! ?? "")"), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
        }
    }
}
