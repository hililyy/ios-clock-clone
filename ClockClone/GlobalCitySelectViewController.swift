//
//  GlobalCitySelectViewController.swift
//  ClockClone
//
//  Created by 강조은 on 2022/03/21.
//

import UIKit

class GlobalCitySelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var cityList: UITableView!
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
