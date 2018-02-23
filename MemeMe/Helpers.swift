//
//  Helpers.swift
//  World Restaurants
//
//  Created by Farzad on 2/6/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
import UIKit




// Mark - GENERAL UI HELPER Method(Alert)
func alert(view:UIViewController,title:String,message:String) {
    performUIUpdatesOnMain {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
            view.dismiss(animated: true, completion: nil)
        })
        
        view.present(alert, animated: true, completion: nil)
    }
}
// Mark - GENERAL UI HELPER Method(Alert)
func alertWithViewDismiss(view:UIViewController,title:String,message:String) {
    performUIUpdatesOnMain {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
            view.dismiss(animated: true, completion: nil)
        })
        
        view.present(alert, animated: true, completion: nil)
    }
}
// Mark - GENERAL UI HELPER Method(Alert)
func confirmAlert(view:UIViewController,title:String,message: String, dismissButtonTitle: String = "Cancel", actionButtonTitle: String = "OK", action: @escaping ((UIAlertAction!) -> Void)) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: dismissButtonTitle, style: .default) { (action: UIAlertAction!) in
        alert.dismiss(animated: true, completion: nil)
    })
    
    alert.addAction(UIAlertAction(title: actionButtonTitle, style: .default, handler: action))
    
    view.present(alert, animated: true, completion: nil)
}
// Mark - GENERAL Helper Method(Go to Link )
func goTo(url:String?) {
    if let url = URL(string: url! ) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
// Mark - GCD Helper Method
func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}


extension UIView {
    func RoundedView(borderColor:UIColor? = UIColor.white) {
        self.layer.cornerRadius = self.frame.size.width / 2
        print( self.frame.size.width / 2)
        self.clipsToBounds =  true
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = 3
    }
    
    func RoundedView(_ cornerRadius:CGFloat,borderColor:UIColor? = UIColor.white,borderSize:CGFloat?) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds =  true
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderSize ?? 0
    }
   
}

extension UIButton {
    func CornerRadius(){
       
        self.layer.cornerRadius = 4
        
    }
}

/// Helper For Check to App is launched befor Than This with UserDefault key
extension UserDefaults {
    func IsAppFirstLaunch() -> Bool {
        if let launchStatus = self.string(forKey: "isAppAlreadyLaunchedOnce") {
            return false
        }else {
            self.set(true, forKey: "isAppAlreadyLaunchedOnce")
            return true
        }
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}


extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}



