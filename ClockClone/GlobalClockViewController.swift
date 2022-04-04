//
//  GlobalClockViewController.swift
//  ClockClone
//
//  Created by 강조은 on 2022/03/21.
//

import UIKit

class GlobalClockViewController: UIViewController, cityDelegate {

    var cityList : [String] = []
    var addedCity : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func selectedCity(_ controller: GlobalClockViewController, message: String) {
        cityList.append(addedCity)
    }
}
