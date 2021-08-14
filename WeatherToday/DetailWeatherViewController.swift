//
//  DetailWeatherViewController.swift
//  WeatherToday
//
//  Created by 김인환 on 2021/08/11.
//

import UIKit

class DetailWeatherViewController: UIViewController, WeatherDataView {
    
    var weatherImageView: UIImageView = UIImageView()
    var cityTitleLabel: UILabel = UILabel()
    var temperatureLabel: UILabel = UILabel()
    var rainFallProbabilityLabel: UILabel = UILabel()
    
    func layoutWeatherImageView() {
        self.weatherImageView.contentMode = .scaleAspectFill
        self.view.addSubview(self.weatherImageView)
        self.weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weatherImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.weatherImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80.0),
            self.weatherImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25)
        ])
    }
    
    func layoutLabelStack() {
        let labelStack: UIStackView = {
            let stackView: UIStackView = UIStackView(arrangedSubviews: [
                cityTitleLabel, temperatureLabel, rainFallProbabilityLabel
            ])
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.spacing = 10
            return stackView
        }()
        
        self.view.addSubview(labelStack)
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            labelStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 60.0)
            labelStack.topAnchor.constraint(equalTo: self.weatherImageView.bottomAnchor, constant: 80.0)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.layoutWeatherImageView()
        self.layoutLabelStack()
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
