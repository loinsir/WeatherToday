//
//  CityListViewController.swift
//  WeatherToday
//
//  Created by 김인환 on 2021/08/10.
//

import UIKit

class CityListViewController: UIViewController {
    
    var navigationBarTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let title: String = navigationBarTitle {
            self.title = title
        }
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
