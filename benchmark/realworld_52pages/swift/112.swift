

import SwiftUI

struct WelcomeView_Preview: View {
    @Environment(\.dismiss) var dismiss
    @State var gradientColors: [Color] = [.white, .cleanPadIconBackground, .white]

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                AnimatedGradientView(colors: gradientColors, speed: 0.4)
                    .opacity(0.9)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .center) {
                        Spacer()
                        headerView
                        detailsView
                        Spacer()
                    }
                    .frame(
                        maxWidth: geometry.size.width,
                        minHeight: geometry.size.height
                    )
                    .padding(.horizontal)
                }

                VStack {
                    Spacer()
                    dismissButtonView
                }
            }
            .frame(maxWidth: geometry.size.width)
            .multilineTextAlignment(.center)
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(Constants.roundedRectCornerRadius)
        }
    }
}

extension WelcomeView_Preview {
    var headerView: some View {
        Group {
            AppIconView()
                .padding(.bottom, 40)

            Group {
                Text("Welcome to CleanPad")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.black)

                Text("The home for your thoughts")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black.opacity(0.7))
                    .padding(.bottom, 20)
            }
        }
    }
    var detailsView: some View {
        Group {
            Text("This app is your canvas for capturing your thoughts, feelings, ideas and all you can imagine.")
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)

            Text("Feel free to write anything you like. Your data is securely stored on your device and can be protected with authentication if you choose.")
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)

            Text("Enjoy it! 🫶🏼")
        }
        .fontWeight(.semibold)
        .foregroundStyle(.black)
        .padding(.horizontal)
    }
    var dismissButtonView: some View {
        Button {
            HapticManager.instance.impact(style: .soft)
            dismiss()
        } label: {
            MaterialButtonLabel(labelText: "Great!")
        }
        .padding()
    }
}

#Preview {
    WelcomeView_Preview()

}
