//
//  FeedCollectionViewCell.swift
//  ReadMe
//
//  Created by Son Nguyen on 12/22/17.
//  Copyright © 2017 Son Nguyen. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class FeedCollectionViewCell: UICollectionViewCell {
    
    var tvContent = UITextView()
    var lbPostedDate = UILabel()
    var ivPhoto = UIImageView()
    
    fileprivate var container : UICollectionView?
    fileprivate var indexPath : IndexPath?
    
    func setHandler(indexPath : IndexPath!, container: UICollectionView) {
        self.container = container
        self.indexPath = indexPath
    }
    
    var feed : FeedDataModel? {
        didSet {
            if feed == nil {
                tvContent.text = ""
                lbPostedDate.text = ""
                ivPhoto.image = nil
                self.ivPhoto.isHidden = true
                return
            }
            
            tvContent.text = feed?.message
            
//            let rect = NSString(string: tvContent.text).boundingRect(with: CGSize(width: self.frame.width, height: 10000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
//            self.tvContent.snp.remakeConstraints{ make in
//                make.height.equalTo(rect.height)
//            }
            
            if let url = feed?.full_picture {
                ivPhoto.kf.setImage(with: URL(string: url), completionHandler: {
                    (image, error, cacheType, imageUrl) in
                    
                    if let image = image {
                        let key = "imgTony\(self.indexPath!.row)"
                        if !ImageCache.default.isImageCached(forKey: key).cached {
                            ImageCache.default.store(image, forKey: key)
                        }
                            self.ivPhoto.isHidden = false
                        
                    
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
                        
                        print(key + " : " + "\(width) ; \(height)")
                        
                        self.ivPhoto.snp.remakeConstraints { make in
                            make.height.equalTo(height)
                            make.width.equalTo(width)
                            make.top.equalTo(self.lbPostedDate.snp.bottom).offset(4)
                            make.left.right.equalTo(0)
                        }
                        self.ivPhoto.layoutIfNeeded()
                       // self.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
                        
                            self.container?.reloadItems(at: [self.indexPath!])
                      
                        // image: Image? `nil` means failed
                        // error: NSError? non-`nil` means failed
                        // cacheType: CacheType
                        //                  .none - Just downloaded
                        //                  .memory - Got from memory cache
                        //                  .disk - Got from disk cache
                        // imageUrl: URL of the image
                    }
                })
            }
            lbPostedDate.text = feed?.created_time?.toString(format: "dd/MM/yyyy hh:mm:ss")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupUI() {
        self.addSubview(lbPostedDate)
        self.addSubview(tvContent)
        self.addSubview(ivPhoto)
        self.backgroundColor = .white
        
        // layout
        
        self.lbPostedDate.snp.makeConstraints { make in
            make.top.equalTo(4)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(20)
        }
        
        self.ivPhoto.snp.makeConstraints { make in
            make.top.equalTo(lbPostedDate.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(1)
        }
        self.ivPhoto.isHidden = true
        
        self.tvContent.snp.makeConstraints { make in
            make.top.equalTo(ivPhoto.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(1)
            make.bottom.equalTo(0)
        }
        
        lbPostedDate.font = UIFont.boldSystemFont(ofSize: 11)
       // lbPostedDate.backgroundColor = .white
        
        ivPhoto.contentMode = .scaleAspectFit
        ivPhoto.clipsToBounds = true
        //ivPhoto.layer.masksToBounds = true
        
        tvContent.font = UIFont.systemFont(ofSize: 14)
        tvContent.isScrollEnabled = false
        tvContent.isEditable = false
        tvContent.dataDetectorTypes = [.phoneNumber, .link]
    }
}

extension UIImageView{
    func frameForImageInImageViewAspectFit() -> CGRect
    {
        if  let img = self.image {
            let imageRatio = img.size.width / img.size.height;
            
            let viewRatio = self.frame.size.width / self.frame.size.height;
            
            if(imageRatio < viewRatio)
            {
                let scale = self.frame.size.height / img.size.height;
                
                let width = scale * img.size.width;
                
                let topLeftX = (self.frame.size.width - width) * 0.5;
                
                return CGRect(x: topLeftX, y: 0, width: width, height: self.frame.size.height);
            }
            else
            {
                let scale = self.frame.size.width / img.size.width;
                
                let height = scale * img.size.height;
                
                let topLeftY = (self.frame.size.height - height) * 0.5;
                
                return CGRect(x: 0, y: topLeftY, width: self.frame.size.width, height: height);
            }
        }
        
        return CGRect(x: 0, y: 0, width: 0, height: 0)
    }
}
