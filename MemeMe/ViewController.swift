//
//  ViewController.swift
//  MemeMe
//
//  Created by Farzad on 7/25/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    
    let memeTextAttributes:[String:Any]=[
        NSFontAttributeName:UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSForegroundColorAttributeName:UIColor.white,
        NSStrokeColorAttributeName:UIColor.black,
        //NSStrokeWidthAttributeName:0.5
      ]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeKeybordNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeKeybordNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraBT.isEnabled=UIImagePickerController.isSourceTypeAvailable(.camera)
        topTextField.defaultTextAttributes=memeTextAttributes
        bottomTextField.defaultTextAttributes=memeTextAttributes
        topTextField.delegate = textFieldDelegate
        bottomTextField.delegate = textFieldDelegate
        shareBT.isEnabled=false
        topTextField.text="TOP"
        bottomTextField.text="BOTOM"
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pickImageFromAlbum(_ sender: Any) {
        pickImage(from: .gallery)
        
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        pickImage(from: .camera)
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
    
    func keyboardWillShow(_ notification:Notification) {
        self.view.frame.origin.y=0
       self.view.frame.origin.y-=getKeyboardHeight(notification)
           }
    
    func keyboardWillHide(_ notification:Notification){
        self.view.frame.origin.y=0
    }

    struct Meme {
        let topText:String
        let bottomText:String
        let originalImage:UIImage
        let memedImage:UIImage
    }
    
    func saveMemeImage() -> Meme {
        // Create the meme
        let memedImage=generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
        return meme
    }
    
    func generateMemedImage() -> UIImage {
        //Hide All Unwanted Section
        self.bottomtoolbar.isHidden=true
        self.topToolbar.isHidden=true
        UIApplication.shared.isStatusBarHidden=true
        //
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //
         UIApplication.shared.isStatusBarHidden=false
        self.bottomtoolbar.isHidden=false
        self.topToolbar.isHidden=false
        //
        return memedImage
        
    }
    
    @IBAction func shareImage(_ sender: Any) {
        
        let meme=saveMemeImage().memedImage
        shareImageWithActivity(memeImage: meme)
        
         }
    
    
    func shareImageWithActivity(memeImage meme:UIImage){
        let activityVC:UIActivityViewController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func cancelshareMeme(_ sender: Any) {
        topTextField.text="TOP"
        bottomTextField.text="BOTOM"
        imageView.image=nil
        
       
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
extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image=info[UIImagePickerControllerOriginalImage] as? UIImage{
        imageView.image=image
        dismiss(animated: true, completion: nil)
        shareBT.isEnabled=true
       
        }
 
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}




