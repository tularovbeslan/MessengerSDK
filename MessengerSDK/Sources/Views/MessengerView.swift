//
//  MessengerView.swift
//  MessengerSDK
//
//  Created by workmachine on 24/12/2018.
//  Copyright © 2018 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit
import PinLayout

open class MessengerView: UIView {
	
	fileprivate var messages: [[Message]] = []
	fileprivate let dummyItem = MessengerViewCell()
	fileprivate let dummyHeader = SectionHeader()
	fileprivate var lastContentOffset: CGFloat = 0.0

	public lazy var stickyHeaderLayout = StickyHeaderLayout()
	
	lazy var scrollButton: UIButton = {
		
		let image = UIImage(named: "scrollToBottom")!
		let button = UIButton()
		button.addTarget(self, action: #selector(scrollToButtom), for: UIControl.Event.touchUpInside)
		button.setImage(image, for: .normal)
		return button
	}()
	
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
		setupFlexLayout()
	}
	
	func configure(messages: [[Message]] ) {
		self.messages = messages
		collectionView.reloadData()
		setNeedsLayout()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		collectionView.pin.all()
	}
	
	private func setupFlexLayout() {

		flex.define { (container) in

			container.addItem(collectionView)

			container.addItem(scrollButton)
				.position(.absolute)
				.right(0)
				.bottom(5)
				.size(60)
		}
	}
	
	func viewOrientationDidChange() {
		stickyHeaderLayout.invalidateLayout()
	}
	
	@objc fileprivate func scrollToButtom() {
		collectionViewScrollToButtom(animation: true)
	}
}

extension MessengerView: UICollectionViewDataSource {
	
	public func numberOfSections(in collectionView: UICollectionView) -> Int {
		return messages.count
	}
	
	open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return messages[section].count
	}
	
	open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MessengerViewCell.self), for: indexPath) as! MessengerViewCell
		let message = messages[indexPath.section][indexPath.row]
		cell.setup(message: message)
		return cell
	}
}

extension MessengerView: UICollectionViewDelegateFlowLayout {
	
	public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String.init(describing: SectionHeader.self), for: indexPath) as! SectionHeader
		let message = messages[indexPath.section][indexPath.row]
		headerView.setup(message: message)
		return headerView
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		
		return CGSize(width: collectionView.frame.width, height: 26)
	}
	
	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let message = messages[indexPath.section][indexPath.row].text + "____________"
		let width = (frame.width * 0.8) - 36
		let height = message.height(withConstrainedWidth: width, font: UIFont.systemFont(ofSize: 17)) + 16 + 2
		let size = CGSize(width: frame.width, height: height)
		return size
	}

	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return  2
	}
	
	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return  2
	}
}

extension MessengerView: UIScrollViewDelegate {

	public func scrollViewDidScroll(_ scrollView: UIScrollView) {

		let isReachingEnd = scrollView.contentOffset.y >= 0
			&& scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)

		let isHidden = isReachingEnd ? true : false
		scrollToBottom(isHidden: isHidden)
	}
	
	public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		headerView(isHidden: false)
	}
	
	public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		headerView(isHidden: true)
	}
	
	public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		headerView(isHidden: !decelerate)
	}
	
	fileprivate func headerView(isHidden: Bool) {
		
		let alpha: CGFloat = isHidden ? 0 : 1
		let duration: Double = isHidden ? 0.25 : 0.10
		let delay: Double = 0.15
		let indexPaths = collectionView.indexPathsForVisibleSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader)
			
		if let indexPath = indexPaths.sorted().first {
			
			let cell = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as! SectionHeader
			UIView.animate(withDuration: duration, delay: delay, animations: {
				cell.titleLabel.alpha = alpha
			}, completion: nil)
		}
	}

	fileprivate func scrollToBottom(isHidden: Bool) {

		let alpha: CGFloat = isHidden ? 0 : 1
		let duration: Double = isHidden ? 0.25 : 0.10
		let delay: Double = 0.15

		UIView.animate(withDuration: duration, delay: delay, animations: {
			self.scrollButton.alpha = alpha
		}, completion: nil)
	}

	fileprivate func collectionViewScrollToButtom(animation: Bool) {

		guard collectionView.numberOfSections > 0 else { return }
		let lastSection = collectionView.numberOfSections - 1
		guard collectionView.numberOfItems(inSection: lastSection) > 0 else { return }
		let lastItemIndexPath = IndexPath(item: collectionView.numberOfItems(inSection: lastSection) - 1, section: lastSection)
		collectionView.scrollToItem(at: lastItemIndexPath, at: .bottom, animated: animation)
	}
}

extension String {
	func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

		return ceil(boundingBox.height)
	}

	func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

		return ceil(boundingBox.width)
	}
}
