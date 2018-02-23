//
//  Meme.swift
//  MemeMe
//
//  Created by Farzad on 9/23/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import UIKit

struct Meme {
  
    var topText:String? {
        didSet{
            if self.topText == nil { self.topText = ""}
        }
    }
    var bottomText:String? {
        didSet{
            if self.bottomText == nil { self.bottomText = ""}
        }
    }
    let originalImage:UIImage
    let memedImage:UIImage
 
}

