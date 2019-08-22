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
    
    static let api = WebAPI()
    
    var marsPhotoURLs: Photos?
        
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
        
        getPhotos()
        loadPhotos()
    }

    func getPhotos() {
        PhotoGalleryViewController.api.getMarsPhotos { (photos) in
            self.marsPhotoURLs = photos
//            print(self.marsPhotoURLs?.photos.count ?? "this is supposed to be the number of marsPhotos")
//            var count = 0
//            while count < self.marsPhotoURLs?.photos.count ?? 0 {
//                print(self.marsPhotoURLs?.photos[count].img_src ?? "default value in while statement")
//                count = count + 1
//            }
            self.collectionView.reloadData()
        }
    }
    
    func loadPhotos() {
        let contentModes = ImageLoadingOptions.ContentModes(success: .scaleAspectFill, failure: .scaleAspectFit, placeholder: .scaleAspectFit)
        
        ImageLoadingOptions.shared.placeholder = UIImage(named: "dark-moon")
        ImageLoadingOptions.shared.failureImage = UIImage(named: "annoyed")
        ImageLoadingOptions.shared.transition = .fadeIn(duration: 1.0)
        ImageLoadingOptions.shared.contentModes = contentModes
        
        DataLoader.sharedUrlCache.diskCapacity = 0
        
        let pipeline = ImagePipeline {
            $0.dataCache = try! DataCache(name: "com.mikeconner.NASA-APP.datacache")
        }
        ImagePipeline.shared = pipeline
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return marsPhotoURLs?.photos.count ?? 25
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
    
        // Configure the cell
        if let imageURL = URL(string: marsPhotoURLs?.photos[indexPath.row].img_src ?? "") {
            let request = ImageRequest(url: imageURL, targetSize: CGSize(width: pixelSize, height: pixelSize), contentMode: .aspectFill)
            Nuke.loadImage(with: request, into: cell.imageView)
        }
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

// MARK: Collection View Delegate Flow Layout Methods

extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            let emptySpace = layout.sectionInset.left + layout.sectionInset.right + (columns * cellSpacing - 1)
            cellSize = (view.frame.size.width - emptySpace) / columns
            return CGSize(width: cellSize, height: cellSize)
        }
        
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}



