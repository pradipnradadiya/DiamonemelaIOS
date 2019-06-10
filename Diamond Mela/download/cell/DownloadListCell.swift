import UIKit

class DownloadListCell: UITableViewCell {

    
    var actionBlockDelete: (() -> Void)? = nil
    var actionBlockDownload: (() -> Void)? = nil
    var actionBlockSelect: (() -> Void)? = nil
    
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    var downloadData:DownloadItem.Data?{
        didSet{
            lblPrice.text=priceFormat2("\(downloadData?.price ?? 0)")
            imgProduct.sd_setImage(with: URL(string: (downloadData?.image)!), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
            
            
            if downloadData?.isSelected == true {
                btnSelect.setImage(UIImage(named: "radio-select"), for: .normal)
            }else{
                 btnSelect.setImage(UIImage(named: "radio"), for: .normal)
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
    
    @IBAction func btnSelect(_ sender: Any) {
        self.actionBlockSelect?()
    }
    @IBAction func btnDownload(_ sender: Any) {
        self.actionBlockDownload?()
    }
    @IBAction func btnDelete(_ sender: Any) {
        self.actionBlockDelete?()
    }
}
