//
//  SingleViewCell.swift
//  test_collectionview_pinch
//
//  Created by kawaharadai on 2018/02/15.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class SingleViewCell: UICollectionViewCell {
    
    // MARK: - Propaties
    var imageView: UIImageView!
    var scrollView: UIScrollView!
    
    static var identifier: String {
        return String(describing: self)
    }

    // MARK: - Initialize
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()

    }
   
    // MARK: - Setup
    private func setup() {
        //スクロールビューを設置
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: self.frame.width,
                                  height: self.frame.height)
        
        //デリゲートを設定
        scrollView.delegate = self
        
        //最大・最小の大きさを決める
        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 1.0
        
        self.contentView.addSubview(scrollView)
        
        //imageViewを生成
        imageView =  UIImageView()
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: self.frame.width,
                                 height: self.frame.height)
        
        //scrollViewにのせる
        scrollView.addSubview(imageView)
        
        // ダブルタップジェスチャーの生成
        let doubleTap = UITapGestureRecognizer(target: self,
                                               action: #selector(SingleViewCell.doubleTap(gesture:)))
        doubleTap.numberOfTapsRequired = 2
        
        imageView.isUserInteractionEnabled = true
        
        imageView.addGestureRecognizer(doubleTap)
    }

    // MARK: - Action
    // ダブルタップアクション
    @objc func doubleTap(gesture: UITapGestureRecognizer) -> Void {
        
        if ( self.scrollView.zoomScale < 3 ) {
            let newScale:CGFloat = self.scrollView.zoomScale * 3
            let zoomRect:CGRect = self.zoomRectForScale(scale: newScale,
                                                        center: gesture.location(in: gesture.view))
            self.scrollView.zoom(to: zoomRect, animated: true)
        } else {
            self.scrollView.setZoomScale(1.0, animated: true)
        }
    }
    // ピンチ領域の計算
    func zoomRectForScale(scale:CGFloat, center: CGPoint) -> CGRect{
        var zoomRect: CGRect = CGRect()
        zoomRect.size.height = self.scrollView.frame.size.height / scale
        zoomRect.size.width = self.scrollView.frame.size.width / scale
        
        zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
        zoomRect.origin.y = center.y - zoomRect.size.height / 2.0
        
        return zoomRect
    }
}

// MARK: - UIScrollViewDelegate
extension SingleViewCell: UIScrollViewDelegate {
    // ピンチインの許可
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        //実際に拡大したいscrollViewのサブビューを返す
        return self.imageView
    }
}
