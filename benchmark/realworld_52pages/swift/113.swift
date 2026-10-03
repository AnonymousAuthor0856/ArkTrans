
import SwiftUI


struct WhatsNewView_Preview: View {
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
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(Constants.roundedRectCornerRadius)
        }
    }
}

extension WhatsNewView_Preview {
    var headerView: some View {
        Text("What's New in CleanPad")
            .foregroundStyle(.black)
            .font(.largeTitle)
            .bold()
            .padding(.vertical)
    }

    var detailsView: some View {
        VStack(alignment: .leading) {
            NewFeatureView(
                imageSystemName: "line.3.horizontal.decrease.circle.fill",
                featureTitle: "Every thought finds its place",
                featureDescription: "Easily create and assign categories to organize your notes better"
            )

            NewFeatureView(
                imageSystemName: "lock.fill",
                featureTitle: "Your private notes, still personal",
                featureDescription: "Personal Notes are now called Private Notes to make things clearer"
            )

            NewFeatureView(
                imageSystemName: "sparkles",
                featureTitle: "A smoother, comfier experience",
                featureDescription: "Say hello to a refreshed interface that makes CleanPad smoother, more intuitive, and easier to navigate"
            )
        }
        .padding(.vertical)
        .presentationCornerRadius(Constants.roundedRectCornerRadius)
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

    fileprivate struct NewFeatureView: View {
        let imageSystemName: String
        let featureTitle: String
        let featureDescription: String

        @State private var animate = false

        var body: some View {
            HStack(alignment: .center) {
                Image(systemName: imageSystemName)
                    .foregroundStyle(.accent.gradient)
                    .font(.system(size: 40))
                    .symbolEffect(
                        .bounce,
                        options: .speed(0.8),
                        value: animate
                    )
                    .frame(width: 40)
                    .padding(.trailing)

                VStack(alignment: .leading) {
                    Text(featureTitle)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.black)
                        .font(.title3)
                        .bold()

                    Text(featureDescription)
                        .foregroundStyle(.black.opacity(0.7))
                }
            }
            .padding(.vertical)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    animate.toggle()
                }
            }
        }
    }
}

#Preview {
    WhatsNewView_Preview()

}
