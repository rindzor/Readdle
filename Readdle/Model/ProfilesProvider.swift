//
//  FruitsProvider.swift
//  CustomCollectionLayout
//
//  Created by Vladimir Drozdin on 25/05/20.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import Foundation

struct ProfilesProvider {
    static func get() -> [Profile] {
        return [
            Profile(name: "Ivan Ivanov", icon: #imageLiteral(resourceName: "network"), email: "ivanivanov@gmail.com", status: "online"),
            Profile(name: "Vladimir Drozdin", icon: #imageLiteral(resourceName: "network"), email: "drozdin@stud.onu.edu.ua", status: "online"),
            Profile(name: "Viktor Ivanov", icon: #imageLiteral(resourceName: "network"), email: "ivanov@stud.onu.edu.ua", status: "online"),
            Profile(name: "Michail Butnik", icon: #imageLiteral(resourceName: "network"), email: "butnik@stud.onu.edu.ua", status: "online"),
            Profile(name: "Sindar Pichai", icon: #imageLiteral(resourceName: "network"),  email: "google@gmail.com", status: "online"),
            Profile(name: "Pohdan Pidhornyi", icon: #imageLiteral(resourceName: "network"), email: "pidhornyi@stud.onu.edu.ua", status: "online"),
            Profile(name: "Yuilia Yulianovna", icon: #imageLiteral(resourceName: "network"), email: "khomich.yulia@gmail.com", status: "online"),
            Profile(name: "Mark Zuckerberg", icon: #imageLiteral(resourceName: "network"), email: "facebook@gmail.com", status: "online"),
            Profile(name: "Satya Nadella", icon: #imageLiteral(resourceName: "network"), email: "microsoft@gmail.com", status: "online"),
            Profile(name: "Elon Mask", icon: #imageLiteral(resourceName: "network"), email: "teslamotors@gmail.com", status: "online"),
            Profile(name: "Tim Cook", icon: #imageLiteral(resourceName: "network"), email: "timkuk@gmail.com", status: "online"),
            Profile(name: "Johny Ive", icon: #imageLiteral(resourceName: "network"), email: "johnyivegmail.com", status: "online")
        ]
    }
}


