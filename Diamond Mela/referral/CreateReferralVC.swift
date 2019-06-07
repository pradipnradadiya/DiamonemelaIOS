import UIKit
import ObjectMapper
import RappleProgressHUD
import JVFloatLabeledTextField

class CreateReferralVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    

    @IBOutlet weak var tvDiscount: JVFloatLabeledTextField!
    @IBOutlet weak var tvTel: JVFloatLabeledTextField!
    @IBOutlet weak var tvEmail: JVFloatLabeledTextField!
    @IBOutlet weak var tvLnm: JVFloatLabeledTextField!
    @IBOutlet weak var tvFnm: JVFloatLabeledTextField!
    
    var pickOption = ["1", "2", "3", "4", "5","6","7","8","9","10"]
    var pwd : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        tvDiscount.inputView = pickerView
        pwd = generateRandomDigits(15)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCart(_ sender: Any) {
    }
    @IBAction func btnSearch(_ sender: Any) {
    }
    @IBAction func btnManageReferral(_ sender: Any) {
        let manageReferral = self.storyboard?.instantiateViewController(withIdentifier: "ManageReferralVC") as? ManageReferralVC
        self.navigationController?.pushViewController(manageReferral!, animated: true)
    }
    
    @IBAction func btnAddReferral(_ sender: Any) {
        
        self.createReferral(fnm: tvFnm.text!, lnm: tvLnm.text!, email: tvEmail.text!, telephone: tvTel.text!, discount: "10")
        
        
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
