//
//  Image.swift
//  XcodeDemo
//
//  Created by Brian Hu on 6/2/16.
//  Copyright © 2016 AlphaCamp. All rights reserved.
//

import UIKit

class Image {

    static var images = [Image(name: "coffee", description: "It's a nice cup of coffe"),
                         Image(name: "airplane", description: "I like taking the airplane")]
    
    var name: String
    var description: String?
    
    init(name: String, description: String?) {
        self.name = name
        self.description = description
    }
}
