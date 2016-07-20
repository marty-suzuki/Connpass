//
//  SearchTableViewCell.swift
//  ConnpassSample
//
//  Created by 鈴木大貴 on 2016/07/21.
//  Copyright © 2016年 szk-atmosphere. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var endEditing: ((SearchTableViewCell, String?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.delegate = self
        selectionStyle = .None
        textField.addTarget(self, action: #selector(SearchTableViewCell.textFieldDidChange(_:)), forControlEvents: .EditingChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldDidChange(textField: UITextField) {
        endEditing?(self, textField.text)
    }
}

extension SearchTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        endEditing?(self, textField.text)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}