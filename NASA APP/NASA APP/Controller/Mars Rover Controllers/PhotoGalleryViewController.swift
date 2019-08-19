//
//  PhotoGalleryViewController.swift
//  NASA APP
//
//  Created by Mike Conner on 8/18/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit
import Nuke
import Alamofire

private let reuseIdentifier = "PhotoCell"

class PhotoGalleryViewController: UICollectionViewController {
    
    let cellSpacing: CGFloat = 1
    let columns: CGFloat = 3
    var cellSize: CGFloat = 0
    
    var pixelSize: CGFloat {
        get {
            return cellSize * UIScreen.main.scale
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 //       self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)    // not sure if this is needed...
        
        navigationController?.navigationBar.topItem?.title = "Mars Rover Photos"
        
        let contentModes = ImageLoadingOptions.ContentModes(success: .scaleAspectFill, failure: .scaleAspectFit, placeholder: .scaleAspectFit)
        
        ImageLoadingOptions.shared.placeholder = UIImage(named: "dark-moon")
        ImageLoadingOptions.shared.failureImage = UIImage(named: "annoyed")
        ImageLoadingOptions.shared.transition = .fadeIn(duration: 1.0)
        ImageLoadingOptions.shared.contentModes = contentModes
        
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
