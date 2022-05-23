//
//  GlobalClockViewController.swift
//  ClockClone
//
//  Created by 강조은 on 2022/03/21.
//

import UIKit
import Foundation

class GlobalClockViewController: UIViewController {
    
    var cityList: Array<String> = []
    @IBOutlet weak var selectedCityTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCityTableView.delegate = self
        selectedCityTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.selectedCityTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cityListShow" {
            guard let cityListVC: CityListTableViewController = segue.destination as? CityListTableViewController else { return }
                cityListVC.delegate = self
            cityListVC.selectedItems.append(contentsOf: cityList)
        }
    }
}

extension GlobalClockViewController: SendCityDelegate {
    func sendData(_ city: String) {
        cityList.append(city)
    }
}

extension GlobalClockViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = selectedCityTableView.dequeueReusableCell(withIdentifier: "GlobalClockTableViewCell", for: indexPath) as! GlobalClockTableViewCell
        cell.cityName.text = cityList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
}
