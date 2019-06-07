
import UIKit

class PrintVC: UIViewController {

    var printFile : String = ""
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var btnPrint: UIBarButtonItem!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(printFile)
        // Do any additional setup after loading the view.
        
        let printController = UIPrintInteractionController.shared
        
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = UIPrintInfo.OutputType.general
        printInfo.jobName = "printFile"
        printInfo.duplex = UIPrintInfo.Duplex.none
        printInfo.orientation = UIPrintInfo.Orientation.portrait
        
        //New stuff
        printController.printPageRenderer = nil
        printController.printingItems = nil
        printController.printingItem = printFile
        
        //New stuff
        
        printController.printInfo = printInfo
        printController.showsPageRange = true
        printController.showsNumberOfCopies = true
        printController.present(from: btnPrint, animated: true, completionHandler: nil)
        
        
    }
    

    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
