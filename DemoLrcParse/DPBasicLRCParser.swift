//
//  DPBasicLRCParser.swift
//  DemoLrcParse
//
//  Created by baophan on 2015/07/22.
//  Copyright (c) 2015年 @baophan94. All rights reserved.
//

import UIKit

class DPBasicLRCParser: NSObject {
	
	func parseLyricWithString(lrcContent: String) -> DPLyricItem {
		var lyricItem: DPLyricItem = DPLyricItem()
		
		// Read lines of string to array
		var lyricsArray = lrcContent.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
		
		for (var i = 0, c = lyricsArray.count; i < c; i++) {
			var phrase = lyricsArray[i]
			if phrase.hasPrefix("[") {
				if phrase.hasPrefix("[ti:") || phrase.hasPrefix("[ar:") || phrase.hasPrefix("[al:") || phrase.hasPrefix("[by:") {
					var introText = phrase.substringWithRange(Range<String.Index>(
											start: advance(phrase.startIndex, 4),
											end: advance(phrase.endIndex, -1)))
					switch phrase.substringWithRange(Range<String.Index>(start: advance(phrase.startIndex, 1), end: advance(phrase.startIndex, 3))) {
						case "ti":
							lyricItem.title		= introText
						case "ar":
							lyricItem.artist	= introText
						case "al":
							lyricItem.album		= introText
						case "by":
							lyricItem.by		= introText
						default:
							println()
					}
				}
				else {
					let characterset = NSCharacterSet(charactersInString: "[]")
					let result = phrase.componentsSeparatedByCharactersInSet(characterset)
					var time = convertTimeToDouble(result[1])
					var text = result[2]
					lyricItem.lyricContent[time] = text
				}
			}
		}
		
		return lyricItem
	}
	
	private func convertTimeToDouble(string:String) -> Double {
		let timeArray = string.componentsSeparatedByString(":")
		if timeArray.count < 2 {
			return 0
		}
		let min = timeArray[0].floatValue
		let sec = timeArray[1].floatValue
		return (min * 60 + sec)
	}
	
}

class DPLyricItem {
	var title			= ""
	var artist			= ""
	var	by				= ""
	var album			= ""
	var lyricContent	= [Double: String]()
}

extension String {
	var floatValue: Double {
		return (self as NSString).doubleValue
	}
}