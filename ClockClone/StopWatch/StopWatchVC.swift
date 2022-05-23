//
//  StopWatchVC.swift
//  ClockClone
//
//  Created by 강조은 on 2022/05/20.
//

import UIKit

class StopWatchVC: UIViewController {


    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var decimalLabel: UILabel!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var recordTimeTableView: UITableView!
    
    var timeState: Bool = false
    var mainTimer: Timer?
    var timeCount: Int = 0
    var rapCountArray: [Int] = []
    var rapCount: Int = 1
    var rapList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recordTimeTableView.dataSource = self
        self.recordTimeTableView.delegate = self
        initialize()
    }
    
    func initialize() {
        rightBtn.setTitle("시작", for: .normal)
        leftBtn.setTitle("랩", for: .normal)
        leftBtn.isEnabled = false
        
        timeCount = 0
        rapCount = 1
        timeLabel.text = "00:00"
        decimalLabel.text = ".00"
        
        rapList.removeAll()
        recordTimeTableView.reloadData()
        
        stopTime()
    }
    
    @IBAction func touchRight(_ sender: Any) {
        timeState = !timeState
        
        if timeState {
            movingTime()
            rightBtn.setTitle("중단", for: .normal)
            leftBtn.setTitle("랩", for: .normal)
            leftBtn.isEnabled = true
        } else {
            stopTime()
            rightBtn.setTitle("시작", for: .normal)
            leftBtn.setTitle("재설정", for: .normal)
            leftBtn.isEnabled = true
        }
    }
    
    @IBAction func touchLeft(_ sender: Any) {
        if timeState {
            //랩 눌렀을때?
            rapCountArray.insert(rapCount, at: rapCountArray.startIndex)
            
            let timeString = self.makeTimeLabel(count: self.timeCount)
            rapList.append("\(timeString.0).\(timeString.1)")
            rapCount += 1
            self.recordTimeTableView.reloadData()
            
        } else {
            // 재설정
            initialize()
        }
    }
    
    func movingTime() {
        mainTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {
            (_) in self.timeCount += 1

            DispatchQueue.main.async {
                let timeString = self.makeTimeLabel(count: self.timeCount)
                self.timeLabel.text = timeString.0
                self.decimalLabel.text = ".\(timeString.1)"
            }
        })
    }
    
    func stopTime() {
        mainTimer?.invalidate()
        mainTimer = nil
    }
    
    func makeTimeLabel(count: Int) -> (String, String) {
        let decimalSec = count % 100
        let sec = (count / 100) % 60
        let min = (count / 100) / 60
        let sec_string = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"
        let min_string = "\(min)".count == 1 ? "0\(min)" : "\(min)"
        return ("\(min_string):\(sec_string)","\(decimalSec)")
    }
    
}
class rapListCell: UITableViewCell {
    @IBOutlet weak var rapNumber: UILabel!
    @IBOutlet weak var rapTime: UILabel!
    
}
extension StopWatchVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rapList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recordTimeTableView.dequeueReusableCell(withIdentifier: "rapListCell", for: indexPath) as! rapListCell
        
        cell.rapNumber.text = "랩 \(rapCountArray[indexPath.row])"
        cell.rapTime.text = rapList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
