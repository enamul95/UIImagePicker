//
//  ViewController.swift
//  UIImagePicker
//
//  Created by Enamul Haque on 18/3/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPhotGalary(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func btnCapture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        //for camera front
        // picker.cameraDevice = .front
        picker.delegate = self
        picker.allowsEditing = false
        present(picker, animated: true)
    }
}

extension ViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let orinalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        //for image rotration
        let image =  orinalImage.upOrientationImage()
        imageView.image = image
    }
    
}

extension UIImage {
    func upOrientationImage() -> UIImage? {
        switch imageOrientation {
        case .up:
            return self
        default:
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            draw(in: CGRect(origin: .zero, size: size))
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return result
        }
    }
}
