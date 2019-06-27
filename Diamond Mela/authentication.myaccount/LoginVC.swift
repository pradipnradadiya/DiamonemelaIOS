import UIKit
import ObjectMapper
import RappleProgressHUD


class LoginVC: UIViewController {
    
var arrPopularProducts = [PopularProductItem.Product_img]()
    var count = Int()
    var customerId = String()
    //cart array dictionry
    var arrayOfDict = [[String: String]]()
    
    
    @IBOutlet weak var tvPassword: UITextField!
    @IBOutlet weak var tvEmail: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
     
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func itemBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCheckUncheck(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.setImage(UIImage(named: "checked"), for: .normal)
           
            sender.isSelected=false
        }else{
            sender.setImage(UIImage(named: "unchecked"), for: .normal)
            sender.isSelected=true
        }
        
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
        if ConnectionCheck.isConnectedToNetwork() {
            print("connected")
            if (tvEmail.text?.isEmpty)!{
                showAlert(title: "", message: "Please enter email.")
            }else if(tvPassword.text?.isEmpty)!{
                showAlert(title: "", message: "Please enter password.")
            }else{
                
                
                RappleActivityIndicatorView.startAnimating()
               self.loginCustomer()
                
                
            }
        }else{
            print("disconnected")
            showAlert(title: internetAlert, message: internetNotConnectMsg!)
        }
        
    }
    
    @IBAction func btnForgotPassword(_ sender: Any) {
        let forgotPwd = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as? ForgotPasswordVC
        self.navigationController?.pushViewController(forgotPwd!, animated: true)
    }
    
    @IBAction func btnCreateAnAccount(_ sender: Any) {
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
        self.navigationController?.pushViewController(signUp!, animated: true)
    }
    
}

extension LoginVC {
    
    func addToCart(productId:String,customerId:String,optionId:String,optionTypeId:String,stoneOptionId:String,stoneOptionTypeId:String,qty:String){
        
        let par = ["product_id": productId,
                   "customer_id": customerId,
                   "option_id": optionId,
                   "option_type_id": optionTypeId,
                   "stone_option_id": stoneOptionId,
                   "stone_option_type_id": stoneOptionTypeId,
                   "qty": qty]
        
        
        ApiManager.shared.apiAddToCart(params:par as [String : AnyObject]) { (result) in
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                //self.showAlert(title: SUCCESS, message: result["message"] as? String ?? "")
                self.count -= 1
                if self.count == 0{
                    userSessionData.removeObject(forKey: CART_USERDEFAULTS)
                    let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
                    homeVC?.arrPopularProducts = self.arrPopularProducts
                    self.navigationController?.pushViewController(homeVC!, animated: true)
                    RappleActivityIndicatorView.stopAnimation()
                }
            }
        }
    }
    
    
    func getPopularProduct(url:String){
                RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiPopularProduct(url: url){ (result) in
           
                RappleActivityIndicatorView.stopAnimation()
          
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let data=Mapper<PopularProductItem>().map(JSON: result)
                self.arrPopularProducts = (data?.product_img)!
                if (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) != nil {
                
                    
                    if (UserDefaults.standard.array(forKey: CART_USERDEFAULTS)) != nil {
                        self.arrayOfDict = userSessionData.value(forKey: CART_USERDEFAULTS) as! [[String : String]]
                        if self.arrayOfDict.isEmpty{
                            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
                            homeVC?.arrPopularProducts = self.arrPopularProducts
                            self.navigationController?.pushViewController(homeVC!, animated: true)
                        }else{
                            self.count = self.arrayOfDict.count
                            
                            var i:Int = 0
                            RappleActivityIndicatorView.startAnimatingWithLabel("Please wait item is adding to cart.")
                            for _ in self.arrayOfDict{
                                
                                self.addToCart(productId: self.arrayOfDict[i][PRODUCT_ID] ?? "", customerId: self.customerId, optionId: self.arrayOfDict[i][RING_OPTION_ID] ?? "", optionTypeId: self.arrayOfDict[i][RING_OPTION_TYPE_ID] ?? "", stoneOptionId: self.arrayOfDict[i][STONE_OPTION_ID] ?? "", stoneOptionTypeId: self.arrayOfDict[i][STONE_OPTION_TYPE_ID] ?? "", qty: self.arrayOfDict[i][QTY] ?? "")
                                
                                i += 1
                                
                            }
                        }
                        
                        
                    }
                    
                    
                }
               
            }
            
        }
    }
    
    
    func loginCustomer() {
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["email": self.tvEmail.text!,"password": self.tvPassword.text!,"notification_token": "abc123","device_id": "sdf56sd5f6"] as [String : Any]
        
        
        ApiManager.shared.apiLogin(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            
            if status == FAILURE_CODE || status == nil {
                self.showAlert(title: errorTitle, message: wrongLogin)
            } else {
//                 let loginData = Mapper<LoginItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                let loginData = Mapper<LoginItem>().map(JSON: result)
                print(loginData?.customer_role as Any)

                //Store in UserDefaults
                if let jsonString = loginData?.toJSONString(prettyPrint: true) {
                    
                    userSessionData.set(jsonString, forKey: USER_SESSION_DATA_KEY)
                    
                    userSessionData.set("\(loginData?.data?.default_billing_new?.firstname ?? "")  \(loginData?.data?.default_billing_new?.lastname ?? ""),\n\(loginData?.data?.default_billing_new?.street ?? ""),\n\(loginData?.data?.default_billing_new?.city ?? ""), \(loginData?.data?.default_billing_new?.region ?? ""), \(loginData?.data?.default_billing_new?.postcode ?? ""),\n\(loginData?.data?.default_billing_new?.country_id ?? ""),\nT: \(loginData?.data?.default_billing_new?.telephone ?? "")", forKey: BILLING_USERDEFAULTS)
                    
                    
                    userSessionData.set("\(loginData?.data?.default_shipping_new?.firstname ?? "")  \(loginData?.data?.default_shipping_new?.lastname ?? ""),\n\(loginData?.data?.default_shipping_new?.street ?? ""),\n\(loginData?.data?.default_shipping_new?.city ?? ""), \(loginData?.data?.default_shipping_new?.region ?? ""), \(loginData?.data?.default_shipping_new?.postcode ?? ""),\n\(loginData?.data?.default_shipping_new?.country_id ?? ""),\nT: \(loginData?.data?.default_shipping_new?.telephone ?? "")", forKey: SHIPPING_USERDEFAULTS)
                    
                   
                    
                    
                }
                
                
                //retrieve from UserDefaults
                if let dataArrayString = (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) {
                    
                    if let dataObject = Mapper<LoginItem>().map(JSONString: dataArrayString)  {
                      
                        self.customerId = dataObject.data?.entity_id ?? ""
                    }
                }
                
               
                
                
                 self.getPopularProduct(url: Endpoint.popularProducts.url)
                
               
                
                
                
//                let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "HomeVC")
//                appDelegate.window?.rootViewController = initialViewController
//                appDelegate.window?.makeKeyAndVisible()
                
                
                }
                
            }
            
        }
        
    }
    


