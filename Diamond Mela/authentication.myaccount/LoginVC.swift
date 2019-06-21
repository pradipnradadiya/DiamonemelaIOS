import UIKit
import ObjectMapper
import RappleProgressHUD

class LoginVC: UIViewController {

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
        
        if (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) != nil {
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
            self.navigationController?.pushViewController(homeVC!, animated: true)
           
        }
        
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
                
                /*
                //retrieve from UserDefaults
                if let dataArrayString = (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) {
                    
                    if let dataObject = Mapper<LoginItem>().map(JSONString: dataArrayString)  {
                        loginData = dataObject
                        print(dataObject.customer_role as Any)
                    }
                }
                
               */
                let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
                self.navigationController?.pushViewController(homeVC!, animated: true)
                
                
                
//                let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "HomeVC")
//                appDelegate.window?.rootViewController = initialViewController
//                appDelegate.window?.makeKeyAndVisible()
                
                
                }
                
            }
            
        }
        
    }
    


