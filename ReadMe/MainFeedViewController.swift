//
//  MainFeedViewController.swift
//  ReadMe
//
//  Created by Son Nguyen on 10/5/17.
//  Copyright © 2017 Son Nguyen. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Kingfisher

class MainFeedViewController: UIViewController {
    
   var collectionView: UICollectionView!
    
    var viewModel = FeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let layout = UICollectionViewFlowLayout()
       // layout.estimatedItemSize = CGSize(width: self.view.frame.width, height: 1)
        layout.minimumLineSpacing = 20.0
//        layout.minimumInteritemSpacing = 10.0
        layout.scrollDirection = .vertical
        
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        self.collectionView.register(FeedCollectionViewCell.self , forCellWithReuseIdentifier: "cell")
       
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.alwaysBounceVertical = true
        viewModel.delegate = self
        
        self.collectionView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func refreshView(){
        viewModel.requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MainFeedViewController  : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let statusText = self.viewModel.pagingData.data[indexPath.item].message
        
        let contentTextRect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 10000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
        
        var knownHeight: CGFloat = 4 + 20 + 4 + 4 + 20
        
        ImageCache.default.retrieveImage(forKey: "imgTony\(indexPath.row)", options: nil) {
            image, cacheType in
            if let image = image {
                //print("cacheType: \(cacheType).")
                //In this code snippet, the `cacheType` is .disk
                // calculate imageViewSize
                
                let screenSize = UIScreen.main.bounds.size
                
                let imageAspectRatio = image.size.width / image.size.height
                let screenAspectRatio = screenSize.width / screenSize.height
                
                var width : CGFloat = 0.0
                var height : CGFloat = 0.0
                if imageAspectRatio > screenAspectRatio {
                    width = min(image.size.width, screenSize.width)
                    height = width / imageAspectRatio
                }
                else {
                    height = min(image.size.height, screenSize.height)
                    width = height * imageAspectRatio
                }
                
                knownHeight += height
                
            } else {
                //print("Not exist in cache.")
            }
        }
        
//        if let cell = collectionView.cellForItem(at: indexPath) as? FeedCollectionViewCell {
//            knownHeight += cell.ivPhoto.frame.height
//        }
        
        let height = contentTextRect.height + knownHeight // + image height
        
        return CGSize(width: view.frame.width, height: height)
        
        //return CGSize(width: view.frame.width, height: 500)
    }
}

extension MainFeedViewController  : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.pagingData.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCollectionViewCell
        
        let data = self.viewModel.pagingData.data[indexPath.row]
        cell.feed = nil
        cell.setHandler(indexPath: indexPath, container: collectionView)
        cell.feed = data
        
        return cell
    }
    
  
}

extension MainFeedViewController : FeedBindingDelegate {
    func didGetData(error: Any?) {
        if error == nil {
            self.collectionView.reloadData()
        } else {
            // show alert
        }
    }
}

