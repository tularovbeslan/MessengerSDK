//
//  MessengerViewController.swift
//  MessengerSDK
//
//  Created by workmachine on 27/12/2018.
//  Copyright © 2018 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit
import FlexLayout

class MessengerViewController: UIViewController {
	
	lazy var messengerView: MessengerView = {
		let view = MessengerView()
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		
		navigationController?.navigationBar.barTintColor = UIColor(red:24/255.0, green:35/255.0, blue:48/255.0, alpha: 1)
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
		
		title = "MessengerViewController"
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		view.flex.addItem(messengerView)
			.alignSelf(.stretch)
			.grow(1)
		
		messengerView.pin.all()
	}
	
}
