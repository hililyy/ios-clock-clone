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
    @IBOutlet weak var editBtn: UIBarButtonItem!
    
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
    
    @IBAction func editTable(_ sender: Any) {
        if self.selectedCityTableView.isEditing {
            self.editBtn.title = "편집"
            self.selectedCityTableView.setEditing(false, animated: true)
        } else {
            self.editBtn.title = "완료"
            self.selectedCityTableView.setEditing(true, animated: true)
            
        }
    }
}

extension GlobalClockViewController: SendCityDelegate {
    func sendData(_ city: String) {
        cityList.append(city)
        selectedCityTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cityList.remove(at: (indexPath as NSIndexPath).row)
            selectedCityTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = cityList[(sourceIndexPath as NSIndexPath).row]
        cityList.remove(at: (sourceIndexPath as NSIndexPath).row)
        cityList.insert(itemToMove, at: (destinationIndexPath as NSIndexPath).row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .black
    }
}
