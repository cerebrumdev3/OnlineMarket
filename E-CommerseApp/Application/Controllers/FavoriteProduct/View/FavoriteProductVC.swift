//
//  FavoriteProductVC.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 28/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class FavoriteProductVC: BaseUIViewController {
    
    //MARK:- outlet and variables
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let spacing:CGFloat = 14.0
    var viewModel : FavoriteViewModel?
    
    //MARK:- life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    //MARK:- other functions
    func setView(){
        
        viewModel = FavoriteViewModel.init(Delegate: self, view: self)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.collectionViewLayout.invalidateLayout()
        extendedLayoutIncludesOpaqueBars = true
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
        collectionView.reloadData()
        
        //Set Search bar in navigation
         self.setSearchBarInNavigationController(placeholderText: "Search Category", navigationTitle: "Category", navigationController: self.navigationController, navigationSearchBarDelegates: self)
    }
    
    //MARK:- Actions
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}

//MARK:- Collection DataSource and Delegate
extension FavoriteProductVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.FavoriteCollectionCell, for: indexPath) as? FavoriteCollectionCell
        {
            cell.setView()
            return cell
        }
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
    
    //MARK:- FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let noOfCellsInRow = 2  //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: 282)
    }
    
    
    
}

//MARK:- UISearchController Bar Delegates
extension FavoriteProductVC : NavigationSearchBarDelegate{
    
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
