//
//  ViewController.swift
//  JustEat
//
//  Created by Philippa Day on 12/02/2021.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let networkManager = NetworkManager()
    private var postcode = ""
    var placeholder = UILabel()
    var searchResults = [Restaurant]()
    var locationManager:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = .clear
        searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let restaurants = searchResults[indexPath.row]
        cell.restaurantName.text = restaurants.name
        cell.rating.text = String(format: "%.1f", restaurants.ratingStars!)
        let url = URL(string: restaurants.logoURL ?? "")
        if let url = url {
            let data = try? Data(contentsOf: url)
            if let data = data {
                cell.logo.image = UIImage(data: data)
            }
        }
        return cell
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }

        setRestaurants(postcode: searchText)
        searchBar.endEditing(true)
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension ViewController: CLLocationManagerDelegate {
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        let geoCodeLocation = CLGeocoder()
        geoCodeLocation.reverseGeocodeLocation(userLocation) { [weak self] locations, error in
            if let error = error {
                print("Geocode Error: \(error.localizedDescription)")
                return
            }

            if let location = locations?.first, let postCode = location.postalCode {
                self?.postcode = postCode
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Location Error: \(error)")
    }

    @IBAction func locationTapped(_ sender: UIButton) {
        determineMyCurrentLocation()
        self.networkManager.fetchRestaurants(postcode: self.postcode) { [weak self] result in
            switch result {
            case .success(let results):
                self?.searchResults = results
                DispatchQueue.main.async {
                    self?.searchBar.text = self?.postcode
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Location Arrow Error: \(error.localizedDescription)")
            }
        }
    }

    func setRestaurants(postcode: String) {
        networkManager.fetchRestaurants(postcode: postcode) { result in

            switch result {
            case.success(let results):
                DispatchQueue.main.async {
                    self.searchResults = results
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Getting Results Error: \(error.localizedDescription)")
            }
        }
    }
}
