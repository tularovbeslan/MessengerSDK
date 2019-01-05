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
	
	var dummyArray: [[Message]] = []
	
	fileprivate let dummyItem = MessengerViewCell()
	fileprivate let dummyHeader = SectionHeader()

	public lazy var stickyHeaderLayout = StickyHeaderLayout()
	
	public lazy var collectionView: UICollectionView = {
		
		let view = UICollectionView(frame: .zero, collectionViewLayout: self.stickyHeaderLayout)
		
		stickyHeaderLayout.sectionHeadersPinToVisibleBounds = true
		
		view.backgroundColor = UIColor(red:19/255.0, green:26/255.0, blue:34/255.0, alpha: 1)
		view.contentInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
		view.delegate = self
		view.dataSource = self
		view.register(MessengerViewCell.self, forCellWithReuseIdentifier: String(describing: MessengerViewCell.self))
		view.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: SectionHeader.self))
		if #available(iOS 10.0, *) {
			view.isPrefetchingEnabled = false
		}
		
		return view
	}()
	
	public init() {
		super.init(frame: CGRect.zero)
		
		var outer: [[Message]] = []
		
		for _ in 0..<Int.random(in: 1 ..< 20) {
			
			var inner: [Message] = []
			for _ in 0..<Int.random(in: 1 ..< 100) {
				let text = arc4random() % 2 == 0 ? fakeText.lorem.sentences() : fakeText.lorem.sentences()
				let date = Date.random()
				let isIncomming = fakeText.number.randomBool()
				let message = Message.init(text: text, date: date, isIncomming: isIncomming)
				inner.append(message)
			}
			
			outer.append(inner)
		}
		
		dummyArray = outer
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
	
	public func numberOfSections(in collectionView: UICollectionView) -> Int {
		return dummyArray.count
	}
	
	open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dummyArray[section].count
	}
	
	open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MessengerViewCell.self), for: indexPath) as! MessengerViewCell
		cell.setup(message: dummyArray[indexPath.section][indexPath.row])
		return cell
	}
}

extension MessengerView: UICollectionViewDelegateFlowLayout {
	
	public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String.init(describing: SectionHeader.self), for: indexPath) as! SectionHeader
		headerView.setup(message: dummyArray[indexPath.section][indexPath.row])
		headerView.titleLabel.textColor = .white
		return headerView
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		
		return CGSize(width: collectionView.frame.width, height: 26)
	}
	
	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		dummyItem.setup(message: dummyArray[indexPath.section][indexPath.row])
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

extension MessengerView: UIScrollViewDelegate {
	
	public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		headerView(isHidden: false)
	}
	
	public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		headerView(isHidden: true)
	}
	
	func headerView(isHidden: Bool) {
		
		let alpha: CGFloat = isHidden ? 0 : 1
		if let elementKind = collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).first {
			let cell = elementKind as! SectionHeader
			UIView.animate(withDuration: 0.25) {
				cell.contentView.alpha = alpha
			}
		}
	}
}
