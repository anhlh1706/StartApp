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

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupView() {
        if #available(iOS 13.0, *) {
            tableView = UITableView(frame: .zero, style: .insetGrouped)
        } else {
            tableView = UITableView(frame: .zero, style: .grouped)
            tableView.backgroundColor = .background
        }
        view.addSubview(tableView)
        tableView.edgeAnchors == view.edgeAnchors
        
        tableView.dataSource = self
        tableView.register(cell: OutlinedButtonTableCell.self)
        tableView.register(cell: ContainedButtonTableCell.self)
        tableView.register(cell: TextButtonTableCell.self)
        tableView.register(cell: IconTextTableCell.self)
        
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
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(cell: IconTextTableCell.self, indexPath: indexPath)
            cell.title = "This is row number \(indexPath.row)!"
            cell.subtitle = "adding one more line of code, now it's 2 lines of code!"
            cell.iconImage = .brandLogo
            cell.iconSize = .init(width: 50, height: 50)
            return cell
        }
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(cell: TextButtonTableCell.self, indexPath: indexPath)
            cell.setSizeMode(.edge(height: 44))
            cell.setSpacing(1)
            cell.setTitle("Normal", for: .normal)
            cell.setTarget(target: self, action: #selector(textTapped))
            if #available(iOS 13.0, *) {
                cell.backgroundColor = .systemGroupedBackground
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(cell: OutlinedButtonTableCell.self, indexPath: indexPath)
            cell.setSizeMode(.edge(height: 44), rounder: 22)
            cell.setSpacing(1)
            cell.setTitle("Outlined", for: .normal)
            cell.setTarget(target: self, action: #selector(outlinedTextTapped))
            if #available(iOS 13.0, *) {
                cell.backgroundColor = .systemGroupedBackground
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(cell: ContainedButtonTableCell.self, indexPath: indexPath)
            cell.setSizeMode(.edge(height: 44), rounder: 5)
            cell.setSpacing(1)
            cell.setTitle("Contained", for: .normal)
            cell.setTarget(target: self, action: #selector(containedTextTapped))
            if #available(iOS 13.0, *) {
                cell.backgroundColor = .systemGroupedBackground
            }
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
