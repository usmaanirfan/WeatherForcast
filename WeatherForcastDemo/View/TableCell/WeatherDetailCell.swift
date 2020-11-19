//
//  WeatherDetailCell.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 17/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//

import UIKit

class WeatherDetailCell: UITableViewCell,ForecastDetailCellViewProtocol {
    var presenter: WeatherDetailCellPresenterProtocol?
    @IBOutlet var weatherDetailLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var weatherStateName: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dateLabel.textColor = UIColor.gray
        self.weatherDetailLabel.textColor = UIColor.gray
    }
    
    func configure(with presenter: WeatherDetailCellPresenter) {
        self.weatherDetailLabel.text = presenter.weatherDetail
        self.dateLabel.text = presenter.applicableDate
        self.weatherStateName.text = presenter.consolidatedWeather.weatherStateName
        presenter.fetchWeatherIcon()
    }
    
    public static var cellId: String {
        return Constants.CellIdentifiers.WeatherDetailCell
    }
    
    public static var bundle: Bundle {
        return Bundle(for: WeatherDetailCell.self)
    }
    
    public static var nib: UINib {
        return UINib(nibName: WeatherDetailCell.cellId, bundle: WeatherDetailCell.bundle)
    }
    
    public static func register(with tableView: UITableView) {
        tableView.register(WeatherDetailCell.nib, forCellReuseIdentifier: WeatherDetailCell.cellId)
    }
    
    public static func loadFromNib(owner: Any?) -> WeatherDetailCell {
        return bundle.loadNibNamed(WeatherDetailCell.cellId, owner: owner, options: nil)?.first as! WeatherDetailCell
    }
    
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with consolidatedWeather: ConsolidatedWeather, city : String) -> WeatherDetailCell {
        let service = APIManager(session: URLSession.shared)
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailCell.cellId, for: indexPath) as! WeatherDetailCell
        let presenter = WeatherDetailCellPresenter(with: consolidatedWeather, view: cell, service: service, city: city)
        presenter.urlBuilder = URLConfiguration(baseURL: Constants.Endpoint.baseURL)
        cell.configure(with: presenter)
        return cell
    }
    
    func setWeatherImage(with image: UIImage) {
        DispatchQueue.main.async {
            self.weatherImageView.image = image
        }
    }

}

