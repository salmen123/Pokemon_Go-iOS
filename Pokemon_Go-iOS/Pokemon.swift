//
//  Pokemon.swift
//  Pokemon_Go-iOS
//
//  Created by Med Salmen Saadi on 6/2/18.
//  Copyright © 2018 Med Salmen Saadi. All rights reserved.
//

import Foundation

class Pockemon  {
    
    var latitude:Double?
    var longitude:Double?
    var Image:String?
    var name:String?
    var des:String?
    var power:Double?
    var isCatch:Bool?
    
    init(latitude:Double, longitude:Double, Image:String, name:String, des:String, power:Double) {
        self.latitude=latitude
        self.longitude=longitude
        self.Image=Image
        self.name=name
        self.des=des
        self.power=power
        self.isCatch=false
    }
    
}
