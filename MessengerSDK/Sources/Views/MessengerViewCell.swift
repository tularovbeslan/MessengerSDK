//
//  MessengerViewCell.swift
//  MessengerSDK
//
//  Created by workmachine on 26/12/2018.
//  Copyright © 2018 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit
import FlexLayout

class MessengerViewCell: UICollectionViewCell {
	
	open var isIncoming: Bool = false {
		didSet {
			
		}
	}
	
	func setup(text: String) {
		
		textLabel.text = text
		textLabel.flex.markDirty()
		setNeedsLayout()
	}
	
	lazy var textLabel: UILabel = {
		
		let view = UILabel()
		view.font = UIFont.systemFont(ofSize: 17)
		view.textColor = .white
		view.numberOfLines = 0
		return view
	}()
	
	lazy var dateLabel: UILabel = {
		
		let view = UILabel()
		view.text = "11:55 AM"
		view.font = UIFont.systemFont(ofSize: 11)
		view.textColor = UIColor(red:143/255.0,
								 green:180/255.0,
								 blue:206/255.0, alpha: 1)
		return view
	}()
	
	lazy var leftBubbleImage: UIImage = {
		let image = UIImage(named: "left_tail_bubble")!
		return image
	}()
	
	lazy var rightBubbleImage: UIImage = {
		let image = UIImage(named: "right_tail_bubble")!
		return image
	}()
	
	lazy var bubbleContent: BubbleContent = {
		
		let view = BubbleContent()
		view.tintColor = CellStyle.light.color()
		view.image = leftBubbleImage
		return view
	}()
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupFlexLayout()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}
	
	override func sizeThatFits(_ size: CGSize) -> CGSize {
		contentView.pin.width(size.width)
		layout()
		return contentView.frame.size
	}
	
	private func layout() {
		contentView.flex.layout(mode: .adjustHeight)
	}
	
	private func setupFlexLayout() {
		
		contentView.flex.define { (flex) in
			
			flex.addItem(bubbleContent)
				.margin(2, 4, 2, 4)
				.direction(.column)
				.alignSelf(.start)
				.maxWidth(90%)
				.define({ (flex) in
					
					flex.addItem(textLabel)
						.margin(8, 18, 8, 18)
						.alignSelf(.start)
					
					flex.addItem(dateLabel)
						.alignSelf(.end)
						.margin(0, 5, 8, 18)
				})
		}
	}
}

enum CellStyle {
	
	case light
	case dark
	
	func color() -> UIColor {
		
		switch self {
		case .light:
			return UIColor(red:45/255.0, green:87/255.0, blue:130/255.0, alpha: 1)
		case .dark:
			return UIColor(red:23/255.0, green:36/255.0, blue:49/255.0, alpha: 1)
		}
	}
}
