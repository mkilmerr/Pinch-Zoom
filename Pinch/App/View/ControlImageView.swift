//
//  ControlPanelView.swift
//  Pinch
//
//  Created by Marcos Kilmer Pereira de Aquino on 22/05/22.
//

import SwiftUI

struct ControlImageView: View {
    // MARK: - PROPERTY
    public var imageName: String
    // MARK: - FUNCTION

    // MARK: - CONTENT

    var body: some View {
            HStack {
                Image(systemName: imageName)
                    .font(.system(size: 36))
            }
        }
    }

struct ControlPanelView_Previews: PreviewProvider {
    static var previews: some View {
        ControlImageView(imageName: "plus.magnifyingglass")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
