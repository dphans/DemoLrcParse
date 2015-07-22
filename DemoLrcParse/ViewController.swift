//
//  ViewController.swift
//  DemoLrcParse
//
//  Created by baophan on 2015/07/22.
//  Copyright (c) 2015年 @baophan94. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		testing()
		
	}
	
	func testing() {
		let lyricContent = String(
			contentsOfFile: NSBundle.mainBundle().pathForResource("sample", ofType: "lrc")!,
			encoding: NSUTF8StringEncoding,
			error: nil)
		let lrcParser	= DPBasicLRCParser()
		let lyricObject = lrcParser.parseLyricWithString(lyricContent!)
		
		println("Title:\t\(lyricObject.title)")
		println("Artist:\t\(lyricObject.artist)")
		println("Album:\t\(lyricObject.album)")
		println("By:\t\t\(lyricObject.by)")
		
		
		for (idx, line) in enumerate(lyricObject.lyricContent) {
			println("\(line.0) --> \(line.1)")
		}
		
		
		
		
	}

}

