import UIKit

class SelectCountryVC: UIViewController {

    
    @IBOutlet weak var btnDone: UIBarButtonItem!
    var arrCountry = [CountryResponse.Data]()
    var countryName:String = ""
    var countryId:String = ""
    
    typealias CompletionBloack = (String, String) -> Void
    var myCompletion: CompletionBloack?
    
    
    
    @IBOutlet weak var tblCountry: UITableView!
    @IBOutlet weak var tvSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDone(_ sender: Any) {
        if self.myCompletion != nil {
            self.myCompletion!(countryName, countryId)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        if self.myCompletion != nil {
            self.myCompletion!(countryName, countryId)
        }
         self.navigationController?.popViewController(animated: true)
    }
    
}
extension SelectCountryVC{
    
    func reloadTable() {
        if self.arrCountry.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.tblCountry.reloadData()
    }
    
}

extension SelectCountryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = self.tblCountry.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell
        
        cell?.country = self.arrCountry[indexPath.row]
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        countryName = self.arrCountry[indexPath.row].name!
        countryId = self.arrCountry[indexPath.row].country_id!
        self.btnDone.isEnabled = true
        
        //        self.arrQA[indexPath.row].is_viewed=true
        //        self.tblQA.reloadRows(at: [indexPath], with: .automatic)
        
        //        let qadetail = self.storyboard?.instantiateViewController(withIdentifier: "QADetailVC") as? QADetailVC
        //        qadetail?.qa = self.arrQA[indexPath.row]
        //        qadetail?.qid = self.arrQA[indexPath.row].iD!
        //        self.navigationController?.pushViewController(qadetail!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

