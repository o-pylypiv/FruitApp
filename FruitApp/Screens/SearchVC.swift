//
//  SearchVC.swift
//  FruitApp
//
//  Created by Olha Pylypiv on 23.07.2024.
//

import UIKit

class SearchVC: UIViewController {
    
    var fruits: [Fruit] = []
    var filteredFruits: [Fruit] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Fruit>!
    var isSearching = false
    
    enum Section { case main }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureCollectionView()
        configureSearchController()
        getFruits()
        configureDataSource()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Fruit App"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FruitCell.self, forCellWithReuseIdentifier: FruitCell.reuseID)
    }
    
    func getFruits() {
        showLoadingView()
        Task {
            do {
                let fruits = try await NetworkManager.shared.getFruits()
                print(fruits.count)
                let sortedFruits = fruits.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
                self.fruits = sortedFruits
                self.updateData(on: sortedFruits)
                dismissLoadingView()
            } catch {
                if let faError = error as? FAError {
                    presentError(message: faError.rawValue)
                } else {
                    presentError(message: "Unable to complete your request. Please try again.")
                }
                dismissLoadingView()
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Fruit>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, fruit) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FruitCell.reuseID, for: indexPath) as? FruitCell else {
                fatalError("Could not dequeue cell with identifier: \(FruitCell.reuseID)")
            }
            cell.set(fruit: fruit)
            return cell
        })
    }
    
    func updateData(on fruits: [Fruit]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Fruit>()
        snapshot.appendSections([.main])
        snapshot.appendItems(fruits)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search fruit"
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
}

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFruits : fruits
        let fruit = activeArray[indexPath.item]
        
        let destVC = FruitInfoVC()
        destVC.fruit = fruit
        navigationController?.pushViewController(destVC, animated: true)
    }
}

extension SearchVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFruits.removeAll()
            isSearching = false
            updateData(on: fruits)
            return
        }
        isSearching = true
        filteredFruits = fruits.filter {$0.name.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFruits)
    }
}
