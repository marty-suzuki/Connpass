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

    @IBOutlet weak var tableView: UITableView!
    
    private let titles = [
        "event_id",
        "keyword",
        "keyword_or",
        "ym",
        "ymd",
        "nickname",
        "owner_nickname",
        "series_id",
        "start",
        "order",
        "count"
    ]
    private var parameters: [Type] = [
        .Integer(nil),
        .Str(nil),
        .Str(nil),
        .Integer(nil),
        .Integer(nil),
        .Str(nil),
        .Str(nil),
        .Integer(nil),
        .Integer(nil),
        .Integer(nil),
        .Integer(nil)
    ]

    private enum Type {
        case Integer(Int?)
        case Str(String?)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSearchButton(sender: UIBarButtonItem) {
        search()
    }
    
    private func search() {
        view.becomeFirstResponder()
        let query = ConnpassSearchQuery(parameters.enumerate().flatMap { toParameter($0.index, element: $0.element) })
        ConnpassApiClient.sharedClient.searchEvent(query) {
            switch $0 {
            case .Success(let result):
                print(result.events)
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    private func toParameter(index: Int, element: Type) -> ConnpassSearchQuery.Parameter? {
        switch element {
        case .Integer(let value):
            guard let value = value else { return nil }
            switch index {
            case 0: return .EventId(value)
            case 3: return .Ym(value)
            case 4: return .Ymd(value)
            case 7: return .SeriesId(value)
            case 8: return .Start(value)
            case 9: return .Order(ConnpassSearchQuery.Parameter.DisplayOrder(rawValue: value) ?? .UpdateTime)
            case 10: return .Count(value)
            default: return nil
            }
        case .Str(let value):
            guard let value = value else { return nil }
            switch index {
            case 1: return .Keyword(value)
            case 2: return .KeywordOr(value)
            case 5: return .Nickname(value)
            case 6: return .OwnerNickname(value)
            default: return nil
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCell") as! SearchTableViewCell
        cell.titleLabel.text = titles[indexPath.row]
        switch parameters[indexPath.row] {
        case .Integer: cell.textField.keyboardType = .DecimalPad
        case .Str: cell.textField.keyboardType = .Default
        }
        cell.endEditing = { [weak self] in
            guard
                let text = $0.1,
                let indexPath = self?.tableView.indexPathForCell($0.0)
            else {
                return
            }
            switch self?.parameters[indexPath.row] {
            case .Some(.Integer):
                self?.parameters[indexPath.row] = .Integer(Int(text))
            case .Some(.Str):
                self?.parameters[indexPath.row] = .Str(text)
            default:
                return
            }
        }
        return cell
    }
}