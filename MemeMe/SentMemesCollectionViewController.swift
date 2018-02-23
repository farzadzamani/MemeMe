//
//  SentMemesCollectionVC.swift
//  MemeMe
//
//  Created by Farzad on 9/23/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import UIKit



class SentMemesCollectionViewController: UICollectionViewController{
   let appDelegate = UIApplication.shared.delegate as! AppDelegate
   private let reuseIdentifier = "SentMemeCollectionViewCell"
    
    private let leftAndRightPadding:CGFloat=30.0
    private let numberOfItemRow: CGFloat=2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (collectionView!.frame.width - leftAndRightPadding) / numberOfItemRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize.width = width
        layout.itemSize.height=width
        navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(callMemeEditorVC) )
      
    }
    override func viewWillAppear(_ animated: Bool) {
        if appDelegate.memes.count>0 {
       collectionView!.reloadData()
              collectionView!.backgroundView = nil
            
        }else {
            collectionView!.backgroundView = UIImageView(image: #imageLiteral(resourceName: "tableviewbackground"))
            
        }
        
        super.viewWillAppear(true)
    }
    //Call New MEME Activity
    @objc func callMemeEditorVC() {
        
        if let memeEditorVC:MemeEditorViewController=self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as? MemeEditorViewController{
            self.present(memeEditorVC, animated: true, completion: nil)
        }
        
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      
        return appDelegate.memes.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? SentMemeCollectionViewCell else {
            alert(view: self, title: "Error", message: "Can not Render Meme Data For Now,Please Try Again!")
            fatalError("Can not Render Meme Data For Now,Please Try Again!")
        }
        let memeRow=self.appDelegate.memes[indexPath.row]
        cell.memeImageInCollectionViewCell.image=memeRow.memedImage
        cell.memeImageInCollectionViewCell.RoundedView(10.00, borderSize: nil)
        

        return cell
    }
   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMeme = appDelegate.memes[indexPath.row]
 let memeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailVC.meme = selectedMeme
        navigationController?.pushViewController(memeDetailVC, animated: true)
    }
    
}
