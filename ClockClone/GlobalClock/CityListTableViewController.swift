//
//  CityListTableViewController.swift
//  ClockClone
//
//  Created by 강조은 on 2022/03/21.
//

import UIKit



class CityListTableViewController: UIViewController {
    var cityItem: [[String]] = [
        ["가보로네, 보츠와나","가자, 팔레스타인"],
        ["나소, 바하마","나우루, 미크로네시아"],
        ["다롄, 중국 본토","다르에스살람, 탄자니아"],
        ["라고스, 나이지리아","라로통가, 쿡 제도"],
        ["마가단, 러시아","마나과, 니카라과"],
        ["바그다드, 이라크","바르샤바, 폴란드"],
        ["사나, 예멘","사라예보, 보스니아 헤르체고비나"],
        ["아과스칼리엔테스, 멕시코","아나디리, 러시아"],
        ["자그레브, 크로아티아","자야푸라, 인도네시아"],
        ["채텀 섬, 뉴질랜드","청두, 중국 본토"],
        ["카나리아 제도, 스페인","카디프, 웨일스"],
        ["타라와, 키리바시","타슈켄트, 우즈베키스탄"],
        ["파고파고, 미국령 사모아","파나마 시티, 파나마"],
        ["하노이, 베트남","하라레, 짐바브웨"]
    ]
    
    var selectedItems: [String] = []

    var sections: [String] = ["ㄱ","ㄴ","ㄷ","ㄹ","ㅁ","ㅂ","ㅅ","ㅇ","ㅈ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]

    var selectedCity: String = ""

    @IBOutlet var cityTableView: UITableView!
    @IBOutlet var cancelBtn: UIButton!
    weak var delegate: SendCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.delegate = self
        cityTableView.dataSource = self

        for count in selectedItems {
            if let index = cityItem.firstIndex(where: {$0.contains(count)}),
               let subIndex = cityItem[index].firstIndex(of: count) {
                cityItem[index].remove(at: subIndex)
                if cityItem[index].count == 0 {
                    self.sections.remove(at: index)
                    self.cityItem.remove(at: index)
                }
            }
        }
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

class cityListCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    
}

protocol SendCityDelegate: AnyObject {
    func sendData(_ city: String)
}

extension CityListTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityItem[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityListCell", for: indexPath) as! cityListCell
        cell.cityLabel.text = cityItem[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity = cityItem[indexPath.section][indexPath.row]
        self.delegate?.sendData(self.selectedCity)
        
        self.dismiss(animated: true, completion: {
            self.cityItem[indexPath.section].remove(at: indexPath.row)
            self.cityTableView.beginUpdates()
            self.cityTableView.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .fade)
            self.cityTableView.endUpdates()
            
        })
    }

}
