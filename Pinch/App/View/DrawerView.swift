//
//  DrawerView.swift
//  Pinch
//
//  Created by Marcos Kilmer Pereira de Aquino on 22/05/22.
//

import SwiftUI

enum DrawerViewState: CGFloat {
    case shrunk = 60.0
    case expand = 300.0
}

enum DrawerViewIcon: String {
    case left = "chevron.compact.left"
    case right = "chevron.compact.right"
}

struct DrawerView: View {
    public var drawerPageItems: [Page]
    public var drawerSelected: ((Page) -> Void)?
    // MARK: - STATE
    @State private var drawerWidth: DrawerViewState = DrawerViewState.shrunk
    @State private var drawerIcon: DrawerViewIcon = .left

    // MARK: - CONTENT
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: drawerIcon.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 48,height: 48)
                .foregroundStyle(.secondary)
                .padding()
                .onTapGesture {
                    if drawerWidth == .shrunk {
                        withAnimation(.easeOut(duration: 0.55)) {
                            drawerIcon = .right
                            drawerWidth = .expand
                        }
                    } else {
                        withAnimation(.easeIn(duration: 0.55)) {
                            drawerIcon = .left
                            drawerWidth = .shrunk
                        }
                    }
                }


            ForEach(drawerPageItems) { item in
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .cornerRadius(8)
                    .shadow(radius: 5)
                    .onTapGesture {
                        drawerSelected?(item)
                    }
            }

        }
        .padding(.trailing, 20)
        .frame(width: drawerWidth.rawValue,height: 150, alignment: .leading)
        .background(.ultraThinMaterial)
    }
}

struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerView(drawerPageItems: [Page(id: 1, imageName: "thumb-magazine-back-cover")], drawerSelected: nil)
            .previewDevice("iPhone 13 mini")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
