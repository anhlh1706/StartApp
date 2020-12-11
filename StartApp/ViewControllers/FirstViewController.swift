//
//  FirstViewController.swift
//  Base
//
//  Created by Hoàng Anh on 29/07/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import UIKit
import Anchorage
import SwiftyJSON

final class FirstViewController: ViewController {

    let tableView = UITableView(frame: .zero, style: .plain)
    
    let nextButton = Button()
    
    let searchController = UISearchController()
    
    var repositoryData: RepositoryResponse? {
        didSet {
            tableView.reload(oldValue: oldValue?.items ?? [], newValue: repositories)
        }
    }
    var repositories: [Repository] {
        repositoryData?.items ?? []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func setupView() {
        view.addSubview(tableView)
        tableView.edgeAnchors == view.edgeAnchors
        
        view.addSubview(nextButton)
        nextButton.topAnchor == view.topAnchor + 50
        nextButton.horizontalAnchors == view.horizontalAnchors + 100
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cell: IconTextTableCell.self)
        tableView.register(cell: ButtonTableCell.self)
        tableView.register(view: BasicTableHeaderView.self)
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        
        nextButton.spacing = 2
        nextButton.heightAnchor == 50
        nextButton.isUnderlined = true
        
        title = "Repository search"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        nextButton.setTitle("new view", for: .normal)
    }
    
    override func setupInteraction() {
        nextButton.addTarget(self, action: #selector(showSecond), for: .touchUpInside)
    }
}

// MARK: - Actions
private extension FirstViewController {
    
    @objc
    func showSecond() {
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - API calls
private extension FirstViewController {
    
    func findRepositories(key: String) {
        APIClient.request(.getRepositories(key: key), RepositoryResponse.self) { result in
            switch result {
            case .success(let object):
                self.repositoryData = object
            case .failure(let error):
                if error.localizedDescription != "cancelled" {
                    AppHelper.showAlert(title: "Fetching error!", msg: error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cell: IconTextTableCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        let repo = repositories[indexPath.row]
        cell.render(title: repo.name, subtitle: repo.fullname, icon: nil, iconUrl: repo.owner.avatarUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.navigationBar.endEditing(true)
        tableView.cellForRow(at: indexPath)?.pulsate()
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if repositories.isEmpty { return UIView(frame: .zero) }
        let header = tableView.dequeueReusableHeaderFooter(type: BasicTableHeaderView.self)
        header.title = "Repository in section."
        header.subtitle = "These repositories belong to section."
        return header
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        nextButton.transform.ty = -scrollView.contentOffset.y
    }
}

// MARK: - UISearchBarDelegate
extension FirstViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            repositoryData = nil
            return
        }
        findRepositories(key: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.25) { [self] in
            nextButton.alpha = 0
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !repositories.isEmpty { return }
        UIView.animate(withDuration: 0.25) { [self] in
            nextButton.alpha = 1
        }
    }
}
