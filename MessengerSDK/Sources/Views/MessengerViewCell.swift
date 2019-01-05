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
			bubbleContent.tintColor = isIncoming ? CellStyle.dark.color() :CellStyle.light.color()
		}
	}
	
	func setup(message: Message) {
		
		isIncoming = message.isIncomming
		
		textLabel.text = message.text
		textLabel.flex.markDirty()
		
		dateLabel.text = Date.time(date: message.date)
		dateLabel.flex.markDirty()
		
		bubbleContent.flex.alignSelf(isIncoming ? .start : .end)
		bubbleContent.image = isIncoming ? leftBubbleImage : rightBubbleImage
		bubbleContent.flex.margin(2, isIncoming ? 34 : 4, 2, 4)
		
		avatar.flex.width(isIncoming ? 30 : 0)

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
		view.font = UIFont.systemFont(ofSize: 11)
		view.textColor = UIColor(red:143/255.0,
								 green:180/255.0,
								 blue:206/255.0, alpha: 1)
		return view
	}()
	
	lazy var avatar: UIImageView = {
		
		let image = UIImage(named: "avatar")!
		let view = UIImageView()
		view.layer.cornerRadius = 15
		view.clipsToBounds = true
		view.image = image
//		view.clearsContextBeforeDrawing = false
//		view.layer.allowsGroupOpacity = false
//		view.layer.drawsAsynchronously = true
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
//		view.clearsContextBeforeDrawing = false
//		view.layer.allowsGroupOpacity = false
//		view.layer.drawsAsynchronously = true
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
				.direction(.row)
				.maxWidth(80%)
				.define({ (flex) in
					
					flex.addItem(textLabel)
						.margin(8, 18, 8, 18)
						.alignSelf(.start)
						.shrink(1)

					flex.addItem(dateLabel)
						.alignSelf(.end)
						.margin(0, 5, 8, 18)
			})
			
			flex.addItem(avatar)
				.position(.absolute).bottom(2).left(4).size(30)
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
