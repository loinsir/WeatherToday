//
//  WeatherDataView.swift
//  WeatherToday
//
//  Created by 김인환 on 2021/08/14.
//

import UIKit

protocol WeatherDataView {
    var weatherImageView: UIImageView { get set }
    var cityTitleLabel: UILabel { get set }
    var temperatureLabel: UILabel { get set }
    var rainFallProbabilityLabel: UILabel { get set }
}
