//
//  DetailViewController.swift
//  Assignment
//
//  Created by Priyanka on 5/30/20.
//  Copyright © 2020 Priyanka. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var detailObject: Movie?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var lblMovieName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        subView.backgroundColor =  UIColor.black.withAlphaComponent(0.5)
        lblMovieName.text = detailObject?.movieName
        if let url = URL(string: APIConstants.backgrondUrl + (detailObject?.backgrountImgUrl ?? "")) {
             let data = try? Data(contentsOf: url)

             if let imageData = data {
                 let image = UIImage(data: imageData)
                 imageView.image = image
             }
         }
    }
    
}
