import SwiftUI

struct CustomSheet<T: View>: ViewModifier {
    let sheetContent: T
    
    init(@ViewBuilder content: () -> T) {
        self.sheetContent = content()
    }
    
    func body(content: Content) -> some View {
        GeometryReader { _ in
            ZStack {
                content
                sheetContent
            }
        }
    }
}
