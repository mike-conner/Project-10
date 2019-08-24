//
//  MarsPhotoViewController.swift
//  NASA APP
//
//  Created by Mike Conner on 8/24/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class MarsPhotoViewController: UIViewController {
    
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
    
    var contentMode: UIView.ContentMode = .scaleAspectFill {
        didSet {
            imageView?.contentMode = contentMode
        }
    }
    
    @IBOutlet weak var filterSelectionSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    static func instantiate() -> MarsPhotoViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "MarsPhotoViewController") as? MarsPhotoViewController
    }
}
