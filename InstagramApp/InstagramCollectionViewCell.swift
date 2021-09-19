//
//  InstagramCollectionViewCell.swift
//  InstagramApp
//
//  Created by Machir on 2021/9/18.
//

import UIKit

class InstagramCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var cellWidthConstraints: NSLayoutConstraint!
    
    //Cell寬度計算，設定為一排3張，每張間距為3總共有兩個間距
    static let width = floor((UIScreen.main.bounds.width - 3 * 2) / 3)
    
    //storyboard產生cell時，會先呼叫awakeFromNib() func
    override func awakeFromNib() {
        super.awakeFromNib()
        cellWidthConstraints?.constant = Self.width
    }
}
