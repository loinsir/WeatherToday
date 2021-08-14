//
//  CityListViewController.swift
//  WeatherToday
//
//  Created by 김인환 on 2021/08/10.
//

import UIKit

class CityListViewController: UIViewController {
    
    var assetName: String?
    var weatherDatas: [WeatherData] = []
    
    @IBOutlet var tableView: UITableView!
    
    func addTableView() {
        let tableView: UITableView = {
            let tableView: UITableView = UITableView()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.cellIdentifier)
            return tableView
        }()
        
        // Auto Layout
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        self.tableView = tableView
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let jsonDecoder: JSONDecoder = JSONDecoder()

        guard let cityName: String = assetName, let dataAsset: NSDataAsset = NSDataAsset(name: cityName) else {
            return
        }
        
        do {
            self.weatherDatas = try jsonDecoder.decode([WeatherData].self, from: dataAsset.data)
        } catch  {
            print(error.localizedDescription)
        }
        
        self.addTableView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CityListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CityTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.cellIdentifier, for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        
        let weatherImage: UIImage? = getWeatherImageByIndexPath(indexPath: indexPath)
        cell.weatherImageView.image = weatherImage
        
        let cityTitle: String = self.weatherDatas[indexPath.row].cityName
        cell.cityTitleLabel.text = cityTitle

        setTemperatureLabelByIndexPath(view: cell, indexPath: indexPath)
        setRainFallProbabilityLabelByIndexPath(view: cell, indexPath: indexPath)
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailWeatherViewController: DetailWeatherViewController = {
            let viewController: DetailWeatherViewController = DetailWeatherViewController()
            let cityName: String = self.weatherDatas[indexPath.row].cityName
            viewController.title = cityName
            
            let weatherImage: UIImage? = self.getWeatherImageByIndexPath(indexPath: indexPath)
            
            viewController.weatherImageView.image = weatherImage
            viewController.cityTitleLabel.text = cityName
            
            setTemperatureLabelByIndexPath(view: viewController, indexPath: indexPath)
            setRainFallProbabilityLabelByIndexPath(view: viewController, indexPath: indexPath)
            
            return viewController
        }()
        self.navigationController?.pushViewController(detailWeatherViewController, animated: true)
    }
    
    // MARK: - Set Weather Views By IndexPath
    func getWeatherImageByIndexPath(indexPath: IndexPath) -> UIImage? {
        let state: Int = self.weatherDatas[indexPath.row].state
        let imageName: String
        switch state {
            case 10:
                imageName = "sunny"
            case 11:
                imageName = "cloudy"
            case 12:
                imageName = "rainy"
            case 13:
                imageName = "snowy"
            default:
                imageName = "sunny"
        }
        guard let image: UIImage = UIImage(named: imageName) else {
            return nil
        }

        return image
    }
    
    func setTemperatureLabelByIndexPath(view: WeatherDataView, indexPath: IndexPath) {
        let celsius: Float = self.weatherDatas[indexPath.row].celsius
        let fahrenheit: Float = (celsius * 9 / 5) + 32              // Fahrenheit = (Celsius × 9/5) + 32
        let text: String = "섭씨 \(celsius)도 / 화씨 \(String.init(format: "%0.1f", fahrenheit))도"
        if celsius < 10 {
            view.temperatureLabel.textColor = .systemBlue
        } else if celsius > 25 {
            view.temperatureLabel.textColor = .systemRed
        } else {
            view.temperatureLabel.textColor = .black
        }
        view.temperatureLabel.text = text
    }
    
    func setRainFallProbabilityLabelByIndexPath(view: WeatherDataView, indexPath: IndexPath) {
        let probability: Int = self.weatherDatas[indexPath.row].rainfallProbability
        let text: String = "강수확률 \(probability)%"
        if probability > 50 {
            view.rainFallProbabilityLabel.textColor = .systemYellow
        } else {
            view.rainFallProbabilityLabel.textColor = .black
        }
        view.rainFallProbabilityLabel.text = text
    }

}

extension CityListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
