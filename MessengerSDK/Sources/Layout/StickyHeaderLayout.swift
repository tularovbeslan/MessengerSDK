//
//  StickyHeaderLayout.swift
//  MessengerSDK
//
//  Created by workmachine on 04/01/2019.
//  Copyright © 2019 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit

public class StickyHeaderLayout: UICollectionViewFlowLayout {
	
	open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		
		if var layoutAttributes = super.layoutAttributesForElements(in: rect) {
			
			let headerNeedLayout = NSMutableIndexSet()
			
			for attributes in layoutAttributes {
				if attributes.representedElementCategory == .cell {
					headerNeedLayout.add(attributes.indexPath.section)
				}
			}
			
			for attributes in layoutAttributes {
				if let elementKind = attributes.representedElementKind {
					if elementKind == UICollectionView.elementKindSectionHeader {
						headerNeedLayout.remove(attributes.indexPath.section)
					}
				}
			}
			
			headerNeedLayout.enumerate { (index, stop) in
				let indexPath = IndexPath(item: 0, section: index)
				let attributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath)
				layoutAttributes.append(attributes!)
			}
			
			return layoutAttributes
		} else {
			return nil
		}
	}
	
	
	open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		return true
	}
}
