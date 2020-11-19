//
//  MasterViewController.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 17/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import UIKit

class CityListViewController: UITableViewController {

    var detailViewController: ForecastDetailViewController? = nil
    var cities = Constants.Endpoint.cities


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Cities"
        // If we are on an iPad, show the detail view controller. If we don't do this, it'll show an empty detail view controller.
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            performSegue(withIdentifier: Constants.NavigationConstants.WeatherDetailIdentifier, sender: nil)
        }
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
        
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.NavigationConstants.WeatherDetailIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let navigationController = segue.destination as? UINavigationController
                let service = APIManager(session: URLSession.shared)
                let detailView  = navigationController?.topViewController as! ForecastDetailViewController
                let city = self.cities[indexPath.row]
                let presenter = WeatherForecastPresenter(view: detailView, service: service, city: city)
                presenter.urlBuilder = URLConfiguration(baseURL: Constants.Endpoint.baseURL)
                detailView.presenter = presenter
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.cityCell, for: indexPath)
        let object = cities[indexPath.row]
        cell.textLabel!.text = object.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.NavigationConstants.WeatherDetailIdentifier, sender: indexPath)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

}

