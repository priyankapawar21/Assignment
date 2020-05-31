//
//  CollectionViewCell.swift
//  Assignment
//
//  Created by Priyanka on 5/30/20.
//  Copyright © 2020 Priyanka. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var subView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView() 
        // Initialization code
    }
    func configureView() {
        self.backgroundColor = UIColor(displayP3Red: 248, green: 183, blue: 105, alpha: 1)


    }
}
