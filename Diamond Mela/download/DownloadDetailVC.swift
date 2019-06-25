import UIKit

class DownloadDetailVC: UIViewController {

    @IBOutlet weak var lblDiamond: UILabel!
    @IBOutlet weak var lblGrams: UILabel!
    @IBOutlet weak var lblGold: UILabel!
    @IBOutlet weak var lblSKU: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    var downloadItem : DownloadItem.Data?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDownloadCartCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblSKU.text = downloadItem?.sku
        
        lblGold.text = downloadItem?.carat
        
        lblGrams.text = "\(downloadItem?.metalDeatil ?? "") \(downloadItem?.carat ?? "")"
        lblDiamond.text = "\(downloadItem?.stoneDetail ?? "") \(downloadItem?.diamondWeight ?? "")"
        
          imgProduct.sd_setImage(with: URL(string: (downloadItem?.image)!), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
