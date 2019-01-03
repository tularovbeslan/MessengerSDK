//
//  MessengerView.swift
//  MessengerSDK
//
//  Created by workmachine on 24/12/2018.
//  Copyright © 2018 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit
import PinLayout
import Fakery

open class MessengerView: UIView {
	
	let fakeText = Faker()
	
	var dummyArray: [String] = []
	
	fileprivate let dummyItem = MessengerViewCell()

	public lazy var layout = BouncyLayout(style: .off)
	
	public lazy var collectionView: UICollectionView = {
		
		let view = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
		view.backgroundColor = UIColor(red:19/255.0, green:26/255.0, blue:34/255.0, alpha: 1)
		view.contentInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
		view.delegate = self
		view.dataSource = self
		view.register(MessengerViewCell.self, forCellWithReuseIdentifier: String(describing: MessengerViewCell.self))
		
		return view
	}()
	
	public init() {
		super.init(frame: CGRect.zero)
		
		for _ in 0..<100 {
			dummyArray.append(arc4random() % 2 == 0 ? fakeText.lorem.sentences() : fakeText.lorem.sentence())
		}
		
		self.addSubview(collectionView)
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)

		self.addSubview(collectionView)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		setupView()
	}
	
	fileprivate func setupView() {
		self.backgroundColor = UIColor(red:19/255.0, green:26/255.0, blue:34/255.0, alpha: 1)
		collectionView.pin.vertically().horizontally(pin.safeArea)
	}
}

extension MessengerView: UICollectionViewDataSource {
	
	open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 100
	}
	
	open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MessengerViewCell.self), for: indexPath) as! MessengerViewCell
		cell.setup(text: dummyArray[indexPath.row])
		return cell
	}
}

extension MessengerView: UICollectionViewDelegateFlowLayout {
	
	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		dummyItem.setup(text: dummyArray[indexPath.row])
		let height: CGFloat = .greatestFiniteMagnitude
		let width: CGFloat = collectionView.frame.width
		let size = dummyItem.sizeThatFits(CGSize(width: width, height: height))
		return size
	}
	
	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return  0
	}
	
	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return  0
	}
}
