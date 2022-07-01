//
//  UploadViewController.swift
//  Sharing Photo
//
//  Created by Furkan Ceylan on 30.06.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizerImage = UITapGestureRecognizer(target: self, action: #selector(imageViewClicked))
        imageView.addGestureRecognizer(gestureRecognizerImage)
        
        uploadButton.isEnabled = false // Upload Button Passive
    }
    
    @objc func imageViewClicked(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        uploadButton.isEnabled = true // Upload Button Active
        self.dismiss(animated: true, completion: nil)
    }
    
    // Upload files with Cloud Storage
    @IBAction func uploadButtonClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imagesRef = storageRef.child("Images")
        
        if let imageData = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            var spaceRef = storageRef.child("\(uuid).jpg")
            
            spaceRef.putData(imageData, metadata: nil) { storageMetaData, error in
                if error != nil{
                    // Hata mesajı ekle
                    self.addAlertMessage(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error, Please try again.")
                }else{
                    let size = storageMetaData?.size
                    
                    spaceRef.downloadURL { url, error in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            
                            //Database
                            let db = Firestore.firestore()
                            
                            let data = ["image" : imageUrl, "comment" : self.commentTextField.text, "email" : Auth.auth().currentUser?.email, "date" : FieldValue.serverTimestamp()] as [String : Any]
                            db.collection("Post").addDocument(data: data) { error in
                                if error != nil{
                                    self.addAlertMessage(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error , Please try again")
                                }else{
                                    self.addAlertMessage(titleInput: "Success", messageInput: error?.localizedDescription ?? "Registration Successful")
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    @objc func addAlertMessage(titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
                doneToolbar.barStyle = .default

                let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

                let items = [flexSpace, done]
                doneToolbar.items = items
                doneToolbar.sizeToFit()

                commentTextField.inputAccessoryView = doneToolbar

    }

    @objc func doneButtonAction()
    {
        view.endEditing(true)
        
    }
    
}
