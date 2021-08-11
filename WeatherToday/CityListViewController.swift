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
            print(self.weatherDatas)
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
        
        let weatherImage: UIImage? = {
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
        }()
        
        let cityTitle: String = self.weatherDatas[indexPath.row].cityName

        let temperatureText: String = {
            let celsius: Float = self.weatherDatas[indexPath.row].celsius
            let fahrenheit: Float = (celsius * 9 / 5) + 32              // Fahrenheit = (Celsius × 9/5) + 32
            let text: String = "섭씨 \(celsius)도 / 화씨 \(String.init(format: "%0.1f", fahrenheit))도"
            if celsius < 10 {
                cell.temperatureLabel.textColor = .systemBlue
            } else if celsius > 25 {
                cell.temperatureLabel.textColor = .systemRed
            } else {
                cell.temperatureLabel.textColor = .black
            }
            return text
        }()

        let rainFallProbabilityText: String = {
            let probability: Int = self.weatherDatas[indexPath.row].rainfallProbability
            let text: String = "강수확률 \(probability)%"
            if probability > 50 {
                cell.rainFallProbabilityLabel.textColor = .systemYellow
            } else {
                cell.rainFallProbabilityLabel.textColor = .black
            }
            return text
        }()
        
        cell.weatherImageView.image = weatherImage
        cell.cityTitleLabel.text = cityTitle
        cell.temperatureLabel.text = temperatureText
        cell.rainFallProbabilityLabel.text = rainFallProbabilityText
        
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
            
            let weatherImage: UIImage? = {
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
            }()
            
            viewController.weatherImageView.image = weatherImage
            viewController.cityTitleLabel.text = cityName
            
            let temperatureText: String = {
                let celsius: Float = self.weatherDatas[indexPath.row].celsius
                let fahrenheit: Float = (celsius * 9 / 5) + 32              // Fahrenheit = (Celsius × 9/5) + 32
                let text: String = "섭씨 \(celsius)도 / 화씨 \(String.init(format: "%0.1f", fahrenheit))도"
                if celsius < 10 {
                    viewController.temperatureLabel.textColor = .systemBlue
                } else if celsius > 25 {
                    viewController.temperatureLabel.textColor = .systemRed
                } else {
                    viewController.temperatureLabel.textColor = .black
                }
                return text
            }()
            viewController.temperatureLabel.text = temperatureText
            
            let rainFallProbabilityText: String = {
                let probability: Int = self.weatherDatas[indexPath.row].rainfallProbability
                let text: String = "강수확률 \(probability)%"
                if probability > 50 {
                    viewController.rainFallProbabilityLabel.textColor = .systemYellow
                } else {
                    viewController.rainFallProbabilityLabel.textColor = .black
                }
                return text
            }()
            viewController.rainFallProbabilityLabel.text = rainFallProbabilityText
            
            return viewController
        }()
        self.navigationController?.pushViewController(detailWeatherViewController, animated: true)
    }

}

extension CityListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
