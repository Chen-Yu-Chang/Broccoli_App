//
//  IGFeedHeaderTableViewCell.swift
//  FoodTracker
//
//  Created by 張晨鈺 on 2021/4/27.
//

import UIKit

class IGFeedHeaderTableViewCell: UITableViewCell {

    static let identifier = "IGFeedHeaderTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(){
        //configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
