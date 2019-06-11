
import UIKit
import Foundation

public class RESpinner {
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: RESpinner {
        struct Static {
            static let instance: RESpinner = RESpinner()
        }
        return Static.instance
    }
    
    public let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 65, height: 65))
        imageView.alpha = 1.0
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        return imageView
    }()
    
    /* Spinner overlay with default UIActivityIndicatorView */
    
    public func showActivity(view: UIView!) {
        overlayView = UIView(frame: UIScreen.main.bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        activityIndicator.center = overlayView.center
        overlayView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        view.addSubview(overlayView)
    }
    
    /* Spinner overlay with custom loading view */
    
    public func show(view: UIView!) {
        
        activityIndicator.stopAnimating()
        imageView.removeFromSuperview()
        overlayView.removeFromSuperview()
        
        overlayView = UIView(frame: UIScreen.main.bounds)
        overlayView.backgroundColor = UIColor.clear
        imageView.image = UIImage(named: "progress_loader")
        imageView.center = overlayView.center
        overlayView.addSubview(imageView)
        imageView.startRotating()
        view.addSubview(overlayView)
    }
    
    public func hide() {
        activityIndicator.stopAnimating()
        imageView.removeFromSuperview()
        overlayView.removeFromSuperview()
    }
    
}
