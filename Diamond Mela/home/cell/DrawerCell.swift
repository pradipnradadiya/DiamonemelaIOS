import UIKit

class DrawerCell: UITableViewCell {
var actionBlockClick: (() -> Void)? = nil
    @IBOutlet weak var lblTitle: UILabel!
    var headerData:HeaderItem.Data?{
        didSet{
            lblTitle.text=headerData?.name!.uppercased()
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

    @IBAction func btnClick(_ sender: Any) {
        actionBlockClick?()
    }
}
