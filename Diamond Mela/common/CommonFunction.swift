import Foundation
import UIKit

func switchRootViewController(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
    guard let window = UIApplication.shared.keyWindow else { return }
    
    let rootVavigation = UINavigationController(rootViewController: rootViewController)
    if animated {
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            let oldState: Bool = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window.rootViewController = rootVavigation
            UIView.setAnimationsEnabled(oldState)
        }, completion: { (finished: Bool) -> () in
            if (completion != nil) {
                completion!()
            }
        })
    } else {
        window.rootViewController = rootVavigation
    }
}


func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}


func generateRandomDigits(_ digitNumber: Int) -> String {
    var number = ""
    for i in 0..<digitNumber {
        var randomNumber = arc4random_uniform(10)
        while randomNumber == 0 && i == 0 {
            randomNumber = arc4random_uniform(10)
        }
        number += "\(randomNumber)"
    }
    return number
}


func userAlreadyExist(kUsernameKey: String) -> Bool {
    return saveTheme.string(forKey: kUsernameKey) != nil
}

extension Dictionary {
    var prettyPrintedJSON: String? {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        } catch _ {
            return nil
        }
    }
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    //using email id validation
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func askQuestionSuccessPopop(){
        
        let alert = UIAlertController(title: "Success",
                                      message: "Thank you! You will be responded shortly.",
                                      preferredStyle: .alert)
        
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            print("ok selected!")
            self.view.removeFromSuperview()
            
        })
        
        
       
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func successPopup( title:String, msg:String){
        
        let alert = UIAlertController(title: title,
                                      message: msg,
                                      preferredStyle: .alert)
        
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            print("ok selected!")
           self.navigationController?.popViewController(animated: true)
        })
        
        
        
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func registerPopop(){
        
        let alert = UIAlertController(title: "Alert",
                                      message: "Please register to proceed!",
                                      preferredStyle: .alert)
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            print("cancel selected!")
        })
        
        let register = UIAlertAction(title: "Register", style: .default, handler: { (action) -> Void in
            print("register selected!")
            let dashBoard = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
            switchRootViewController(rootViewController: dashBoard!, animated: true, completion: nil)
        })
        
        
       
        alert.addAction(cancel)
        alert.addAction(register)
        
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    
}

extension String {
    var isValidContact: Bool {
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

//left right padding set
extension UITextField {
    
    func setPadding(left: CGFloat? = nil, right: CGFloat? = nil){
        if let left = left {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        
        if let right = right {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    
}

//Add done in number pad
extension UITextField{
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}



//Add done in number pad
extension UITextView{
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}


extension StringProtocol {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    var firstCapitalized: String {
        guard let first = first else { return "" }
        return String(first).capitalized + dropFirst()
    }
}


extension String {
    var wordUppercased: String {
        var aryOfWord = self.split(separator: " ")
        aryOfWord =  aryOfWord.map({String($0.first!).uppercased() + $0.dropFirst()})
        return aryOfWord.joined(separator: " ")
    }
}

extension UILabel {
    
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        let lines = Int(textSize.height/charSize)
        return lines
    }
    
}



