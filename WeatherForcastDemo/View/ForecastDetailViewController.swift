//
//  DetailViewController.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 17/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import UIKit

class ForecastDetailViewController: UITableViewController,ForecastDetailViewProtocol {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var presenter: WeatherForecastPresenterProtocol?
    var weatherResponse : WeatherDetail?
    var activityInd : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.activityInd = UIActivityIndicatorView(style: .medium)
        self.activityInd.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.activityInd)
        self.activityInd.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.activityInd.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        if let presenter = self.presenter {
            presenter.presentWeatherForecast()
            self.navigationItem.title = presenter.city
            self.activityInd.startAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkMonitor.shared.startMonitoring()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.networkRechabliltyChanged(_:)),
            name: NSNotification.Name(rawValue: Constants.Network.NetworkReachabilityChanged),
            object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NetworkMonitor.shared.stopMonitoring()
        NotificationCenter.default.removeObserver(self)
    }
        
    func setWeatherDetail(weatherResponse: WeatherDetail) {
        self.weatherResponse = weatherResponse
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityInd.stopAnimating()
        }
    }
    
    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let _ = self.weatherResponse {
            return 2
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.weatherResponse?.consolidatedWeather.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let weatherResponse = self.weatherResponse {
            var tomorrowWeather : ConsolidatedWeather?
            if indexPath.section == 0 {
                tomorrowWeather = weatherResponse.consolidatedWeather[1]
            } else {
                tomorrowWeather = weatherResponse.consolidatedWeather[indexPath.row]
            }
            if let weather = tomorrowWeather {
                let city = self.weatherResponse!.title
                let cell = WeatherDetailCell.dequeue(from: tableView, for: indexPath, with: weather, city: city)
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.TableCell.DetailCellRowHeight)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName = ""
            switch (section) {
                case 0:
                    sectionName = "Tomorrow forecast";
                    break;
                case 1:
                    sectionName = "Other days forecast";
                    break;
                default:
                    sectionName = "";
                    break;
            }
            return sectionName;
    }
    
    // MARK:
    // MARK: Notification Methods -

    /**
     This method is is called when reachability changed.
     - parameter notification: instance of NSNotification
     */
    @objc func networkRechabliltyChanged(_ notification: Notification) {
        let reachability : Bool = notification.userInfo![Constants.Network.kReachability] as! Bool
        if reachability == false {
            DispatchQueue.main.async {
                self.activityInd.stopAnimating()
                let errorAlert : UIAlertController = UIAlertController(title: "Oops!", message: "Looks like there is problem with your network.", preferredStyle: UIAlertController.Style.alert)
                let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel) { ACTION -> Void in
                }
                errorAlert.addAction(okAction)
                self.present(errorAlert, animated: true, completion: nil)
            }
        
        }
    }
    
}

