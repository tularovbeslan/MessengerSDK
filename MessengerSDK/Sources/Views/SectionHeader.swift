//
//  SectionHeader.swift
//  MessengerSDK
//
//  Created by workmachine on 03/01/2019.
//  Copyright © 2019 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit
import FlexLayout

class SectionHeader: UICollectionReusableView {
	
	var titleLabel: UILabel = {
		
		let view = UILabel()
		view.font = UIFont.systemFont(ofSize: 15)
		return view
	}()
	
	lazy var contentView: UIView = {
		
		let view = UIView()
		view.backgroundColor = UIColor(red:19/255.0, green:26/255.0, blue:34/255.0, alpha: 1)
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.flex.define { (flex) in
			
			flex.addItem(contentView)
				.direction(.row)
				.padding(2, 2, 2, 2)
				.alignSelf(.center)
				.define({ (flex) in
					flex.addItem(titleLabel)
						.alignSelf(.center)
						.margin(2, 4, 2, 4)
				})
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setup(message: Message) {
		
		titleLabel.text = Date.day(date: message.date)
		titleLabel.flex.markDirty()
		
		setNeedsLayout()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}
	
	override func sizeThatFits(_ size: CGSize) -> CGSize {
		self.pin.width(size.width)
		layout()
		return self.frame.size
	}
	
	private func layout() {
		self.flex.layout(mode: .adjustHeight)
		
		contentView.layer.cornerRadius = contentView.frame.height / 2
	}
	
}
