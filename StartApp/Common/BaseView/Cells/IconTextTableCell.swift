//
//  IconTextTableCell.swift
//  Base
//
//  Created by Hoàng Anh on 30/07/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import UIKit
import Anchorage
import SDWebImage

final class IconTextTableCell: UITableViewCell {
    
    private(set) var titleLabel = UILabel()
    private(set) var subtitleLabel = UILabel()
    private(set) var iconImageView = UIImageView()
    private(set) var labelStack = UIStackView()
    
    private(set) var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    private(set) var subTitle: String? {
        didSet {
            subtitleLabel.text = subTitle
        }
    }
    
    private(set) var iconImage: UIImage? {
        didSet {
            iconImageView.image = iconImage
            iconImageView.tintColor = .white
        }
    }
    
    private var iconSizeAnchor: ConstraintPair!
    
    var iconSize: CGSize! {
        didSet {
            guard iconSize != nil else { return }
            removeConstraint(iconSizeAnchor.first)
            removeConstraint(iconSizeAnchor.second)
            iconSizeAnchor.first.constant = iconSize.width
            iconSizeAnchor.second.constant = iconSize.height
        }
    }
    
    var iconCornerRadius: CGFloat = 0 {
        didSet {
            iconImageView.cornerRadius = iconCornerRadius
        }
    }
    
    func render(title: String, subTitle: String? = nil, icon: UIImage? = nil, iconUrl: String? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.iconImage = icon
        if let iconUrl = iconUrl {
            iconImageView.sd_setImage(with: URL(string: iconUrl), placeholderImage: icon, completed: { (image, _, _, _) in
                self.iconImage = image
            })
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        
        addSubview(iconImageView)
        iconSizeAnchor = (iconImageView.sizeAnchors == CGSize(width: 40, height: 40))
        iconImageView.verticalAnchors >= verticalAnchors + 8
        iconImageView.leadingAnchor == leadingAnchor + 15
        iconImageView.centerYAnchor == centerYAnchor
        
        addSubview(labelStack)
        [titleLabel, subtitleLabel].forEach { view in
            labelStack.addArrangedSubview(view)
        }
        
        labelStack.axis = .vertical
        labelStack.spacing = 7
        
        labelStack.leadingAnchor == iconImageView.trailingAnchor + 15
        labelStack.topAnchor == topAnchor + 10
        labelStack.bottomAnchor <= bottomAnchor - 8
        labelStack.trailingAnchor == trailingAnchor - 20
        
        accessoryType = .disclosureIndicator
        
        iconImageView.contentMode = .scaleAspectFit
        
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
        
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        titleLabel.textColor = .text
        subtitleLabel.textColor = .subtext
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
