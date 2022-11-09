import SwiftUI

extension View {
    func customSheet<HeaderContent: View,
                     ScrollViewContent: View,
                     StaticContent: View>(isPresented: Binding<Bool>,
                                          detents: Binding<[CustomHeightDetent]>,
                                          backgroundColor: Color,
                                          dragLimitType: DragLimitType = .none,
                                          shadowRadius: CGFloat = .zero,
                                          coversParentView: Bool = false,
                                          opacity: Double = 1,
                                          @ViewBuilder header: () -> HeaderContent,
                                          @ViewBuilder scrollViewContent: () -> ScrollViewContent,
                                          @ViewBuilder staticContent: () -> StaticContent) -> some View {
        
        modifier(CustomSheet(content: {
            CustomHeightBottomSheet(detents: detents,
                                    showSheet: isPresented,
                                    backgroundColor: backgroundColor,
                                    dragLimitType: dragLimitType,
                                    shadowRadius: shadowRadius,
                                    coversParentView: coversParentView,
                                    opacity: opacity,
                                    header: header,
                                    scrollViewContent: scrollViewContent,
                                    staticContent: staticContent)
        }))
    }
}
