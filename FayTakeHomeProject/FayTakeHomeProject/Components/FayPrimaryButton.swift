import SwiftUI

struct FayPrimaryButton: View {
    
    let title: String
    let icon: String?
    let isFullWidth: Bool
    let onTap: () -> Void
    
    init(
        title: String,
        icon: String? = nil,
        isFullWidth: Bool = false,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isFullWidth = isFullWidth
        self.onTap = onTap
    }
    
    var body: some View {
        Button(action: onTap) {
            Label(title, image: icon ?? "")
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.vertical, 16)
                .padding(.horizontal, 32)
                .frame(maxWidth: isFullWidth ? .infinity : nil)
                .background(Color.accent, in: .rect(cornerRadius: 8))
        }
    }
}

#Preview {
    FayPrimaryButton(title: "Join appointment", icon: "videocamera", isFullWidth: true, onTap: {})
        .padding()
}
