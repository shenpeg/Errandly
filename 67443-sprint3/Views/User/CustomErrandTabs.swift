import SwiftUI

public struct CustomErrandTabs<Data, Content>: View where Data: Hashable, Content: View {
    public let sources: [Data]
    public let selection: Data?
    private let itemBuilder: (Data) -> Content

    public init(
        _ sources: [Data],
        selection: Data?,
        @ViewBuilder itemBuilder: @escaping (Data) -> Content
    ) {
        self.sources = sources
        self.selection = selection
        self.itemBuilder = itemBuilder
    }

  public var body: some View {
      ZStack(alignment: .top) {
          HStack(spacing: 0) {
              ForEach(sources, id: \.self) { item in
                  itemBuilder(item)
                      .background(item == selection ? backgroundGray : darkBlue)
              }
          }
          .clipShape(
              RoundedRectangle(cornerRadius: 15)
                  .corners([.topLeft, .topRight], radius: 15)
          )
          .overlay(
              RoundedRectangle(cornerRadius: 15)
                  .corners([.topLeft, .topRight], radius: 15)
                  .stroke(backgroundGray, lineWidth: 1)
          )
      }
  }
}

extension RoundedRectangle {
    func corners(_ corners: UIRectCorner, radius: CGFloat) -> some Shape {
        return AnyShape { rect in
            var path = Path()
            let bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            path.addPath(Path(bezierPath.cgPath))
            return path
        }
    }
}

struct AnyShape: Shape {
    private var path: @Sendable (CGRect) -> Path

    init(_ path: @escaping @Sendable (CGRect) -> Path) {
        self.path = path
    }

    func path(in rect: CGRect) -> Path {
        path(rect)
    }
}
