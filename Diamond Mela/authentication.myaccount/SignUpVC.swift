import UIKit
import JVFloatLabeledTextField
import iOSDropDown
import ObjectMapper
import RappleProgressHUD

class SignUpVC: UIViewController {

    @IBOutlet weak var selectCountry: DropDown!
    @IBOutlet weak var tvLnm: JVFloatLabeledTextField!
    @IBOutlet weak var tvFnm: JVFloatLabeledTextField!
    @IBOutlet weak var tvEmail: JVFloatLabeledTextField!
    @IBOutlet weak var tvContact: JVFloatLabeledTextField!
    @IBOutlet weak var tvAddress: JVFloatLabeledTextField!
    @IBOutlet weak var tvState: JVFloatLabeledTextField!
    @IBOutlet weak var tvCity: JVFloatLabeledTextField!
    @IBOutlet weak var tvZipCode: JVFloatLabeledTextField!
    @IBOutlet weak var tvCompanyName: JVFloatLabeledTextField!
    @IBOutlet weak var tvPwd: JVFloatLabeledTextField!
    @IBOutlet weak var tvConfirmPwd: JVFloatLabeledTextField!
    var countryData:[CountryResponse.Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

             
        
        self.getCountry(url: Endpoint.getCountryList.url)
        
        
        
        
        
        // The list of array to display. Can be changed dynamically
        
        selectCountry.optionArray = ["Option 1", "Option 2", "Option 3"]
        //Its Id Values and its optional
        selectCountry.optionIds = [1,23,54,22]
        // The the Closure returns Selected Index and String
        selectCountry.didSelect{(selectedText , index ,id) in
//            self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
            print("Selected String: \(selectedText) \n index: \(index)")
            self.selectCountry.hideList()
        }
        // Do any additional setup after loading the view.
        
        
        
    }
    

    @IBAction func itemBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTermsCondition(_ sender: Any) {
        let terms=self.storyboard?.instantiateViewController(withIdentifier: "TermsConditionVC") as! TermsConditionVC
        self.navigationController?.pushViewController(terms, animated: true)
    }
    
    
    @IBAction func btnCheckUncheck(_ sender: Any) {
        
    }
}

extension SignUpVC{
    func getCountry(url : String){
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetCountry(url: url){ (result) in
            RappleActivityIndicatorView.stopAnimation()
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let countryList=Mapper<CountryResponse>().map(JSON: result)
                self.countryData=(countryList?.data)!
                
               
                
            }
            
        }
    }
    
    func getState(url : String){
        let par = ["country_id": "countryId"]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetState(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                let stateList=Mapper<StateResponse>().map(JSON: result)
            }
            
        }
    }
}
