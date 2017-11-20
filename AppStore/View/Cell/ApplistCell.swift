//
//  CollectionViewCell.swift
//  AppStore
//
//  Created by 泽i on 2017/10/27.
//  Copyright © 2017年 泽i. All rights reserved.
//
import UIKit
import SDWebImage

class ApplistCell: UICollectionViewCell {

    var model: CustomAppModel! {
        didSet {
            reload()
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bundleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
    }
    private func reload() {
        imageView.sd_setImage(with: URL(string: model.iconUrl),
                              placeholderImage: #imageLiteral(resourceName: "icon"),
                              options: .transformAnimatedImage,
                              completed: nil)

        titleLabel.text = model.name
        bundleLabel.text = model.bundleId
        updateLabel.text = "更新时间：\(model.updateDate.dateFormatter)"
        versionLabel.text = "版本：v\(model.release.version).\(model.release.build)"
    }
}
