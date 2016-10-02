//
//  ViewController.swift
//  TalanaExample
//
//  Created by Fabian Buentello on 9/30/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit
import Talana

class ViewController: UIViewController {
    
    @IBOutlet weak var lanaStackView: TalanaStackView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStackJson()
    }
    
    func getStackJson() {
        
        if let fileUrl = Bundle.main.url(forResource:"TalanaJsonData", withExtension:"json"),
            let data = NSData(contentsOf: fileUrl) {
            let jsonData = JSON(data: data as Data)
            let lana = Lana(json: jsonData)
            lanaStackView.layout(lana)
        }
    }
    
    @IBAction func reloadTalanaData() {
        lanaStackView?.empty()
        getStackJson()
    }
}
