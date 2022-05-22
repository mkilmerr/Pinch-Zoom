//
//  InfoPanelView.swift
//  Pinch
//
//  Created by Marcos Kilmer Pereira de Aquino on 21/05/22.
//

import SwiftUI

struct InfoPanelView: View {
    // MARK: - PROPERTY
    var scale: Double
    var offset: CGSize

    // MARK: - STATE
    @State private var isInfoPanelShowing: Bool = false

    // MARK: - CONTENT

    var body: some View {
        HStack {
            // MARK: - HOTSPOT
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1.0) {
                    withAnimation(.easeOut) {
                        isInfoPanelShowing.toggle()
                    }
                }
            Spacer()

            // MARK: - INFO PANEL
            HStack {
                HotSpotItemView(imageName: "arrow.up.left.and.arrow.down.right", value: scale)

                HotSpotItemView(imageName: "arrow.left.and.right", value: offset.width)

                HotSpotItemView(imageName: "arrow.up.and.down", value: offset.width)
            }
            .font(.footnote)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelShowing ? 1 : 0)
        }
        .padding(8)
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(scale: 1.0, offset: .zero)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()

    }
}
