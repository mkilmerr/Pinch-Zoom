//
//  PageData.swift
//  Pinch
//
//  Created by Marcos Kilmer Pereira de Aquino on 22/05/22.
//

import Foundation

class PageData {
    static let shared = PageData()

    func getPages() -> [Page] {
        let pages: [Page] = [
            Page(id: 1, imageName: "thumb-magazine-front-cover"),
            Page(id: 2, imageName: "thumb-magazine-back-cover")
        ]

        return pages
    }
}
