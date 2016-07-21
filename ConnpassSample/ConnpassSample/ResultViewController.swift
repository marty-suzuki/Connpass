//
//  ResultViewController.swift
//  ConnpassSample
//
//  Created by 鈴木 大貴 on 2016/07/21.
//  Copyright © 2016年 szk-atmosphere. All rights reserved.
//

import UIKit
import Connpass

class ResultViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var events: [ConnpassEvent] = [] {
        didSet {
            textView?.text = events.description
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.text = events.description
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
