//
//  ViewController+delegate.swift
//  Assignment
//
//  Created by Priyanka on 5/31/20.
//  Copyright © 2020 Priyanka. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults.count : moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return CollectionViewCell() }
        geasture(cell: cell, indexPath: indexPath)

        let movieObject =  searchController.isActive ? searchResults[indexPath.row] : moviesArray[indexPath.row]
        cell.lblMovieName.text =  movieObject.movieName
        cell.infoTextView.text = movieObject.description
        cell.backgroundColor = UIColor(displayP3Red: 248, green: 183, blue: 105, alpha: 1)
        if let url = URL(string: APIConstants.posterUrl + (movieObject.posterUrl ?? "")) {
            let data = try? Data(contentsOf: url)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                cell.imageView.image = image
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.rowIndexForDelete = indexPath
        let viewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as?  DetailViewController
        viewController?.detailObject = moviesArray[indexPath.row]
        self.navigationController?.pushViewController(viewController ?? DetailViewController(), animated: false)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
         collectionView.reloadData()
            if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            collectionView.reloadData()
        }
    }
    
}
