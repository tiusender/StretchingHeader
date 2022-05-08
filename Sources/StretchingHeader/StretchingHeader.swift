import SwiftUI

public struct StretchingHeader<Content: View>: View {
    let content: () -> Content
        
    public init(@ViewBuilder content: @escaping () -> Content ) {
        self.content = content
    }
    
    func height(for proxy:GeometryProxy) -> CGFloat {
        let y = proxy.frame(in: .global).minY
        return proxy.size.height + max(0, y)
    }
    
    func offset(for proxy:GeometryProxy) -> CGFloat {
        let y = proxy.frame(in: .global).minY
        return min(0, -y)
    }
    
    public var body: some View {
        GeometryReader { geo in
            VStack(content: content)
                .frame(width: geo.size.width, height: height(for: geo))
                .offset(y: offset(for: geo))
        }
    }
}
