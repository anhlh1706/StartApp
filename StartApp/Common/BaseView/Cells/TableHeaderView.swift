//
//  TableHeaderView.swift
//  Base
//
//  Created by Hoàng Anh on 30/07/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import UIKit
import Anchorage

class BasicTableHeaderView: UITableViewHeaderFooterView {
    
    fileprivate let titleLabel = UILabel()
    fileprivate let subtitleLabel = UILabel()
    fileprivate var labelsStack: UIStackView!
    fileprivate var stackEdgeAnchors: ConstraintGroup!
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var subtitle: String? {
        get {
            return subtitleLabel.text
        }
        set {
            subtitleLabel.text = newValue
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        let labels = [titleLabel, subtitleLabel]
        
        labels.forEach { label in
            label.numberOfLines = 0
        }
        
        labelsStack = UIStackView(arrangedSubviews: labels)
        labelsStack.axis = .vertical
        labelsStack.spacing = 4
        contentView.addSubview(labelsStack)
        stackEdgeAnchors = (labelsStack.edgeAnchors == contentView.edgeAnchors + UIEdgeInsets(top: 8, left: 18, bottom: 8, right: 18))
        
        titleLabel.textColor = .text
        subtitleLabel.textColor = .subtext
        titleLabel.font = .systemFont(ofSize: 17)
        subtitleLabel.font = .systemFont(ofSize: 14)
        contentView.backgroundColor = UIColor.background.withAlphaComponent(0.95)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        backgroundView?.alpha = 0
    }
    
}

final class ActionTableHeaderView: BasicTableHeaderView {
    
    private let actionButton = Button()
    
    var actionTitle: String = "" {
        didSet {
            actionButton.setTitle(actionTitle, for: .normal)
            removeConstraint(stackEdgeAnchors.trailing)
            stackEdgeAnchors.trailing.constant = -(AppHelper.estimatedWidth(ofString: actionTitle, withFont: actionButton.titleLabel?.font, spacing: actionButton.spacing) + 15)
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(actionButton)
        actionButton.trailingAnchor == contentView.trailingAnchor - 10
        actionButton.topAnchor == contentView.topAnchor + 2
        actionButton.setTitle("See full", for: .normal)

        removeConstraint(stackEdgeAnchors.trailing)
        stackEdgeAnchors.trailing.constant = -(AppHelper.estimatedWidth(ofString: "See full", withFont: actionButton.titleLabel?.font, spacing: actionButton.spacing) + 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
