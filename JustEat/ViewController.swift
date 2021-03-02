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
    private let placeholder = UILabel()
    private let alert = UIAlertController()
    private var searchResults = [Restaurant]()
    private var locationManager: CLLocationManager!
    private var postcode = ""

    private var restaurantViewModels = [RestaurantViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
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
        return 100
    }
}

extension ViewController: CLLocationManagerDelegate {
    //Setting up the location manager and requests location
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    //Gets current location and sets postcode
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locations = locations.first {
            let userLocation:CLLocation = locations as CLLocation
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
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Location Error: \(error)")
    }

    //Action for fetching the restaurants on location button tapped
    @IBAction func locationTapped(_ sender: UIButton) {
        determineMyCurrentLocation()
        setRestaurants(postcode: self.postcode)
        self.searchBar.text = self.postcode
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }

        //        Changing MVC to MVVM
        let restaurantViewModel = restaurantViewModels[indexPath.row]
        cell.restaurantViewModel = restaurantViewModel
        return cell
    }

    // Makes call to get restaurants based on postcode.  If successful, will load tableView.
    func setRestaurants(postcode: String) {
        networkManager.fetchRestaurants(postcode: postcode) { result in
            switch result {
            case.success(let results):
                DispatchQueue.main.async {
                    if results.isEmpty {
                        self.alert.title = "Please enter a valid postcode"
                        self.alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(self.alert, animated: true)
                    }

                    self.restaurantViewModels = results.map({return RestaurantViewModel(restaurant: $0)})
                    self.searchResults = results

                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Getting Results Error: \(error.localizedDescription)")
            }
        }
    }
}
