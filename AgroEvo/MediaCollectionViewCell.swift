//
//  MediaCollectionViewCell.swift
//  AgroEvo
//
//  Created by Jose Mejia on 5/1/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var media_thumbnail: UIImageView!
    func displayContent(thumbnail:UIImage) {
        self.media_thumbnail.image = thumbnail
    }
}
