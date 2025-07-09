import SwiftUI

struct FayTertiaryButton: View {
    
    let title: String
    let ontap: () -> Void
    
    var body: some View {
        Button(title) {
            ontap()
        }
        .fontWeight(.semibold)
        .foregroundStyle(.accent)
    }
}

#Preview {
    FayTertiaryButton(title: "Fay Teritary button", ontap: {})
}
