import UIKit
import ObjectMapper
import RappleProgressHUD

class DrawerVC: UIViewController {

    @IBOutlet weak var lblCartCount: UILabelX!
    @IBOutlet weak var lblDownloadCount: UILabelX!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var imgDot: UIImageViewX!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnUname: UIButton!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    var arrHeader = [HeaderItem.Data]()
    @IBOutlet weak var tblCategory: UITableView!
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    @IBOutlet var drawerView: UIView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let dataArrayString = (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) {
            
            buttonLogin.isHidden = true
            btnSignUp.isHidden = true
            imgDot.isHidden = true
            btnUname.isHidden = false
            
            if let dataObject = Mapper<LoginItem>().map(JSONString: dataArrayString)  {
                
                btnUname.setTitle("\(dataObject.data?.firstname ?? "") \(dataObject.data?.lastname ?? "")", for: .normal)
                
            }
            
            
        }else{
            btnUname.isHidden = true
            buttonLogin.isHidden = false
            btnSignUp.isHidden = false
            imgDot.isHidden = false
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblHeightConstraint.constant=0
        var screenStatusBarHeight: CGFloat {
            
            if #available(iOS 11.0, *) {
                if UIApplication.shared.keyWindow!.safeAreaInsets.top < 44 {
                    return UIApplication.shared.keyWindow!.safeAreaInsets.top
                }
                return UIApplication.shared.keyWindow!.safeAreaInsets.top - 20
            } else {
                return 0
            }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
            self.view.addGestureRecognizer(tapGesture)
            // Do any additional setup after loading the view.
            
            
        }
        
    constraintTop.constant=constraintTop.constant + screenStatusBarHeight
        
       self.getHeaderMenuBestCategory(url: Endpoint.headerMenu.url)
        // Do any additional setup after loading the view.
               
        
        
        
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        self.closeDrawer()
        let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        self.navigationController?.pushViewController(login!, animated: true)
    }
    @IBAction func btnSignUp(_ sender: Any) {
        self.closeDrawer()
        let signup = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
        self.navigationController?.pushViewController(signup!, animated: true)
    }
    @IBAction func btnUnameClick(_ sender: Any) {
        
        let profile = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC
        self.navigationController?.pushViewController(profile!, animated: true)
        
    }
    @IBAction func btnOurCollection(_ sender: UIButton) {
        if sender.isSelected {
            tblHeightConstraint.constant=0
            sender.isSelected=false
        }else{
           tblHeightConstraint.constant=400
            sender.isSelected=true
        }
    }
    
    @IBAction func btnContactUs(_ sender: Any) {
        self.closeDrawer()
        let contact = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsVC") as? ContactUsVC
        self.navigationController?.pushViewController(contact!, animated: true)
        
    }
    @IBAction func btnLogout(_ sender: Any) {
    }
    @IBAction func btnCart(_ sender: Any) {
        self.closeDrawer()
        let cart = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as? CartVC
        self.navigationController?.pushViewController(cart!, animated: true)
        
    }
    @IBAction func btnPolicies(_ sender: Any) {
        self.closeDrawer()
        let policy = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as? PrivacyPolicyVC
        self.navigationController?.pushViewController(policy!, animated: true)
    }
    @IBAction func btnDownload(_ sender: Any) {
        self.closeDrawer()
        let download = self.storyboard?.instantiateViewController(withIdentifier: "DownloadVC") as? DownloadVC
        self.navigationController?.pushViewController(download!, animated: true)
    }
    @IBAction func btnTransaction(_ sender: Any) {
        self.closeDrawer()
        let transaction = self.storyboard?.instantiateViewController(withIdentifier: "TransactionVC") as? TransactionVC
        self.navigationController?.pushViewController(transaction!, animated: true)
    }
    @IBAction func btnMyOrder(_ sender: Any) {
        self.closeDrawer()
        let order = self.storyboard?.instantiateViewController(withIdentifier: "OrderTabVC") as? OrderTabVC
        self.navigationController?.pushViewController(order!, animated: true)
    }
    @IBAction func btnMyStock(_ sender: Any) {
        self.closeDrawer()
        let myStock = self.storyboard?.instantiateViewController(withIdentifier: "MyStockVC") as? MyStockVC
        self.navigationController?.pushViewController(myStock!, animated: true)
        
    }
    @IBAction func btnHome(_ sender: Any) {
    }
    
    @IBAction func btnMyAccount(_ sender: Any) {
        self.closeDrawer()
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC
        self.navigationController?.pushViewController(editProfile!, animated: true)
    }
    
    @IBAction func btnCreateReferral(_ sender: Any) {
        self.closeDrawer()
        let referral = self.storyboard?.instantiateViewController(withIdentifier: "CreateReferralVC") as? CreateReferralVC
        self.navigationController?.pushViewController(referral!, animated: true)
    }
    
    @objc func tapBlurButton(_ sender: UITapGestureRecognizer) {
        print("tap Please")
        let loc = sender.location(in: self.view)
        let subview = view?.hitTest(loc, with: nil)
        if(subview != self.drawerView){
            //            AppDelegate.menu_bool = true
//                        self.view.removeFromSuperview()
        }else{
            AppDelegate.menu_bool = true
            self.view.removeFromSuperview()
        }
    }
    
    
    
    //using close drawer
    func closeDrawer() {
        AppDelegate.menu_bool = true
        self.view.removeFromSuperview()
    }

}
extension DrawerVC{
    func getHeaderMenuBestCategory (url:String){
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiHeaderBestCategory(url: url){ (result) in
            RappleActivityIndicatorView.stopAnimation()
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                
                //   let data=Mapper<HeaderItem>().map(JSON: result)
                self.arrHeader=Mapper<HeaderItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                self.reloadTable()
               
                
            }
            
        }
    }
    
    func reloadTable() {
        if self.arrHeader.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.tblCategory.reloadData()
    }
}


extension DrawerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrHeader.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = self.tblCategory.dequeueReusableCell(withIdentifier: "DrawerCell", for: indexPath) as? DrawerCell
        cell?.headerData = self.arrHeader[indexPath.row]
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let list = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as? ListVC
        list?.headerTitle = self.arrHeader[indexPath.row].name
        list?.id = self.arrHeader[indexPath.row].entity_id
        self.navigationController?.pushViewController(list!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

