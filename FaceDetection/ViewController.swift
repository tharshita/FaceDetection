//
//  ViewController.swift
//  FaceDetection
//
//  Created by Tiyari Harshita on 18/1/20.
//  Copyright © 2020 Tiyari Harshita. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBAction func importImage(_ sender: Any) {
        //create image picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        //display image picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //pick a photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            myImageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var myImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

