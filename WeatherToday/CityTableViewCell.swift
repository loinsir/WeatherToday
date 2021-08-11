//
//  CityListTableViewCell.swift
//  WeatherToday
//
//  Created by 김인환 on 2021/08/11.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    static let cellIdentifier: String = "cityTableViewCell"
    
    let weatherImageView: UIImageView = UIImageView()
    let cityTitleLabel: UILabel = UILabel()
    let temperatureLabel: UILabel = UILabel()
    let rainFallProbabilityLabel: UILabel = UILabel()
    
    func addWeatherImageView()  {
        self.addSubview(self.weatherImageView)
        self.weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.weatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.weatherImageView.centerXAnchor.constraint(equalTo: self.leadingAnchor, constant: 40)
        ])
    }
    
    func addtextLabels() {
        let textStackView: UIStackView = {
            let stackView: UIStackView = UIStackView(arrangedSubviews: [self.cityTitleLabel, self.temperatureLabel, self.rainFallProbabilityLabel])
            stackView.axis = .vertical
            stackView.alignment = .leading
            stackView.spacing = 10
            return stackView
        }()
        
        self.addSubview(textStackView)
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textStackView.leadingAnchor.constraint(equalTo: self.weatherImageView.trailingAnchor, constant: 15.0),
        ])
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addWeatherImageView()
        self.addtextLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
