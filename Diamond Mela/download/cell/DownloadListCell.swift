import UIKit

class DownloadListCell: UITableViewCell {

    
    var actionBlockDelete: (() -> Void)? = nil
    var actionBlockDownload: (() -> Void)? = nil
    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    var downloadData:DownloadItem.Data?{
        didSet{
            
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

    @IBAction func btnDownload(_ sender: Any) {
        self.actionBlockDownload?()
    }
    @IBAction func btnDelete(_ sender: Any) {
        self.actionBlockDelete?()
    }
}
