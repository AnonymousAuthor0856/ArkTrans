

import SwiftUI


struct FeedbackView_Preview: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                ScrollView {
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            headerView
                                .padding()
                            detailsView
                                .padding(.horizontal)
                            Spacer()
                            Spacer()
                        }

                        Spacer()
                    }
                    .frame(
                        maxWidth: geometry.size.width,
                        minHeight: geometry.size.height
                    )
                }

                VStack {
                    HStack {
                        Spacer()

                        DismissViewButton()
                            .padding([.top, .horizontal])
                    }

                    Spacer()

                    VStack {
                        iMessageButtonView
                        buyMeACoffeeButtonView
                    }
                    .padding()
                }
            }
        }
        .presentationDetents([.fraction(0.7)])
        .presentationDragIndicator(.visible)
        .presentationBackground(.regularMaterial)
        .presentationCornerRadius(Constants.roundedRectCornerRadius)
    }
}


extension FeedbackView_Preview {
    var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hello! 👋🏼")
                    .font(.largeTitle)
                    .bold()

                Text("I'm Uriel Ortega.")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }

    var detailsView: some View {
        VStack(alignment: .leading) {
            Text("Feel free to reach out and share your thoughts with me!")
                .bold()
                .multilineTextAlignment(.leading)

            Text("Whether it's a bug report, a suggestion, or just a friendly chat—I'm here for you.")
                .bold()
                .multilineTextAlignment(.leading)
                .padding(.bottom, 10)

            Text("If you enjoy using the app and would like to support my work, you can also buy me a coffee. Every sip fuels more improvements for this and future apps. Thank you! ☕️✨")
                .font(.caption)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 60)
        }
        .accessibilityElement()
        .accessibilityLabel("Feel free to provide feedback or support my work by using the buttons below.")
    }

    var iMessageButtonView: some View {
        Button {
            if let url = URL(string: "sms:urielortega2509@gmail.com") {
                UIApplication.shared.open(url)
            }
        } label: {
            BorderedButtonLabel(
                color: .green,
                labelText: "iMessage Me",
                systemImageString: "message.fill"
            )
        }
    }

    var buyMeACoffeeButtonView: some View {
        Link(destination: URL(string: "https://www.buymeacoffee.com/urielortega")!) {
            BorderedButtonLabel(
                color: .black.opacity(0.8),
                labelText: "Buy Me A Coffee",
                systemImageString: "cup.and.saucer.fill"
            )
        }
    }
}

#Preview {
    FeedbackView_Preview()

}
