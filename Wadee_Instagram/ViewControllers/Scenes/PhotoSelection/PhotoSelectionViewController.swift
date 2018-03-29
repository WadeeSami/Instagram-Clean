//
//  SelectPhotoViewController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 3/9/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectionViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - variables
    var coordinator:PhotoSelectionCoordinator?
    let cellId = "cellId"
    let headerId = "headerId"
    
    private var selectedImage:UIImage?
    
    //stores 'low quality' fetched images to be presented in the grid
    private var images = [UIImage]()
    private var assets = [PHAsset]()
    //MARK: life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .yellow
        
        setupNavigationButtons()
        
        collectionView?.register(PhotoSelectionCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.register(PhotoSelectionHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        self.fetchPhotos()
    }
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    //MARK: controller specific methods
    fileprivate func setupNavigationButtons() {
        navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }
    
    //MARK: handlers
    @objc func handleNext() {
        coordinator?.openPhotoShareViewController(withImage: self.selectedImage!)
        
        
    }
    
    @objc func handleCancel() {
        //delegate to the coodinator
        dismiss(animated: true, completion: nil)
    }
}

extension PhotoSelectionViewController{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoSelectionHeaderCell
        
        
        if selectedImage != nil, let index = self.images.index(of: self.selectedImage!){
            let imageManager = PHImageManager.default()
            imageManager.requestImage(for: self.assets[index], targetSize: CGSize(width: 700, height: 700), contentMode: .aspectFill, options: nil, resultHandler: { (image, info) in
                header.cellImageView.image = image
            })
        }
        
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectionCell
        cell.cellImageView.image = self.images[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedImage = self.images[indexPath.item]
        self.collectionView?.reloadData()
    }
}

extension PhotoSelectionViewController{
    
    func getUserGalleryFetchOptions()->PHFetchOptions{
        let fetchOptions = PHFetchOptions()
        //consider adding a sort descriptor to sort according to date !
        fetchOptions.fetchLimit = 30
        return fetchOptions
    }
    
    func fetchPhotos(){
        DispatchQueue.global(qos: .background).async {
            let allPhotos = PHAsset.fetchAssets(with: .image, options: self.getUserGalleryFetchOptions())
            allPhotos.enumerateObjects { (asset, count, stop) in
                let imageManager = PHImageManager()
                let imageSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: options, resultHandler: { (image, ingo) in
                    self.images.append(image!)
                    self.assets.append(asset)
                    
                    if self.selectedImage == nil{
                        self.selectedImage = image!
                    }
                    
                    if  count == self.images.count - 1 {
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                        
                    }
                })
                
            }
        }
        
    }
}

