//
//  rightTailBubble.swift
//  MessengerSDK
//
//  Created by workmachine on 05/01/2019.
//  Copyright © 2019 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit

class rightTailBubble: UIView {
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		drawCanvas(frame5: rect)
	}
	
	func drawCanvas(frame5: CGRect = CGRect(x: 0, y: 0, width: 52, height: 36)) {

		let fillColor = UIColor(red: 0.176, green: 0.341, blue: 0.510, alpha: 1.000)
		
		let frame3 = CGRect(x: frame5.minX, y: frame5.minY + 18, width: 20, height: 18)
		
		let right_tail_bubblePath = UIBezierPath()
		right_tail_bubblePath.move(to: CGPoint(x: frame3.minX + 2.35369 * frame3.width, y: frame3.minY + -0.00384 * frame3.height))
		right_tail_bubblePath.addCurve(to: CGPoint(x: frame3.minX + 2.35369 * frame3.width, y: frame3.minY + 0.46957 * frame3.height), controlPoint1: CGPoint(x: frame3.minX + 2.35369 * frame3.width, y: frame3.minY + 0.29939 * frame3.height), controlPoint2: CGPoint(x: frame3.minX + 2.35369 * frame3.width, y: frame3.minY + 0.45719 * frame3.height))
		right_tail_bubblePath.addCurve(to: CGPoint(x: frame3.minX + 2.58471 * frame3.width, y: frame3.minY + 0.94851 * frame3.height), controlPoint1: CGPoint(x: frame3.minX + 2.35369 * frame3.width, y: frame3.minY + 0.79915 * frame3.height), controlPoint2: CGPoint(x: frame3.minX + 2.58471 * frame3.width, y: frame3.minY + 0.94851 * frame3.height))
		right_tail_bubblePath.addCurve(to: CGPoint(x: frame3.minX + 2.60000 * frame3.width, y: frame3.minY + 0.97869 * frame3.height), controlPoint1: CGPoint(x: frame3.minX + 2.60000 * frame3.width, y: frame3.minY + 0.96068 * frame3.height), controlPoint2: CGPoint(x: frame3.minX + 2.60000 * frame3.width, y: frame3.minY + 0.96300 * frame3.height))
		right_tail_bubblePath.addCurve(to: CGPoint(x: frame3.minX + 2.58471 * frame3.width, y: frame3.minY + 1.00000 * frame3.height), controlPoint1: CGPoint(x: frame3.minX + 2.60000 * frame3.width, y: frame3.minY + 0.98915 * frame3.height), controlPoint2: CGPoint(x: frame3.minX + 2.59490 * frame3.width, y: frame3.minY + 0.99625 * frame3.height))
		right_tail_bubblePath.addCurve(to: CGPoint(x: frame3.minX + 2.06955 * frame3.width, y: frame3.minY + 0.77930 * frame3.height), controlPoint1: CGPoint(x: frame3.minX + 2.33213 * frame3.width, y: frame3.minY + 0.99123 * frame3.height), controlPoint2: CGPoint(x: frame3.minX + 2.16040 * frame3.width, y: frame3.minY + 0.91767 * frame3.height))
		right_tail_bubblePath.addCurve(to: CGPoint(x: frame3.minX + 2.05360 * frame3.width, y: frame3.minY + 0.73990 * frame3.height), controlPoint1: CGPoint(x: frame3.minX + 2.06363 * frame3.width, y: frame3.minY + 0.76769 * frame3.height), controlPoint2: CGPoint(x: frame3.minX + 2.05831 * frame3.width, y: frame3.minY + 0.75456 * frame3.height))
		right_tail_bubblePath.addCurve(to: CGPoint(x: frame3.minX + 1.45714 * frame3.width, y: frame3.minY + 0.99233 * frame3.height), controlPoint1: CGPoint(x: frame3.minX + 1.89513 * frame3.width, y: frame3.minY + 0.89691 * frame3.height), controlPoint2: CGPoint(x: frame3.minX + 1.68616 * frame3.width, y: frame3.minY + 0.99233 * frame3.height))
		right_tail_bubblePath.addLine(to: CGPoint(x: frame3.minX + 0.89655 * frame3.width, y: frame3.minY + 0.99233 * frame3.height))
		right_tail_bubblePath.addCurve(to: CGPoint(x: frame3.minX + 0.00000 * frame3.width, y: frame3.minY + -0.00384 * frame3.height), controlPoint1: CGPoint(x: frame3.minX + 0.40140 * frame3.width, y: frame3.minY + 0.99233 * frame3.height), controlPoint2: CGPoint(x: frame3.minX + 0.00000 * frame3.width, y: frame3.minY + 0.54633 * frame3.height))
		right_tail_bubblePath.addCurve(to: CGPoint(x: frame3.minX + 0.89655 * frame3.width, y: frame3.minY + -1.00000 * frame3.height), controlPoint1: CGPoint(x: frame3.minX + 0.00000 * frame3.width, y: frame3.minY + -0.55400 * frame3.height), controlPoint2: CGPoint(x: frame3.minX + 0.40140 * frame3.width, y: frame3.minY + -1.00000 * frame3.height))
		right_tail_bubblePath.addLine(to: CGPoint(x: frame3.minX + 1.45714 * frame3.width, y: frame3.minY + -1.00000 * frame3.height))
		right_tail_bubblePath.addCurve(to: CGPoint(x: frame3.minX + 2.35369 * frame3.width, y: frame3.minY + -0.00384 * frame3.height), controlPoint1: CGPoint(x: frame3.minX + 1.95229 * frame3.width, y: frame3.minY + -1.00000 * frame3.height), controlPoint2: CGPoint(x: frame3.minX + 2.35369 * frame3.width, y: frame3.minY + -0.55400 * frame3.height))
		right_tail_bubblePath.close()
		fillColor.setFill()
		right_tail_bubblePath.fill()
	}
}
