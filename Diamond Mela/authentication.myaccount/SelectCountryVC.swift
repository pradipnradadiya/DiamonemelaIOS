import UIKit

class SelectCountryVC: UIViewController , UISearchResultsUpdating {

    
    @IBOutlet weak var btnDone: UIBarButtonItem!
    
    var arrCountry = [CountryResponse.Data]()
    var filteredTableData = [CountryResponse.Data]()
    
    
    var resultSearchController = UISearchController()
    
    
    var countryName:String = ""
    var countryId:String = ""
    
    typealias CompletionBloack = (String, String) -> Void
    var myCompletion: CompletionBloack?
    
    
    
    @IBOutlet weak var tblCountry: UITableView!
    @IBOutlet weak var tvSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(arrCountry as NSArray)
        
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            tblCountry.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        tblCountry.reloadData()
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
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        print(searchPredicate)
        
//        let filteredData = arrCountry.filter({( country : CountryResponse.Data) -> Bool in
//            print(country.name!.lowercased().contains("\(searchPredicate)"))
//            return country.name!.lowercased().contains("\(searchPredicate)")
//        })

        
        
//        var filterByName =  arrCountry.filter({ $0["name"] as? String == "Mark" })
        
         filteredTableData = arrCountry
        
        filteredTableData = arrCountry.filter { (country: CountryResponse.Data) -> Bool in
            print(country.name?.contains("Indi"))
            return country.name!.lowercased().contains("\(searchPredicate)")
        }
        
//        filteredTableData = arrCountry
        
//        filteredTableData = arrCountry.filter({ user -> Bool in
//            print(user.name?.contains("\(searchPredicate)"))
//            return user.name!.lowercased().contains("\(searchPredicate)")
//        })
        
        
        
        
//        let array = ((self.arrCountry as NSArray).filtered(using: searchPredicate),
        
//        filteredTableData = filteredData
        
        self.tblCountry.reloadData()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // 1
        // return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 2
        // return the number of rows
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return self.arrCountry.count
        }
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        // 3
        let cell = self.tblCountry.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell
        
        if (resultSearchController.isActive) {
//            cell.textLabel?.text = filteredTableData[indexPath.row]
            cell?.country = self.filteredTableData[indexPath.row]
            return cell!
        }
        else {
            cell?.country = self.arrCountry[indexPath.row]
            return cell!
        }
        
        
        
        
        
        
        
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

