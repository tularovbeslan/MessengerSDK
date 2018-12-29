//
//  MessengerView.swift
//  MessengerSDK
//
//  Created by workmachine on 24/12/2018.
//  Copyright © 2018 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit

open class MessengerView: UIView {
	
	let numberOfItems = 50
	var randomCellStyle: CellStyle { return arc4random_uniform(10) % 2 == 0 ? .blue : .gray }
	
	lazy var style: [CellStyle] = { (0..<self.numberOfItems).map { _ in self.randomCellStyle } }()
	lazy var topOffset: [CGFloat] = { (0..<self.numberOfItems).map { _ in CGFloat(arc4random_uniform(250)) } }()
	
	var insets: UIEdgeInsets {
		return UIEdgeInsets(top: 200, left: 0, bottom: 200, right: 0)
	}
	
	var additionalInsets: UIEdgeInsets {
		return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
	}
	
	public lazy var layout = BouncyLayout(style: .default)
	
	public lazy var collectionView: UICollectionView = {
		
		
		let view = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.red
		view.showsVerticalScrollIndicator = false
		view.showsHorizontalScrollIndicator = false
		view.delegate = self
		view.dataSource = self
		view.register(MessengerViewCell.self, forCellWithReuseIdentifier: String(describing: MessengerViewCell.self))
		
		return view
	}()
	
	public init() {
		super.init(frame: CGRect.zero)
		setupView()
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		setupView()
	}
	
	fileprivate func setupView() {
		
		self.backgroundColor = .white
		self.clipsToBounds = true
		
		collectionView.contentInset = UIEdgeInsets(top: insets.top + additionalInsets.top, left: insets.left + additionalInsets.left, bottom: insets.bottom + additionalInsets.bottom, right: insets.right + additionalInsets.right)
		collectionView.scrollIndicatorInsets = UIEdgeInsets(top: insets.top, left: insets.left, bottom: insets.bottom, right: insets.right)
		self.addSubview(collectionView)
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: -insets.top),
			collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -insets.left),
			collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets.bottom),
			collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: insets.right)
			])
	
	}
}

extension MessengerView: UICollectionViewDataSource {
	
	open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return numberOfItems
	}
	
	open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MessengerViewCell.self), for: indexPath)
	}
	
	open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		guard let cell = cell as? MessengerViewCell else { return }
		cell.setCell(style: style[indexPath.row])
	}
}

extension MessengerView: UICollectionViewDelegateFlowLayout {
	
	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: UIScreen.main.bounds.width, height: 150)
	}
	
	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return  0
	}
	
	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return  0
	}
}
