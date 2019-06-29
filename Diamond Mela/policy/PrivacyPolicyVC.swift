import UIKit
import ObjectMapper
import RappleProgressHUD

class PrivacyPolicyVC: UIViewController {

    @IBOutlet weak var tfPolicy: UITextView!
    @IBOutlet weak var viewPrivacy: UIView!
    @IBOutlet weak var viewReturn: UIView!
    @IBOutlet weak var viewShipping: UIView!
    var policyType:String="shipping"
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDownloadCartCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPolicy()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCart(_ sender: Any) {
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        let search = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC
        navigationController?.pushViewController(search!, animated: true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPrivacyPolicy(_ sender: Any) {
        policyType="privacy"
        viewShipping.backgroundColor=UIColor.black
        viewReturn.backgroundColor=UIColor.black
        viewPrivacy.backgroundColor=UIColor.white
        self.getPolicy()
    }
    
    @IBAction func btnReturnPolicy(_ sender: Any) {
        policyType="return"
        viewShipping.backgroundColor=UIColor.black
        viewReturn.backgroundColor=UIColor.white
        viewPrivacy.backgroundColor=UIColor.black
        self.getPolicy()
    }
    
    @IBAction func btnShippingPolicy(_ sender: Any) {
        policyType="shipping"
        viewShipping.backgroundColor=UIColor.white
        viewReturn.backgroundColor=UIColor.black
        viewPrivacy.backgroundColor=UIColor.black
        self.getPolicy()
    }
    
}

extension PrivacyPolicyVC{
    func getPolicy() {
        let par = ["customer_id": customerId,
                   "policy":policyType]
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiPolicy(params:par as [String : AnyObject]) { (result) in
            
            RESpinner.shared.hide()
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
              
                let data = result["data"] as? String
                if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
                    let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
                    if theme == BLACK_THEME_KEY{
                       self.tfPolicy.textColor = UIColor.dmlWhite
                    }else if theme == WHITE_THEME_KEY{
                       self.tfPolicy.textColor = UIColor.dmlBlack
                    }else{
                       self.tfPolicy.textColor = UIColor.dmlBlack
                    }
                    
                }
                self.tfPolicy.set(html: data!)
                
            }
            
        }
    }
}

extension UITextView {
    func set(html: String) {
        if let htmlData = html.data(using: .unicode) {
            do {
                self.attributedText = try NSAttributedString(data: htmlData,
                                                             options: [.documentType: NSAttributedString.DocumentType.html],
                                                             documentAttributes: nil)
            } catch let e as NSError {
                print("Couldn't parse \(html): \(e.localizedDescription)")
            }
        }
    }
}
