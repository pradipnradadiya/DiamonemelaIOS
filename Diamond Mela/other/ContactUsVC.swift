import UIKit
import JVFloatLabeledTextField

class ContactUsVC: UIViewController {

    @IBOutlet weak var tvComment: JVFloatLabeledTextField!
    @IBOutlet weak var tvTeliphone: JVFloatLabeledTextField!
    @IBOutlet weak var tvEmail: JVFloatLabeledTextField!
    @IBOutlet weak var tvName: JVFloatLabeledTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func btnSubmit(_ sender: Any) {
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ContactUsVC{
    func saveContactUs(name:String,email:String,telephone:String,comment:String) {
        
        
        
    }
}
