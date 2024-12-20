import SwiftUI
import Foundation

struct CircularTextView: View {
    var radius: Double = 20
    var text: String = "Hello World"
    var kerning: CGFloat = 5.0
    
    private var texts: [(offset: Int, element: Character)] {
        return Array(text.enumerated())
    }
    
    @State var textSizes: [Int: Double] = [:]
    @State private var rotation: Double = 0 // State to animate the rotation
    
    var body: some View {
        ZStack {
            Image("image2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200 , height: 200)
                .rotationEffect(-self.angle(at: self.texts.count - 1) / 2)
                .frame(width: 300, height: 300, alignment: .center)
                .rotationEffect(.degrees(-rotation)) // Apply rotation effect to the whole ZStack
                .onAppear {
                    withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: false)) {
                        rotation = 360 // Rotate the text continuously
                    }
                }
            
            ForEach(self.texts, id: \.self.offset) { (offset, element) in
                VStack {
                    Text(String(element))
                        .kerning(self.kerning)
                        .background(Sizeable())
                        .onPreferenceChange(WidthPreferenceKey.self, perform: { size in
                            self.textSizes[offset] = Double(size)
                        })
                    Spacer()
                }
                .rotationEffect(self.angle(at: offset))
                .rotationEffect(-self.angle(at: self.texts.count - 1) / 2)
                .frame(width: 300, height: 300, alignment: .center)
                .rotationEffect(.degrees(rotation)) // Apply rotation effect to the whole ZStack
                .onAppear {
                    withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: false)) {
                        rotation = 360 // Rotate the text continuously
                    }
                }
            }
        }

    }
    
    private func angle(at index: Int) -> Angle {
        guard let labelSize = textSizes[index] else { return .radians(0) }
        let percentOfLabelInCircle = labelSize / radius.perimeter
        let labelAngle = 2 * Double.pi * percentOfLabelInCircle
        
        let totalSizeOfPreChars = textSizes.filter { $0.key < index }.map { $0.value }.reduce(0, +)
        let percenOfPreCharInCircle = totalSizeOfPreChars / radius.perimeter
        let angleForPreChars = 2 * Double.pi * percenOfPreCharInCircle
        
        return .radians(angleForPreChars + labelAngle)
    }
}

extension Double {
    var perimeter: Double {
        return self * 2 * .pi
    }
}

// Get size for label helper
struct WidthPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat(0)
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct Sizeable: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: WidthPreferenceKey.self, value: geometry.size.width)
        }
    }
}

// Preview
#Preview {
    CircularTextView(radius: 140, text: "Apparat is your companion for a smoother student journey in Napoli")
}
