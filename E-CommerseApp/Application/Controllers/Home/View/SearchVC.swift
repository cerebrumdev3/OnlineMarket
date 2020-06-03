//
//  SearchVC.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 26/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class SearchVC: CustomController {
    
    //MARK:- outlet and Variables
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var tbleView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    var searchActive : Bool = false
    var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false 
        
    }
    
    @IBAction func backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
    }
    //MARK:- Other functions
    func setView(){
        lblNoRecord.isHidden = true
        //TableView
        self.tbleView.delegate = self
        self.tbleView.dataSource = self
        tbleView.separatorStyle = .singleLine
        extendedLayoutIncludesOpaqueBars = true
        //SearchBar
        searchController.searchBar.setImage(UIImage(named: "searchIcon"), for: .search, state: .normal)
        searchController.searchBar.delegate = self
        searchController.definesPresentationContext = false
        
        var searchTextField: UITextField?
        if let searchField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField = searchField
            searchTextField?.textColor = .black
            searchTextField?.backgroundColor = .white
            searchTextField?.layer.borderWidth = 0.5
            searchTextField?.layer.borderColor = UIColor.lightGray.cgColor
            searchTextField?.layer.cornerRadius = 8
            searchTextField?.layer.masksToBounds = true
            searchTextField?.placeholder = "Search Product"
        }
        self.navigationItem.titleView = searchController.searchBar
        // Don't hide the navigation bar because the search bar is in it.
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
}

//MARK:- SearchDelegate
extension SearchVC:UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp:NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tbleView.reloadData()
    }
}


//MARK:- TableView Delegate and DataSource
extension SearchVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.SearchTableCell, for: indexPath) as? SearchTableCell
        {
            if(searchActive){
                cell.lblName.text = filtered[indexPath.row]
            } else {
                cell.lblName?.text = data[indexPath.row];
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
