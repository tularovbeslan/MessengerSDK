//
//  MessengerViewCell.swift
//  MessengerSDK
//
//  Created by workmachine on 26/12/2018.
//  Copyright © 2018 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit
import PinLayout

class MessengerViewCell: UICollectionViewCell {
	
	func setCell(style: CellStyle) {
		
		background.backgroundColor = style.color()
		let insets = UIEdgeInsets(top: 5, left: style == .blue ? 80 : 5, bottom: 5, right: style == .blue ? 5 : 80)

		
		background.pin
			.top(insets.top)
			.bottom(insets.bottom)
			.left(insets.left)
			.right(insets.right)
	}
	
	lazy var background: UIView = {
		
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 15
		view.clipsToBounds = true
		return view
	}()
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.backgroundColor = nil
		contentView.addSubview(background)
	}
}

enum CellStyle {
	
	case blue
	case gray
	
	func color() -> UIColor {
		
		switch self {
		case .blue:
			return UIColor.white.withAlphaComponent(1)
		case .gray:
			return UIColor.white.withAlphaComponent(0.7)
		}
	}
}
