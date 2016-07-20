//
//  ViewController.swift
//  ConnpassSample
//
//  Created by 鈴木大貴 on 2016/07/21.
//  Copyright © 2016年 szk-atmosphere. All rights reserved.
//

import UIKit
import Connpass

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let query = ConnpassSearchQuery(.KeywordOr("swift"), .Count(5), .Start(45))
        ConnpassApiClient.sharedClient.searchEvent(query) {
            switch $0 {
            case .Success(let result):
                print(result.events)
            case .Failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

