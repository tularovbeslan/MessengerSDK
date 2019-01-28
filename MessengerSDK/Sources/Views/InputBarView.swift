//
//  InputBarView.swift
//  MessengerSDK
//
//  Created by workmachine on 24/12/2018.
//  Copyright © 2018 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit

open class InputBarView: UIView {

	lazy var textFlield: UITextField = {

		let view = UITextField()
		view.layer.drawsAsynchronously = true
		view.background = UIImage(named: "backgroundImage")
		view.placeholder = "Message"
		view.font = UIFont.systemFont(ofSize: 17)
		view.textColor = .white
		return view
	}()

	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupFlexLayout()
		backgroundColor = UIColor(red:40/255.0, green:56/255.0, blue:72/255.0, alpha: 1)
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	open override func layoutSubviews() {
		super.layoutSubviews()

		flex.layout(mode: .adjustHeight)
	}

	private func setupFlexLayout() {

		flex.addItem(textFlield).alignContent(.stretch).margin(5, 18, 5, 18).height(40)

	}
}
