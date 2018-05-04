//
//  ViewController.swift
//  test_collectionview_pinch
//
//  Created by kawaharadai on 2018/02/15.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    // MARK: - Setup
    private func setupCollectionView() {
        // collectionviewの生成（作成したレイアウトを適用する）
        let myCollectionView = UICollectionView(frame: CGRect(x: 0,
                                                              y: 50,
                                                              width: self.view.frame.width,
                                                              height: self.view.frame.width * 4 / 3),
                                                collectionViewLayout: self.setupLayout())
        
        //デリゲートをつける
        myCollectionView.dataSource = self
        
        //カスタムセルを指定
        myCollectionView.register(SingleViewCell.self, forCellWithReuseIdentifier: "SingleViewCell")
        
        //スクロールバーを表示するかどうか
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.showsVerticalScrollIndicator = false
        
        // 背景色を決定
        myCollectionView.backgroundColor = UIColor.gray
        
        //ページングをするかどうか
        myCollectionView.isPagingEnabled = true
        
        self.view.addSubview(myCollectionView)
    }
    
    private func setupLayout() -> UICollectionViewFlowLayout {
        // レイアウト設定の作成
        let imageLayout = UICollectionViewFlowLayout()
        imageLayout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.width * 4 / 3)
        // スクロールの向き
        imageLayout.scrollDirection = .horizontal
        imageLayout.minimumLineSpacing = 0
        imageLayout.minimumInteritemSpacing = 0
        imageLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        return imageLayout
    }
    
}

// MARK: - UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //セルの設定
        guard let cell:SingleViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleViewCell.identifier,
                                                                           for: indexPath) as? SingleViewCell else {
            fatalError("cell is nil")
        }
        
        guard let image = UIImage(named: "Austraria") else {
            fatalError("image is nil")
        }
        
        cell.imageView.image = image
        
        return cell
    }
}

