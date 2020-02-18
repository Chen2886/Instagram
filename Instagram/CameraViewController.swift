//
//  CameraViewController.swift
//  Instagram
//
//  Created by Tony Chen on 2/17/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        let picture = PFObject(className: "posts")
        picture["caption"] = captionTextField.text!
        picture["author"] = PFUser.current()!
        let imageData = imageView.image!.pngData()!
        let file = PFFileObject(name: "file.png", data: imageData)
        
        picture["image"] = file
        
        picture.saveInBackground { (sucess, error) in
            if sucess {
                self.dismiss(animated: true, completion: nil)
                print("good")
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func openCameraClicked(_ sender: Any) {
        print("clicked")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
