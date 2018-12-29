//
//  BouncyLayout.swift
//  MessengerSDK
//
//  Created by workmachine on 26/12/2018.
//  Copyright © 2018 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit

public class BouncyLayout: UICollectionViewFlowLayout {
	
	public enum BounceStyle {
		
		case off
		case `default`
		case subtle
		case regular
		case prominent
		
		var damping: CGFloat {
			
			switch self {
			case .off: return 0.0
			case .default: return 0.6
			case .subtle: return 0.8
			case .regular: return 0.7
			case .prominent: return 0.5
			}
		}
		
		var frequency: CGFloat {
			
			switch self {
			case .off: return 0
			case .default: return 1
			case .subtle: return 2
			case .regular: return 1.5
			case .prominent: return 1
			}
		}
	}
	
	private var damping: CGFloat = BounceStyle.regular.damping
	private var frequency: CGFloat = BounceStyle.regular.frequency
	
	public convenience init(style: BounceStyle) {
		self.init()
		
		damping = style.damping
		frequency = style.frequency
	}
	
	public convenience init(damping: CGFloat, frequency: CGFloat) {
		self.init()
		
		self.damping = damping
		self.frequency = frequency
	}
	
	private lazy var animator: UIDynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
	
	open override func prepare() {
		super.prepare()
		
		guard let view = collectionView, let attributes = super.layoutAttributesForElements(in: view.bounds.insetBy(dx: 0, dy: 0))?.compactMap({ $0.copy() as? UICollectionViewLayoutAttributes }) else { return }
		
		oldBehaviors(for: attributes).forEach { animator.removeBehavior($0) }
		newBehaviors(for: attributes).forEach { animator.addBehavior($0, damping, frequency) }
	}
	
	private func oldBehaviors(for attributes: [UICollectionViewLayoutAttributes]) -> [UIAttachmentBehavior] {
		
		let indexPaths = attributes.map { $0.indexPath }
		return animator.behaviors.compactMap {
			
			guard let behavior = $0 as? UIAttachmentBehavior, let itemAttributes = behavior.items.first as? UICollectionViewLayoutAttributes else { return nil }
			return indexPaths.contains(itemAttributes.indexPath) ? nil : behavior
		}
	}
	
	private func newBehaviors(for attributes: [UICollectionViewLayoutAttributes]) -> [UIAttachmentBehavior] {
		
		let indexPaths = animator.behaviors.compactMap { (($0 as? UIAttachmentBehavior)?.items.first as? UICollectionViewLayoutAttributes)?.indexPath }
		return attributes.compactMap {
			
			indexPaths.contains($0.indexPath) ? nil : UIAttachmentBehavior(item: $0, attachedToAnchor: $0.center.floored()) }
	}
	
	open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		return animator.items(in: rect) as? [UICollectionViewLayoutAttributes]
	}
	
	open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		return animator.layoutAttributesForCell(at: indexPath) ?? super.layoutAttributesForItem(at: indexPath)
	}
	
	open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		guard let view = collectionView else { return false }
		
		animator.behaviors.forEach {
			
			guard let behavior = $0 as? UIAttachmentBehavior, let item = behavior.items.first else { return }
			update(behavior: behavior, and: item, in: view, for: newBounds)
			animator.updateItem(usingCurrentState: item)
		}
		return view.bounds.width != newBounds.width
	}
	
	private func update(behavior: UIAttachmentBehavior, and item: UIDynamicItem, in view: UICollectionView, for bounds: CGRect) {
		
		let delta = bounds.origin.y - view.bounds.origin.y
		let touchLocation = view.panGestureRecognizer.location(in: view)
		let yDistance = abs(touchLocation.y - behavior.anchorPoint.y)
		let resistance = yDistance / 1000
		var center = item.center
		
		center.y += delta < 0 ? max(delta, delta * resistance) : min(delta, delta * resistance)
		
		item.center = center.floored()
	}
}

extension UIDynamicAnimator {
	
	open func addBehavior(_ behavior: UIAttachmentBehavior, _ damping: CGFloat, _ frequency: CGFloat) {
		
		behavior.damping = damping
		behavior.frequency = frequency
		addBehavior(behavior)
	}
}

extension CGPoint {
	
	func floored() -> CGPoint {
		return CGPoint(x: floor(x), y: floor(y))
	}
	
	mutating func flooredInPlace() {
		self = floored()
	}
}
