//
//  ViewController.swift
//  JustEat
//
//  Created by Philippa Day on 12/02/2021.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private let networkManager = NetworkManager()
    private var postcode = ""
    var searchResults = [Restaurant]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row)")
        let restaurants = searchResults[indexPath.row]
        cell.restaurantName!.text = restaurants.name
        cell.rating.text = String(format: "%f", restaurants.ratingStars ?? "")
        return cell
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }

        networkManager.fetchRestaurants(postcode: searchText) { result in

            switch result {
            case.success(let results):
                DispatchQueue.main.async {
                    print("FINAL RESULT \(results[0].name)")
                    print("FINAL RESULT 2 \(results[1].name)")
//                    print("SEARCH RESULTS \(self.searchResults[0].name)")
                    self.searchResults = results
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        searchBar.endEditing(true)
    }

}


