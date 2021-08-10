//
//  ViewController.swift
//  WeatherToday
//
//  Created by 김인환 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var countries: [Country] = []
    
    func addTableView() {
        let tableView: UITableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView = tableView
        self.view.addSubview(self.tableView)
        
        // Auto Layout
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .systemBlue
        self.navigationController?.navigationBar.topItem?.title = "세계 날씨"
        self.view.backgroundColor = .white
        self.addTableView()
        // Do any additional setup after loading the view.
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        
        guard let dataAsset: NSDataAsset = NSDataAsset(name:"countries") else {
            return
        }
        
        do {
            self.countries = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        } catch {
            dump(error.localizedDescription)
        }
        
        self.tableView.reloadData()
    }


}

//    MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "countryCell")
        
        let flagName: String = self.countries[indexPath.row].flagName
        if let cellImage: UIImage = UIImage(named: flagName) {
            cell.imageView?.image = cellImage
        }
        
        cell.textLabel?.text = self.countries[indexPath.row].koreanName
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
