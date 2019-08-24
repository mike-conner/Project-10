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
    
    var userSelectedRover: Rovers?
    var userSelectedDate: String?
    
    var marsPhotoURLs: Photos?
        
    let cellSpacing: CGFloat = 1
    let columns: CGFloat = 2
    var cellSize: CGFloat = 0
    
    var pixelSize: CGFloat {
        get {
            return cellSize * UIScreen.main.scale
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Mars Rover Photos"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Search", style: .done, target: self, action: #selector(goBack))
        if let rover = userSelectedRover, let date = userSelectedDate {
            getPhotos(rover: rover, date: date)
        }
        loadPhotos()
    }
    
    @objc
    func goBack() {
        dismiss(animated: true, completion: nil)
    }

    func getPhotos(rover: Rovers, date: String) {
        PhotoGalleryViewController.api.getMarsPhotos(rover: rover, date: date) { (photos) in
            self.marsPhotoURLs = photos
            if self.marsPhotoURLs?.photos.count == 0 {
                self.showAlert(with: "We're so sorry...", and: "We have no images to show you for that day. Please go back and select a different rover or day.")
            }
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

extension PhotoGalleryViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let marsPhotoViewController = MarsPhotoViewController.instantiate() else {
            return
        }
        
        marsPhotoViewController.image = ImageLoadingOptions.shared.placeholder
        marsPhotoViewController.contentMode = .scaleAspectFit
        
        if let imageURL = URL(string: marsPhotoURLs?.photos[indexPath.row].img_src ?? "") {
            ImagePipeline.shared.loadImage(with: imageURL, progress: nil) { (response, error) in
                if error != nil {
                    marsPhotoViewController.image = ImageLoadingOptions.shared.failureImage
                    marsPhotoViewController.contentMode = .scaleAspectFit
                } else {
                    marsPhotoViewController.originalImage = response?.image
                    marsPhotoViewController.image = response?.image
                    marsPhotoViewController.contentMode = .scaleAspectFit
                }
            }
        }
        navigationController?.pushViewController(marsPhotoViewController, animated: true)
    }
}

extension UICollectionViewController {
    func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            self.dismiss(animated: false, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
