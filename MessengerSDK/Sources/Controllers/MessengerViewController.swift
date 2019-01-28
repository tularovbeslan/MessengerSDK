//
//  MessengerViewController.swift
//  MessengerSDK
//
//  Created by workmachine on 27/12/2018.
//  Copyright © 2018 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit
import FlexLayout
import Fakery

class MessengerViewController: UIViewController {
	
	let fakeText = Faker()

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
	
	override func loadView() {
		super.loadView()
		
		view = messengerView
		let messages = fakeMessagesGenerate()
		messengerView.configure(messages: messages)
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		//messengerView.viewOrientationDidChange()
	}
	
	fileprivate func fakeMessagesGenerate() -> [[Message]]{
		
		var outer: [[Message]]  = []
		
		for _ in 1..<20 {
			
			var inner: [Message] = []
			for _ in 1..<50 {
				let text = arc4random() % 2 == 0 ? fakeText.lorem.sentences() : fakeText.lorem.sentences()
				let date = Date.random()
				let isIncomming = fakeText.number.randomBool()
				let message = Message.init(text: text, date: date, isIncomming: isIncomming)
				inner.append(message)
			}
			
			outer.append(inner)
		}
		
		return outer
	}
}
