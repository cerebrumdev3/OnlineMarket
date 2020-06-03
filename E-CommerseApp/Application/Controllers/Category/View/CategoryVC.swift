//
//  CategoryVC.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 26/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class CategoryVC: BaseUIViewController {
    
    //MARK:- outlet and variables
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblNoRecord: UILabel!
    
    var viewModel : CategoryViewModel?
    var categoryList = [Service]()
    
    //MARK:- life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //hit api
        getCategoryList()
    }
    
    //MARK:- other function
    func setView(){
        
        viewModel = CategoryViewModel.init(Delegate: self, view: self)
        //Set Search bar in navigation
        self.setSearchBarInNavigationController(placeholderText: "Search Category", navigationTitle: "Category", navigationController: self.navigationController, navigationSearchBarDelegates: self)
        //TableView
        self.tblView.delegate = self
        self.tblView.dataSource = self
        tblView.separatorStyle = .none
        extendedLayoutIncludesOpaqueBars = true
        
       
    }
    //MARK:- other functions
    func getCategoryList()
    {
        viewModel?.getCategoryListApi(completion: { (responce) in
            if let data = responce.body?.services{
                if data.count > 0{
                    self.categoryList = data
                    self.tblView.isHidden = false
                    self.lblNoRecord.isHidden = true
                    self.tblView.reloadData()
                   
                }
                else{
                    self.tblView.isHidden = true
                    self.lblNoRecord.isHidden = false
                }
            }
        })
    }
    //MARK:- Actions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
}

//MARK:- TableView Delegate and DataSource
extension CategoryVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.CategoryListCell, for: indexPath) as? CategoryListCell
        {
            cell.setView(categoryList:categoryList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? CategoryListCell {
            cell.contentView.backgroundColor = Appcolor.kTheme_Color
            cell.lblNAme.textColor = UIColor.white
        }
        let controller = Navigation.GetInstance(of: .FlasSaleVC) as! FlasSaleVC
        controller.categoryId = categoryList[indexPath.row].id ?? ""
         push_To_Controller(from_controller: self, to_Controller: controller)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CategoryListCell {
            cell.contentView.backgroundColor = UIColor.white
        }
    }
}

//MARK:- UISearchController Bar Delegates
extension CategoryVC : NavigationSearchBarDelegate{
    
    func textDidChange(searchBar: UISearchBar, searchText: String) {
        viewModel?.isSearching = true
//        arr_Classlist.removeAll()
//                self.viewModel?.classList(Search: searchText, Skip: KIntegerConstants.kInt0,PageSize: KIntegerConstants.kInt10,SortColumnDir: "",  SortColumn: "", ParticularId : HODdepartmentId)
        
    }
    
    func cancelButtonPress(uiSearchBar: UISearchBar) {
        viewModel?.isSearching = false
        DispatchQueue.main.async {
//            self.arr_Classlist.removeAll()
//            self.viewModel?.classList(Search: "", Skip: KIntegerConstants.kInt0,PageSize: KIntegerConstants.kInt10,SortColumnDir: "",  SortColumn: "", ParticularId : self.HODdepartmentId)
//                        self.viewModel?.classList(searchText: "", pageSize: KIntegerConstants.kInt10, filterBy: 0, skip: KIntegerConstants.kInt0)
        }
    }
}
