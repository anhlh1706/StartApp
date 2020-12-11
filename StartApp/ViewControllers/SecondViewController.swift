//
//  SecondViewController.swift
//  Base
//
//  Created by Hoàng Anh on 04/08/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import UIKit
import Anchorage

final class SecondViewController: ViewController {

    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupView() {
        view.addSubview(tableView)
        tableView.edgeAnchors == view.edgeAnchors
        
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cell: OutlinedButtonTableCell.self)
        tableView.register(cell: ContainedButtonTableCell.self)
        tableView.register(cell: TextButtonTableCell.self)
        
        title = "Second view"
    }

    override func setupInteraction() {
        
    }
}

// MARK: - Actions
private extension SecondViewController {
    
    @objc
    func textTapped(_ sender: UIButton) {
        sender.shake()
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    
    @objc
    func underlinedTextTapped(_ sender: UIButton) {
        sender.shake()
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    
    @objc
    func outlinedTextTapped(_ sender: UIButton) {
        sender.flash()
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    
    @objc
    func containedTextTapped(_ sender: UIButton) {
        sender.pulsate()
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
}

// MARK: - UITableViewDataSource
extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(cell: TextButtonTableCell.self, indexPath: indexPath)
            cell.setSizeMode(.edge(height: 44))
            cell.setSpacing(1)
            cell.setTitle("Normal", for: .normal)
            cell.setTarget(target: self, action: #selector(textTapped))
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(cell: TextButtonTableCell.self, indexPath: indexPath)
            cell.setSizeMode(.edge(height: 44))
            cell.setSpacing(1)
            cell.isUnderlined = true
            cell.setTitle("Underlined", for: .normal)
            cell.setTarget(target: self, action: #selector(underlinedTextTapped))
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(cell: OutlinedButtonTableCell.self, indexPath: indexPath)
            cell.setSizeMode(.edge(height: 44))
            cell.setSpacing(1)
            cell.setTitle("Outlined", for: .normal)
            cell.setTarget(target: self, action: #selector(outlinedTextTapped))
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(cell: ContainedButtonTableCell.self, indexPath: indexPath)
            cell.setSizeMode(.edge(height: 44), rounder: 5)
            cell.setSpacing(1)
            cell.setTitle("Contained", for: .normal)
            cell.setTarget(target: self, action: #selector(containedTextTapped))
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}
