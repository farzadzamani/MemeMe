//
//  ViewController.swift
//  MemeMe
//
//  Created by Farzad on 7/25/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {

    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var cameraBT: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareBT: UIBarButtonItem!
    @IBOutlet weak var bottomtoolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    
    let textFieldDelegate=MemeMeFieldDelegate()
    
    enum ImageSource {
        case camera
        case gallery
    }
    
    struct TextFieldCaption {
        static let Top = "TOP"
        static let Bottom = "BUTTOM"
    }
    
  
    
    let memeTextAttributes:[String:Any]=[
        NSAttributedStringKey.font.rawValue:UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.foregroundColor.rawValue:UIColor.white,
        NSAttributedStringKey.strokeColor.rawValue:UIColor.black,
        NSAttributedStringKey.strokeWidth.rawValue:-3.0
        
      ]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeKeybordNotification()
        cameraBT.isEnabled=UIImagePickerController.isSourceTypeAvailable(.camera)
      
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeKeybordNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareBT.isEnabled=false
        configure(textfield: topTextField, defaultText: TextFieldCaption.Top)
        configure(textfield: bottomTextField, defaultText: TextFieldCaption.Bottom)
        }
    
    func configure(textfield:UITextField,defaultText:String ){
        bottomTextField.isHidden = true
        topTextField.isHidden = true
        textfield.defaultTextAttributes=memeTextAttributes
        textfield.delegate = textFieldDelegate
        textfield.textAlignment = .center
        textfield.text = defaultText
        textfield.adjustsFontSizeToFitWidth=true
        textfield.minimumFontSize=17.0
        imageView.image = #imageLiteral(resourceName: "chooseimage")
        
    }

    @IBAction func pickImageFromAlbum(_ sender: Any) {
        pickImage(from: .gallery)
        bottomTextField.isHidden = false
        topTextField.isHidden = false
        imageView.image = nil
        
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        pickImage(from: .camera)
        bottomTextField.isHidden = false
        topTextField.isHidden = false
         imageView.image = nil
    }
 
    func pickImage(from imageSource:ImageSource){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        switch imageSource {
        case  .camera:
            imagePickerController.sourceType = .camera
        default:
            imagePickerController.sourceType = .photoLibrary
        }
    
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
  
    //Keyboard Height Adjustement
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        self.view.frame.origin.y=0
        if bottomTextField.isFirstResponder {
            self.view.frame.origin.y-=getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification){
        self.view.frame.origin.y=0
    }


    
    func save(memeImage:UIImage)  {
        // Create the meme
        let memedImage=generateMemedImage()
        
        let meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, originalImage: imageView.image!, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    func generateMemedImage() -> UIImage {
        //Hide All Unwanted Section
        hideGroup(ofToolbars: [topToolbar,bottomtoolbar], isHide: true)
        //
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //
        UIApplication.shared.isStatusBarHidden=false
        hideGroup(ofToolbars: [topToolbar,bottomtoolbar], isHide: false)
        //
        return memedImage
        
    }
    
    func hideGroup(ofToolbars toolbarArray:[UIToolbar],isHide:Bool){
        if isHide {
            if topTextField.text == TextFieldCaption.Top {topTextField.isHidden = true}
            if bottomTextField.text == TextFieldCaption.Bottom {bottomTextField.isHidden = true }
        }
        for toolbarItem in toolbarArray {
           toolbarItem.isHidden=isHide
        }
    }
    
    @IBAction func shareImage(_ sender: Any) {
        
        let memeImage=generateMemedImage()
       
        shareImageWithActivity(memeImage: memeImage)
       
        
         }
    
    
    func shareImageWithActivity(memeImage meme:UIImage){
        let activityVC:UIActivityViewController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
       
        self.present(activityVC, animated: true, completion:nil)
       
      activityVC.completionWithItemsHandler = {
            (activity, success, items, error) in
            if(success && error == nil){
              self.save(memeImage: meme)
              self.dismiss(animated: true, completion: nil)
              
            }
            else if (error != nil){
                //log the error
            }
        };
    
    }
 
    @IBAction func cancelshareMeme(_ sender: Any) {
        topTextField.text="TOP"
        bottomTextField.text="BOTOM"
        imageView.image=nil
        shareBT.isEnabled=false
         self.dismiss(animated: true, completion: nil)
       
    }
  
    func subscribeKeybordNotification(){
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(_:)),
                                               name : Notification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide(_:)),
                                               name : Notification.Name.UIKeyboardWillHide, object: nil)
           }
    
    func unsubscribeKeybordNotification(){
        NotificationCenter.default.removeObserver(self, name : Notification.Name.UIKeyboardWillShow, object: nil)
         NotificationCenter.default.removeObserver(self, name : Notification.Name.UIKeyboardWillHide, object: nil)
           }
    }
extension MemeEditorViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image=info[UIImagePickerControllerOriginalImage] as? UIImage{
        imageView.image = nil
        imageView.image=image
        dismiss(animated: true, completion: nil)
        shareBT.isEnabled=true
       
        }
 
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        configure(textfield: topTextField, defaultText: TextFieldCaption.Top)
        configure(textfield: bottomTextField, defaultText: TextFieldCaption.Bottom)
        dismiss(animated: true, completion: nil)
    }
    
    

}




