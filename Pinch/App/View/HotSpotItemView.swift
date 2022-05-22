//
//  HotSpotItemView.swift
//  Pinch
//
//  Created by Marcos Kilmer Pereira de Aquino on 21/05/22.
//

import SwiftUI

struct HotSpotItemView: View {
    // MARK: - PROPERTY
    var imageName: String
    var value: CGFloat

    // MARK: - CONTENT
    var body: some View {
        HStack {
            Image(systemName: imageName)
            Text("\(value)")
            Spacer()
        }
    }
}

struct HotSpotItemView_Previews: PreviewProvider {
    static var previews: some View {
        HotSpotItemView(imageName: "arrow.up.left.and.arrow.down.right", value: .zero)
            .previewLayout(.sizeThatFits)

    }
}
