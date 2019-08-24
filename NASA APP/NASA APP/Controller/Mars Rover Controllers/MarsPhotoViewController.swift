//
//  MarsPhotoViewController.swift
//  NASA APP
//
//  Created by Mike Conner on 8/24/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class MarsPhotoViewController: UIViewController, UITextFieldDelegate {
    
    var originalImage: UIImage? {
        didSet {
            imageView?.image = image
        }
    }
    
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
            image = textToImage(drawText: text, inImage: existingImage, atPoint: CGPoint(x: 10, y: 100))
            imageView?.image = image
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
    
    static func instantiate() -> MarsPhotoViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "MarsPhotoViewController") as? MarsPhotoViewController
    }
}

extension MarsPhotoViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 50
    }
}
