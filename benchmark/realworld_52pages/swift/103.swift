

import SwiftUI


struct AboutCleanPadView_Preview: View {
    @State private var greeting = "Hello!"
    @State private var gradientColors: [Color] = [.purple, .blue, .green, .yellow]

    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                AnimatedGradientView(colors: gradientColors, speed: 0.4)
                    .ignoresSafeArea()

                ScrollView {
                    VStack {
                        Spacer()
                        headerView
                        detailsView
                        Spacer()
                        Spacer()
                    }
                    .frame(
                        maxWidth: geometry.size.width,
                        minHeight: geometry.size.height
                    )
                    .padding(.horizontal)
                }

                VStack {
                    HStack {
                        Spacer()

                        DismissViewButton()
                            .padding([.top, .horizontal])
                    }
                    .frame(maxWidth: geometry.size.width)

                    Spacer()
                }
            }
            .frame(maxWidth: geometry.size.width)
            .multilineTextAlignment(.center)
            .onAppear(perform: updateBackgroundAndGreeting)
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(Constants.roundedRectCornerRadius)
        }
    }
}

extension AboutCleanPadView_Preview {
    
    var headerView: some View {
        Group {
            AppIconView()
                .padding()
                .padding(.top, 50)

            Text(greeting)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(Material.thick)
                .shadow(radius: Constants.textShadowRadius)
        }
    }

    
    var detailsView: some View {
        VStack {
            VStack {
                Text("CleanPad is the home for any of your thoughts.")
                    .font(.title)
                    .foregroundStyle(Material.regular)
                    .padding(.bottom)

                Group {
                    Text("It's your space to capture it all. Feel free to express yourself.")
                    Text("Your notes are yours alone, securely stored on your device and optionally protected with authentication.")
                }
                .foregroundStyle(Material.thick)
            }
            .padding(.bottom)

            Text("Thank you for choosing CleanPad as your trusted companion. Here's to a clutter-free, inspired note-taking journey!")
                .foregroundStyle(Material.thick)
                .padding(.bottom)
        }
        .fixedSize(horizontal: false, vertical: true)
        .fontWeight(.semibold)
        .shadow(radius: Constants.textShadowRadius)
        .padding(.horizontal)
    }

    
    private func updateBackgroundAndGreeting() {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 6..<12:
            greeting = "Good morning!"
            gradientColors = [.orange, .yellow, .pink, .red]
        case 12..<17:
            greeting = "Good afternoon!"
            gradientColors = [.yellow, .green, .mint, .teal]
        case 17..<20:
            greeting = "Good evening!"
            gradientColors = [.orange, .pink, .purple, .indigo]
        default:
            greeting = "Good night!"
            gradientColors = [.indigo, .purple, .blue, .teal]
        }
    }
}

#Preview {
    AboutCleanPadView_Preview()

}
