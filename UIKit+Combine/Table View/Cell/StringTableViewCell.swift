//
//  StringTableViewCell.swift
//  UIKit+Combine
//
//  Created by Stacey on 27/10/2020.
//

import UIKit

class StringTableViewCell: ReusableTableViewCell {
	//----------------------------------------
	// MARK:- View model binding
	//----------------------------------------
	
	func bindViewModel(_ viewModel: Any) {
		let viewModel = viewModel as! StringViewModel
		nameLabel.text = viewModel.title
	}
    
	//----------------------------------------
	// MARK:- Internals
	//----------------------------------------
	
	@IBOutlet private var nameLabel: UILabel!
	
	private var viewModel: StringViewModel!
}
