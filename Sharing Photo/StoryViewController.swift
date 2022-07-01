//
//  StoryViewController.swift
//  Sharing Photo
//
//  Created by Furkan Ceylan on 30.06.2022.
//

import UIKit
import Firebase
import SDWebImage

class StoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var emailArray = [String]()
    var imageUrlArray = [String]()
    var commentArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellStory", for: indexPath) as! StoryCell
        cell.emailLabel.text = emailArray[indexPath.row]
        cell.commentLabel.text = commentArray[indexPath.row]
        cell.storyImageView.sd_setImage(with: URL(string: self.imageUrlArray[indexPath.row]))
        return cell
    }
    
    @objc func getData(){
        let db = Firestore.firestore()
        
        db.collection("Post").addSnapshotListener { snapshot, error in
            if error != nil{
                // Error message
            }else{
                if snapshot != nil && snapshot?.isEmpty != true {
                    
                    self.imageUrlArray.removeAll(keepingCapacity: false)
                    self.emailArray.removeAll(keepingCapacity: false)
                    self.commentArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        
                        if let imageUrl = document.get("image") as? String{
                            self.imageUrlArray.append(imageUrl)
                        }
                        
                        if let email = document.get("email") as? String{
                            self.emailArray.append(email)
                        }
                        
                        if let comment = document.get("comment") as? String{
                            self.commentArray.append(comment)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

}
