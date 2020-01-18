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
        detect()
        self.dismiss(animated: true, completion: nil)
    }
    
    func detect() {
        //get image from image view
        let myImage = CIImage(image: myImageView.image!)!
        
        //set up detector
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: myImage, options: [CIDetectorSmile:true])
        
        if !faces!.isEmpty {
            for face in faces as! [CIFaceFeature] {
                let mouthShowing = "\nMouth is showing: \(face.hasMouthPosition)"
                let isSmiling = "\nPerson is smiling: \(face.hasSmile)"
                var bothEyesShowing = "\nBoth eyes showing: true"
                
                if !face.hasRightEyePosition || !face.hasLeftEyePosition{
                    bothEyesShowing = "\nBoth eyes showing: false"
                    
                }
                
                //degree of suspiciousness
                let array = ["Low", "Medium", "High", "Very High"]
                var suspiciousness = 0;
                
                if !face.hasMouthPosition { suspiciousness += 1}
                if !face.hasSmile { suspiciousness += 1}
                if bothEyesShowing.contains("false") { suspiciousness += 1}
                if face.faceAngle > 10 || face.faceAngle < -10 {suspiciousness += 1}
                
                let suspectText = "\nSuspiciousness: \(array[suspiciousness])"
                
                myTextView.text = "\(suspectText) \n\(mouthShowing) \(isSmiling) \(bothEyesShowing)"
            }
        } else{
            myTextView.text = "No faces found"
        }
        
    }
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var myImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do (any additional setup after loading the view.
        detect()
    }


}

