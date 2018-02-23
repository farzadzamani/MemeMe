//
//  SentMemesTableVC.swift
//  MemeMe
//
//  Created by Farzad on 9/23/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import UIKit


class SentMemesTableViewController: UITableViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let topdownMargin:CGFloat=3.0
    private let heightOfImage:CGFloat=70.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight=heightOfImage+topdownMargin
        
        navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(callMemeEditorVC) )
       
       
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        if appDelegate.memes.count>0 {
            tableView!.reloadData()
            tableView.backgroundView = nil
            
        }else {
            tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "tableviewbackground"))
        }
        
       
    }
    
    @objc func callMemeEditorVC() {
        
        if let memeEditorVC:MemeEditorViewController=self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as? MemeEditorViewController{
            self.present(memeEditorVC, animated: true, completion: nil)
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return appDelegate.memes.count
       // return self.appDelegate.memes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: "SentMemeTableViewCell", for: indexPath)
            as? SentMemeTableViewCell else {
                 alert(view: self, title: "Error", message: "Can not Render Meme Data For Now,Please Try Again!")
           fatalError("Can not Render Meme Data For Now,Please Try Again!")
        }
     
      let memeCurrentRow = self.appDelegate.memes[indexPath.row]
      tableCell.memeImageView.image = memeCurrentRow.memedImage
      
      tableCell.textOfImage.text = memeCurrentRow.topText
      tableCell.textOfImage2.text = memeCurrentRow.bottomText
      tableCell.memeImageView.RoundedView(20.00, borderSize: 1)
    
    return tableCell
      
    }
    
 
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeme = appDelegate.memes[indexPath.row]
        let memeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailVC.meme = selectedMeme
        navigationController?.pushViewController(memeDetailVC, animated: true)
    }
   

}
