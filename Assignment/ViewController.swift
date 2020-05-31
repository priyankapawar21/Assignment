//
//  ViewController.swift
//  Assignment
//
//  Created by Priyanka on 5/29/20.
//  Copyright © 2020 Priyanka. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var moviesArray = [Movie]()
    var result = [Response]()
    var searchResults = [Movie]()
    let searchController = UISearchController(searchResultsController: nil)
    var rowIndexForDelete = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabbar()
        configCollectionView()
        self.collectionView.backgroundColor = UIColor.lightGray
        configSearchBar()
    }

    func configCollectionView() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    func configSearchBar() {
        self.navigationItem.titleView = searchController.searchBar
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationController?.navigationBar.backgroundColor  = UIColor(displayP3Red: 248, green: 183, blue: 105, alpha: 1)
    }
    func configTabbar() {
        tabBar.delegate = self
        self.tabBar.barTintColor =  UIColor(displayP3Red: 248, green: 183, blue: 105, alpha: 1)
        if let tabtIems = tabBar.items {
            tabBar.selectedItem = tabtIems[.zero]
            getDetails(item: tabtIems[.zero])
        }
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.collectionView.dataSource =  self
        getDetails(item: item)
    }
    func geasture(cell: UICollectionViewCell, indexPath: IndexPath){
        rowIndexForDelete = indexPath
        let UpSwipe = UISwipeGestureRecognizer(target: self, action: #selector(reset(sender:)))
        UpSwipe.direction = UISwipeGestureRecognizer.Direction.left
        cell.addGestureRecognizer(UpSwipe)
    }
    
    @objc
    func reset(sender: UISwipeGestureRecognizer) {
        collectionView.performBatchUpdates( {
               DispatchQueue.main.async {
                self.moviesArray.remove(at: self.rowIndexForDelete.row)
            }
        }, completion: nil)
      }
    
    func getDetails(item: UITabBarItem) {
        switch item.tag {
        case 1:
            
            AF.request(APIConstants.moviesUrl).response { response in
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let tweetRequest = try decoder.decode(Response.self, from: data)
                    if let tempMoviewArray = tweetRequest.moviesArray{
                        self.moviesArray = tempMoviewArray
                        self.searchResults = self.moviesArray
                        DispatchQueue.main.async {
                             self.collectionView.reloadData()
                            self.collectionView.selectItem(at: IndexPath(row: .zero, section: .zero), animated: false, scrollPosition: .top)
                         }
                    }
                } catch let error {
                    print(error)
                }
            }
            
        case 2:
            AF.request(APIConstants.topratedUrl).response { response in
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let tweetRequest = try decoder.decode(Response.self, from: data)

                    if let tempMoviewArray = tweetRequest.moviesArray{
                        self.moviesArray = tempMoviewArray
                        self.searchResults = self.moviesArray
                    }
                    DispatchQueue.main.async {
                         self.collectionView.reloadData()
                        self.collectionView.selectItem(at: IndexPath(row: .zero, section: .zero), animated: false, scrollPosition: .top)

                     }
                } catch let error {
                    print(error)
                }
            }
        default:
            break
        }
    }
    private func createLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let grupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: grupSize, subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 5
    
    let layout = UICollectionViewCompositionalLayout(section: section)

    return layout
    }
    
    func filterContent(for searchText: String) {
        // Update the searchResults array with matches
        // in our entries based on the title value.
        searchResults = moviesArray.filter({ (movie: Movie) -> Bool in
            let match = movie.movieName?.range(of: searchText, options: .caseInsensitive)
            // Return the tuple if the range contains a match.
            collectionView.reloadData()
            return match != nil
            
        })
        collectionView.reloadData()
        
    }
}

