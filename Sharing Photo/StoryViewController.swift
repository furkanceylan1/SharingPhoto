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
    
    var postArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellStory", for: indexPath) as! StoryCell
        cell.emailLabel.text = postArray[indexPath.row].email
        cell.commentLabel.text = postArray[indexPath.row].comment
        cell.storyImageView.sd_setImage(with: URL(string: self.postArray[indexPath.row].image))
        return cell
    }
    
    @objc func getData(){
        let db = Firestore.firestore()
        
        db.collection("Post").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil{
                // Error message
            }else{
                if snapshot != nil && snapshot?.isEmpty != true {
                    
                    self.postArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        
                        if let imageUrl = document.get("image") as? String{
                            if let email = document.get("email") as? String{
                                if let comment = document.get("comment") as? String{
                                    let post = Post(email: email, comment: comment, image: imageUrl)
                                    self.postArray.append(post)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

}
