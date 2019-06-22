import UIKit

class FilterVC: UIViewController {

   
     var arrFilterDataCopy = [SortFilterItem.Data]()
    
    @IBOutlet weak var tblFilterData: UITableView!
    @IBOutlet weak var tblFilterTitle: UITableView!
    
    var position:Int=0
    
    static var dict : [String : Any] = [:]
    static var filterFlag:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        arrFilterDataCopy=arrFilterData
        
        if arrFilterData.count > 0 {
            //            self.lblNoData.isHidden = true
            var i:Int = 0
            for _ in arrFilterData{
                if i == 0{
                    arrFilterData[0].isSelect = true
                    
                }else{
                    arrFilterData[i].isSelect = false
                    
                }
                
                i += 1
            }
        }
        
        
        
//        print(arrFilterData[0].label)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnApply(_ sender: Any) {
        if FilterVC.dict.isEmpty{
            FilterVC.filterFlag = 0
        }else{
            FilterVC.filterFlag = 1
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnReset(_ sender: Any) {
//        FilterVC.dict.removeAll()
        arrFilterData.removeAll()
        arrFilterData=arrFilterDataCopy
        self.reloadTable()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        FilterVC.filterFlag = 0
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FilterVC{
    func reloadTable() {
        if arrFilterData.count > 0 {
            //            self.lblNoData.isHidden = true
//             arrFilterData[0].isSelect = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        
        self.tblFilterTitle.reloadData()
    }
    
    
    func reloadFilterDataTable(position:Int) {
        if arrFilterData[position].option_data!.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        
        
        self.tblFilterData.reloadData()
    }
   
    
    
}


extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblFilterTitle {
            return arrFilterData.count
        }else{
            return arrFilterData[position].option_data!.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tblFilterTitle {
            let cell = self.tblFilterTitle.dequeueReusableCell(withIdentifier: "FilterTitleCell", for: indexPath) as? FilterTitleCell
            cell?.filterTitleData = arrFilterData[indexPath.row]
            return cell!
        }else{
            let cell = self.tblFilterData.dequeueReusableCell(withIdentifier: "FilterDataCell", for: indexPath) as? FilterDataCell
            cell?.filterData = arrFilterData[self.position].option_data![indexPath.row]
            return cell!
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.tblFilterTitle {
            self.position=indexPath.row
          
            
//            cell?.filterTitleData = arrFilterData[indexPath.row]
            
            var i:Int = 0
            for _ in arrFilterData{
                if i == indexPath.row{
                     arrFilterData[indexPath.row].isSelect = true
                    
                }else{
                    arrFilterData[i].isSelect = false
                   
                }

                i += 1
            }
            
           
            
            
           // self.arrFilterDataCopy[indexPath.row].isSelect = true
            self.tblFilterTitle.reloadData()
            //self.reloadTable()
            
            
            if arrFilterData[indexPath.row].option_type=="text"{
                self.tblFilterData.isHidden=true
            }else{
                self.tblFilterData.isHidden=false
                reloadFilterDataTable(position: indexPath.row)
            }
            
            
        }
        else{
            //self.position=indexPath.row
            
            FilterVC.dict[arrFilterData[self.position].option_name!]=arrFilterData[self.position].option_data![indexPath.row].value
            
            var i:Int=0
            for _ in arrFilterData[self.position].option_data!{
                arrFilterData[self.position].option_data![i].isSelected = false
                i += 1
            }
            
            arrFilterData[self.position].option_data![indexPath.row].isSelected = true
            self.reloadFilterDataTable(position: position)
            
            
//            for (key, value) in dict {
//                print("\(key): \(value)")
//            }
            
            
        }
        
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



extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
