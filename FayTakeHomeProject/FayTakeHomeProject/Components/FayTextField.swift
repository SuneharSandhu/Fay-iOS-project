import SwiftUI

struct FayTextField: View {
    
    let icon: String
    let iconTint: Color = .gray
    let placeholder: String
    let isPassword: Bool
    
    @Binding var text: String
    @State private var isShowingPassword: Bool = false
    
    private let iconSize: CGFloat = 30
    
    init(
        icon: String,
        placeholder: String,
        isPassword: Bool = false,
        text: Binding<String>,
    ) {
        self.icon = icon
        self.placeholder = placeholder
        self.isPassword = isPassword
        self._text = text
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(iconTint)
                .frame(width: iconSize)
            
            VStack(alignment: .leading, spacing: 8) {
                if isPassword {
                    Group {
                        if isShowingPassword {
                            TextField(placeholder, text: $text)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                        } else {
                            SecureField(placeholder, text: $text)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                        }
                    }
                } else {
                    TextField(placeholder, text: $text)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                }
                
                Divider()
            }
            .overlay(alignment: .trailing) {
                if isPassword {
                    Button("", systemImage: isShowingPassword ? "eye.slash" : "eye") {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isShowingPassword.toggle()
                        }
                    }
                    .foregroundStyle(.gray)
                    .padding(10)
                    .contentShape(.rect)
                }
            }
        }
    }
}
