//
//  SearchViewController.swift
//  Find A Coop
//
//  Created by Karl Thomas Hauglid on 22/11/2022.
//

import Foundation
import UIKit

enum StoreViewState {
    case loading
    case presentingStores([Store])
    case failed(String)
}

class SearchViewController: UIViewController{
    private let logicController = SearchViewLogicController()
    private var activityIndicator = UIActivityIndicatorView()
    
    var stores: [Store] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        self.title = "Find A Coop"
        loadStores()
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    private func loadStores(){
        logicController.load(query: "", then: { [weak self] state in
            self?.render(state)
        })
    }
}

private extension SearchViewController{
    func render(_ state: StoreViewState) {
        switch state {
        case .loading:
            renderLoadingScreen()
        case let .failed(error):
            renderFailedScreen(with: error)
        case let .presentingStores(stores):
            renderStores(with: stores)
        }
        
    }
    
    func renderStores(with stores: [Store]){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        self.stores = stores
    }
    
    func renderFailedScreen(with message: String){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func renderLoadingScreen(){
        self.tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath) as? StoreTableViewCell else {
            fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `StoreTableViewCell`")
        }
        cell.configure(model: self.stores[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let store = stores[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "StoreInfoViewController") as! StoreInfoViewController
        vc.store = store
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.logicController.load(query: searchText, then: { [weak self] state in
            self?.render(state)
        })
        
    }
}
