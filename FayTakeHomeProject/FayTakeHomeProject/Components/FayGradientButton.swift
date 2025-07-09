import SwiftUI

struct FayGradientButton: View {
    
    let title: String
    let isFullWidth: Bool
    let onTap: () -> Void
    
    init(
        title: String,
        isFullWidth: Bool = false,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.isFullWidth = isFullWidth
        self.onTap = onTap
    }
    
    var body: some View {
        Button(action: onTap) {
            Text(title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 35)
                .frame(maxWidth: isFullWidth ? .infinity : nil)
                .background(
                    .linearGradient(colors: [.accent.opacity(0.6), .accent.opacity(0.8), .accent], startPoint: .top, endPoint: .bottom), in: .rect(cornerRadius: 8)
                )
                
        }
    }
}

#Preview {
    FayGradientButton(title: "Login", isFullWidth: true, onTap: {})
        .padding()
}
