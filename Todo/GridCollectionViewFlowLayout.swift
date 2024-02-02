//
//  GridCollectionViewFlowLayout.swift
//  Todo
//
//  Created by 영현 on 2/2/24.
//

import UIKit

class GridCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var numberOfColumns = 3
    var ratioHeightToWidth = 1.0
    var cellSpacing = 0.0 {
        didSet {
            self.minimumLineSpacing = self.cellSpacing
            self.minimumInteritemSpacing = self.cellSpacing
        }
    }
    
    override init() {
        super.init()
        self.scrollDirection = .vertical
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
