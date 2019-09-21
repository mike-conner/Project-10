//
//  MarsPhotoViewController.swift
//  NASA APP
//
//  Created by Mike Conner on 8/24/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit
import MessageUI

class MarsPhotoViewController: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
    
    // create original Image for "resetting" if the user wants to remove the text and/or filters
    var originalImage: UIImage? {
        didSet {
            imageView?.image = image
        }
    }
    // this image is the image that will have the text and filters applied to it.
    var image: UIImage? {
        didSet {
            imageView?.image = image
        }
    }
    
    var contentMode: UIView.ContentMode = .scaleAspectFit {
        didSet {
            imageView?.contentMode = contentMode
        }
    }
    
    @IBOutlet weak var filterSelectionSegmentControl: UISegmentedControl!
    @IBOutlet weak var userInputtedImageText: UITextField!
    
    @IBOutlet weak var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInputtedImageText.delegate = self
        if let image = image {
            imageView?.image = image
        }
        imageView?.contentMode = contentMode
        
        if let height = imageView?.heightAnchor {
            imageView?.widthAnchor.constraint(equalTo: height, multiplier: 1).isActive = true
            imageView?.layer.cornerRadius = 10
            imageView?.clipsToBounds = false
        }
    }
    
    @IBAction func filterSelectionSegmentControl(_ sender: Any) {
        switch filterSelectionSegmentControl.selectedSegmentIndex {
        case 0: imageView?.image = originalImage
        case 1: setFilter(filter: "CIColorInvert")
        case 2: setFilter(filter: "CIFalseColor")
        case 3: setFilter(filter: "CIPhotoEffectTonal")
        case 4: setFilter(filter: "CISepiaTone")
        default: return
        }
    }
    
    @IBAction func addTextButton(_ sender: Any) {
        image = originalImage
        imageView?.image = image
        if let text = userInputtedImageText.text, let existingImage = imageView?.image {
            image = textToImage(drawText: text, inImage: existingImage, atPoint: CGPoint(x: 10, y: 100)) // call function to add text at specified CGPoints
            imageView?.image = image // reload photo with text applied
        }
    }
    
    @IBAction func sendButton(_ sender: Any) {
        if let imageView = imageView {
            sendMail(imageView: imageView) // call sendMail function with current image
        }
    }
    
    func setFilter(filter: String) {
        let context = CIContext(options: nil)
        if let currentFilter = CIFilter(name: filter), let image = image {
            let beginImage = CIImage(image: image)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            if let output = currentFilter.outputImage {
                if let image = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: image)
                    imageView?.image = processedImage
                }
            }
        }
    }
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 24)
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont as Any,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return image }
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func sendMail(imageView: UIImageView) {
        if MFMailComposeViewController.canSendMail() { // check to see if device is set up to send mail. If not, function notifies user that they can't send mail.
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["connerland@yahoo.com"]) // default To: email address when email opens
            mail.setSubject("Mars Rover Image")
            mail.setMessageBody("Check out this image from the Mars Rover!", isHTML: false)
            if let image = imageView.image {
                let imageData: NSData = image.pngData()! as NSData
                mail.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "imageName.png")
            }
            self.present(mail, animated: true, completion: nil)
        } else {
            showAlert(with: "Sorry...", and: "It does not appear that this device is set up properly to be able to send mail.")
        }
    }
    
    // function below dismisses mail view when finished sending
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    static func instantiate() -> MarsPhotoViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "MarsPhotoViewController") as? MarsPhotoViewController
    }
}

// limit text that'll be added to photo to 50 or less characters
extension MarsPhotoViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 50
    }
}

extension MarsPhotoViewController {
    func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            self.dismiss(animated: false, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
