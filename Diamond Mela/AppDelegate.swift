import UIKit
let appDelegate = UIApplication.shared.delegate! as! AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var menu_bool = true
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        let storyboard = UIStoryboard.init(name: "SplashVC", bundle: nil)
//        
//        // controller identifier sets up in storyboard utilities
//        // panel (on the right), it called Storyboard ID
//        let viewController = storyboard.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
//        
//        self.window?.rootViewController = viewController
//        self.window?.makeKeyAndVisible()
//        
//        
        
        
        let navigationBarAppearace = UINavigationBar.appearance()
        
        if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
            let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
            if theme == BLACK_THEME_KEY{
                
                navigationBarAppearace.tintColor = UIColor.dmlWhite
                navigationBarAppearace.barTintColor = UIColor.transactionRoundBackBlack
                
                // change navigation item title color
                navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.dmlWhite]
                
                if let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as? UIView{
                    statusBar.isHidden = true
                }
       
                
            }else if theme == WHITE_THEME_KEY{
                navigationBarAppearace.tintColor = UIColor.dmlBlack
                navigationBarAppearace.barTintColor = UIColor.transactionRoundBackWhite
                
                // change navigation item title color
                navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.dmlBlack]
            }else{
                navigationBarAppearace.tintColor = UIColor.dmlBlack
                navigationBarAppearace.barTintColor = UIColor.transactionRoundBackWhite
                
                // change navigation item title color
                navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.dmlBlack]
            }
            
        }else{
            navigationBarAppearace.tintColor = UIColor.dmlBlack
            navigationBarAppearace.barTintColor = UIColor.transactionRoundBackWhite
            
            // change navigation item title color
            navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.dmlBlack]
        }
      
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

