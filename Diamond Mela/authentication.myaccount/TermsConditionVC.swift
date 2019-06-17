import UIKit

class TermsConditionVC: UIViewController {

    @IBOutlet weak var tvTermsCondition: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
