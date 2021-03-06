//
//  PictureViewController.swift
//  SnapChat
//
//  Created by Jay P. Hayes on 12/21/16.
//  Copyright © 2016 Jay P. Hayes. All rights reserved.
// Test Source Control

import UIKit
import Firebase

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imgSnap: UIImageView!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    var imagePicker = UIImagePickerController()
    var uuid = "JayP_\(NSUUID().uuidString).jpg"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
        btnNext.isEnabled = false;
    }

    //MARK: - image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imgSnap.image = image
        btnNext.isEnabled = true;
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - buttons and methods
    
    @IBAction func btnCameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
        
        btnNext.isEnabled = false
        
        let imagesFolder = FIRStorage.storage().reference().child("images")
//        let imageData = UIImagePNGRepresentation(imgSnap.image!)
        let imageData = UIImageJPEGRepresentation(imgSnap.image!, 0.1)!
        
        
        
        imagesFolder.child(uuid).put(imageData, metadata: nil) { (metadata, error) in
            if error != nil{
                print("We have an Error: \(error)")
            } else {
                print("JPH: \(  metadata?.downloadURL()!.absoluteString  )")
                
                self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()?.absoluteString)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SelectUserViewController
        
        nextVC.imageURL = sender as! String
        nextVC.desc = txtDescription.text!
        nextVC.uuid = self.uuid
        
    }
}





















