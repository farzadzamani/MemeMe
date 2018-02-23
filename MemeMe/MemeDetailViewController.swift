//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Farzad on 9/26/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    var meme:Meme!
   
    @IBOutlet weak var imageOfSelectedMeme: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       imageOfSelectedMeme.image = meme.memedImage
       imageOfSelectedMeme.contentMode = .scaleAspectFit
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         tabBarController?.tabBar.isHidden = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
