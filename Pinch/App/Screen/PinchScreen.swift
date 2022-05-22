//
//  PinchScreen.swift
//  Pinch
//
//  Created by Marcos Kilmer Pereira de Aquino on 20/05/22.
//

import SwiftUI

enum ImageScale: CGFloat {
    case zoomOut = 1.0
    case zoomIn = 5.0
}

struct PinchScreen: View {
    // MARK: - STATE
    @State private var isMainImageAnimating: Bool = false
    @State private var imageScaleValue: CGFloat = 1.0
    @State private var mainImageOffset: CGSize = .zero
    @State private var pageIndex: Int = 1

    // MARK: - PROPERTY
    private var doubleClick: Int = 2
    private var zoomInValue: CGFloat = ImageScale.zoomIn.rawValue
    private var zoomOutValue: CGFloat = ImageScale.zoomOut.rawValue
    private var pages: [Page] = PageData.shared.getPages()

    // MARK: - FUNCTION

    private func zoomOut() {
        imageScaleValue = zoomOutValue
    }

    private func zoomIn() {
        imageScaleValue = zoomInValue
    }

    private func setOffset(with value: CGSize) {
        mainImageOffset = value
    }

    private func springAnimation(action: @escaping (() -> Void)) {
        withAnimation(.spring()) {
            action()
        }
    }

    private func linearAnimation(action: @escaping (() -> Void)){
        withAnimation(.linear(duration: 1.0)) {
           action()
        }
    }

    private func drawerImageSelected(page: Page) {
        springAnimation {
            pageIndex = page.id
        }
    }
    // MARK: - CONTENT

    var body: some View {
        // MARK: - NAVIGATION
        NavigationView {
            ZStack {
                Color.clear
                Image(pages[pageIndex - 1].imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10.0)
                    .shadow(color: .black.opacity(0.5), radius: 12, x: 12, y: 12)
                    .padding()
                    .opacity(isMainImageAnimating ? 1 : 0)
                    // MARK: - IMAGE SCALE
                    .animation(.linear(duration: 1.0), value: isMainImageAnimating)
                    .scaleEffect(imageScaleValue)
                    .offset(x: mainImageOffset.width, y: mainImageOffset.height)
                    .onTapGesture(count: doubleClick) {
                        if imageScaleValue == zoomOutValue {
                            springAnimation {
                                imageScaleValue = zoomInValue
                            }
                        } else {
                            springAnimation {
                                imageScaleValue = zoomOutValue
                            }
                        }
                    }
                    // MARK: - DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                linearAnimation {
                                    setOffset(with: value.translation)
                                }
                            })
                            .onEnded({ _ in
                                springAnimation {
                                    imageScaleValue = zoomOutValue
                                    setOffset(with: .zero)
                                }
                            })
                    )

            } // : ZSTACK
            .onAppear(perform: {
                isMainImageAnimating = true
            })
            .navigationTitle("Pinch & Zoom")
            .overlay(
                InfoPanelView(scale: imageScaleValue, offset: mainImageOffset)
                    .padding(.top, 30)
                , alignment: .top
            )
            // MARK: - CONTROL PANEL
            .overlay(
                HStack {
                    Group {
                        Button {
                            springAnimation {
                                if imageScaleValue != zoomOutValue {
                                    imageScaleValue -= 1
                                }
                            }
                        } label: {
                            ControlImageView(imageName: "minus.magnifyingglass")
                        }

                        Button {
                            springAnimation {
                                if imageScaleValue == zoomOutValue {
                                    imageScaleValue = zoomInValue
                                } else {
                                    imageScaleValue = zoomOutValue
                                }
                            }
                        } label: {
                            ControlImageView(imageName: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        Button {
                            springAnimation {
                                if imageScaleValue != zoomInValue {
                                    imageScaleValue += 1
                                }
                            }
                        } label: {
                            ControlImageView(imageName: "plus.magnifyingglass")
                        }
                    }
                }
                    .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                    .background(.ultraThinMaterial)
                    .cornerRadius(22)
                    .opacity(isMainImageAnimating ? 1 : 0)
                , alignment: .bottom
            )
            .overlay(
                DrawerView(drawerPageItems: pages, drawerSelected: drawerImageSelected)
                    .cornerRadius(12)
                    .opacity(isMainImageAnimating ? 1 : 0)
                    .padding(.top, UIScreen.main.bounds.height / 12)
                ,alignment: .topTrailing
            )
        } // : NAVIGATION
        .navigationViewStyle(.stack)
    }
}

struct PinchScreen_Previews: PreviewProvider {
    static var previews: some View {
        PinchScreen()
    }
}
