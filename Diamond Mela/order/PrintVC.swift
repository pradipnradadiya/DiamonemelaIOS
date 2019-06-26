
import UIKit
import WebKit
import RappleProgressHUD

class PrintVC: UIViewController, WKUIDelegate, WKNavigationDelegate {

    var webView: WKWebView!

    var printFile : String = ""
    
    
    @IBOutlet weak var btnPrint: UIBarButtonItem!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
   
    
    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: printFile)
        let myRequest = URLRequest(url: myURL!)
        webView.navigationDelegate = self
        webView.load(myRequest)
    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        print(printFile)
//
//
//        let request = URLRequest(url: URL(fileURLWithPath: printFile))
//
//        webView.navigationDelegate = self
//        webView.load(request)
//
//    }
//
    func savePdf(urlString:String, fileName:String) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "\(fileName).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
                self.showSavedPdf(url: self.printFile, fileName: "Order_invoice")
            } catch {
                print("Pdf could not be saved")
            }
        }
    }
    func showSavedPdf(url:String, fileName:String) {
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains("\(fileName).pdf") {
                        // its your file! do what you want with it!
                        
                    }
                }
            } catch {
                print("could not locate pdf file !!!!!!!")
            }
        }
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        NSLog("Start loading");
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        RappleActivityIndicatorView.stopAnimation()
        NSLog("End loading");
        
        
//      savePdf(urlString: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf", fileName: "Order_invoice")
        
        
        
        
        let printController = UIPrintInteractionController.shared

        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = UIPrintInfo.OutputType.general
        printInfo.jobName = (webView.url?.absoluteString)!
        printInfo.duplex = UIPrintInfo.Duplex.none
        printInfo.orientation = UIPrintInfo.Orientation.portrait

        //New stuff
        printController.printPageRenderer = nil
        printController.printingItems = nil
        printController.printingItem = webView.url!
        //New stuff

        printController.printInfo = printInfo
        printController.showsPageRange = true
        printController.showsNumberOfCopies = true

//        printController.present(animated: true, completionHandler: nil)
        printController.present(from: btnPrint, animated: true, completionHandler: nil)
       // printController.presentFromBarButtonItem(animated: true, completionHandler: nil)

        
        
        
//                        let printController = UIPrintInteractionController.shared
//
//                        let printInfo = UIPrintInfo(dictionary:nil)
//                        printInfo.outputType = UIPrintInfo.OutputType.general
//                        printInfo.jobName = "Order invoice"
//                        printInfo.duplex = UIPrintInfo.Duplex.none
//                        printInfo.orientation = UIPrintInfo.Orientation.portrait
//
//                        let link:URL = URL.init(string: webView.url)!
//                        print(link.absoluteString)
//                        //New stuff
//                       // printController.printPageRenderer = nil
//                       // printController.printingItems = nil
//                        printController.printingItem = link.absoluteString
//                        //New stuff
//
//                        printController.printInfo = printInfo
//                        printController.showsPageRange = true
//                        printController.showsNumberOfCopies = true
//                       // printController.present(animated: true, completionHandler: nil)
//
//
//                        printController.present(animated: true, completionHandler: nil)
//
//                        printController.present(from: btnPrintOrder, animated: true, completionHandler: nil)
        
    }

    @IBAction func btnPrint(_ sender: Any) {
        
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
