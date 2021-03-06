import SwiftUI

/// Source: https://github.com/globulus/swiftui-side-menu/
public struct SideMenu<MenuContent: View>: ViewModifier {
    @Binding var isShowing: Bool
    private let menuContent: () -> MenuContent
    
    public init(isShowing: Binding<Bool>,
                @ViewBuilder menuContent: @escaping () -> MenuContent) {
        _isShowing = isShowing
        self.menuContent = menuContent
    }
    
    public func body(content: Content) -> some View {
        let drag = DragGesture().onEnded { event in
            if event.location.x < 200 && abs(event.translation.height) < 50 && abs(event.translation.width) > 50 {
                withAnimation {
                    isShowing = event.translation.width > 0
                }
            }
        }
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                content
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: isShowing ? geometry.size.width / 1.5 : 0)
                
                menuContent()
                    .frame(width: geometry.size.width / 1.5)
                    .transition(.move(edge: .leading))
                    .offset(x: isShowing ? 0 : -geometry.size.width / 1.5)
            }.gesture(drag)
        }
    }
}

public extension View {
    func sideMenu<MenuContent: View>(
        isShowing: Binding<Bool>,
        @ViewBuilder menuContent: @escaping () -> MenuContent
    ) -> some View {
        self.modifier(SideMenu(isShowing: isShowing, menuContent: menuContent))
    }
}
