import UIKit
import ObjectMapper
import RappleProgressHUD
import JVFloatLabeledTextField

class CreateReferralVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    typealias CompletionBloack = (String, String) -> Void
    var myCompletion: CompletionBloack?

    @IBOutlet weak var lblCartCount: UILabelX!
    @IBOutlet weak var tvDiscount: JVFloatLabeledTextField!
    @IBOutlet weak var tvTel: JVFloatLabeledTextField!
    @IBOutlet weak var tvEmail: JVFloatLabeledTextField!
    @IBOutlet weak var tvLnm: JVFloatLabeledTextField!
    @IBOutlet weak var tvFnm: JVFloatLabeledTextField!
    
    var pickOption = ["1", "2", "3", "4", "5","6","7","8","9","10"]
    var pwd : String = ""
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDownloadCartCount()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // lblCartCount.text = "5"
        let pickerView = UIPickerView()
        pickerView.delegate = self
       
        ///
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        //let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
       // let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelTapped))
        
        toolBar.setItems([cancelButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
       
        ///
        tvDiscount.inputView = pickerView
         tvDiscount.inputAccessoryView = toolBar
        pwd = generateRandomDigits(15)
        // Do any additional setup after loading the view.
    }
    
    @objc func cancelTapped() {
      tvDiscount.resignFirstResponder()
    }
    
    @IBAction func btnCart(_ sender: Any) {
        let cart = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as? CartVC
        self.navigationController?.pushViewController(cart!, animated: true)
    }
    @IBAction func btnSearch(_ sender: Any) {
        let search = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC
        navigationController?.pushViewController(search!, animated: true)
    }
    @IBAction func btnManageReferral(_ sender: Any) {
        let manageReferral = self.storyboard?.instantiateViewController(withIdentifier: "ManageReferralVC") as? ManageReferralVC
        self.navigationController?.pushViewController(manageReferral!, animated: true)
    }
    
    @IBAction func btnAddReferral(_ sender: Any) {
        
        if (tvFnm.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter first name.")
        }else if (tvLnm.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter last name.")
        }else if (tvEmail.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter email.")
        }else if (tvTel.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter telephone.")
        }else if (tvDiscount.text?.isEmpty)!{
            showAlert(title: "", message: "Please select discount.")
        }
        else{
        self.createReferral(fnm: tvFnm.text!, lnm: tvLnm.text!, email: tvEmail.text!, telephone: tvTel.text!, discount: "10")
        }
        
//        let vc = UIViewController()
//        vc.preferredContentSize = CGSize(width: 250,height: 300)
//        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
//        pickerView.delegate = self as? UIPickerViewDelegate
//        pickerView.dataSource = self as? UIPickerViewDataSource
//        vc.view.addSubview(pickerView)
//        let editRadiusAlert = UIAlertController(title: "Choose distance", message: "", preferredStyle: UIAlertController.Style.alert)
//        editRadiusAlert.setValue(vc, forKey: "contentViewController")
//        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
//        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(editRadiusAlert, animated: true)
//
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        var sa = "dwd"
        var dsd = "dasas";
        if self.myCompletion != nil {
            self.myCompletion!(dsd, sa)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tvDiscount.text = pickOption[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension CreateReferralVC{
    
    func createReferral(fnm:String,lnm:String,email:String,telephone:String,discount:String) {
        let par = ["franchisee_status": "0",
                   "firstname": fnm,
                   "lastname": lnm,
                   "email": email,
                   "group_id": "5",
                   "password": pwd,
                   "referral_comission": discount,
                   "parent_franchise_id": customerId,
                   "telephone": telephone,
                   "referral_type": "customer",
                   "_isfranchisee":"0"]
        
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiCreateReferral(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let msg=result["message"] as? String
                self.showAlert(title: SUCCESS, message: msg!)
            }
            
        }
    }
    
    
    func getDownloadCartCoubnt() {
        let par = ["customer_id": customerId]
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetDownloadCartCount(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                var total_qty = result["total_qty"] as? Int
                var download_count = result["download_count"] as? Int
                
            }
            
        }
    }
    
    
}
