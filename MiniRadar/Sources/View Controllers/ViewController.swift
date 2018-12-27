//
//  ViewController.swift
//  MiniRadar
//
//  Created by Виктория Бадисова on 26/12/2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let radarView = RadarView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(radarView)
    }
    
}

