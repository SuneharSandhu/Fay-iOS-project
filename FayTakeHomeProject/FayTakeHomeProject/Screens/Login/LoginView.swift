import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var authManager: AuthManager
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showOverlay = false
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case password
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.loginBackground
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Log in")
                        .font(.largeTitle).bold()
                        .foregroundStyle(.accent)
                    
                    VStack(spacing: 30) {
                        FayTextField(icon: "at", placeholder: "Enter username", text: $username)
                            .onSubmit {
                                focusedField = .password
                            }
                        
                        FayTextField(icon: "lock", placeholder: "Enter password", isPassword: true, text: $password)
                            .focused($focusedField, equals: .password)
                            .onSubmit {
                                authManager.login(username: username, password: password)
                            }
                        
                        HStack {
                            if let errorMessage = authManager.errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                            }
                            Spacer()
                            Button("Forgot password?") {
                                // Noop
                            }
                            .font(.callout)
                            .fontWeight(.heavy)
                            .tint(.accent)
                        }
                        
                        FayGradientButton(title: "Log in", isFullWidth: true) {
                            authManager.login(username: username, password: password)
                        }
                        .disableWithOpacity(username.isEmpty || password.isEmpty)
                        
                        FayTertiaryButton(title: "New to Fay? Start by finding a dietitian") {
                            // Noop
                        }
                        .font(.callout)
                    }
                    .padding(.top, 20)
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 25)
            }
            .overlay(alignment: .bottom) {
                Image(systemName: "sun.horizon.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.accent)
                    .frame(maxWidth: .infinity)
                    .opacity(0.3)
                    .offset(
                        x: showOverlay ? 50 : UIScreen.main.bounds.width,
                        y: showOverlay ? 130 : UIScreen.main.bounds.height
                    )
                    .rotationEffect(.degrees(-30))
                    .animation(.smooth(duration: 2.0, extraBounce: 0.2), value: showOverlay)
                    .onAppear {
                        showOverlay = true
                    }
                
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LoginView()
}
