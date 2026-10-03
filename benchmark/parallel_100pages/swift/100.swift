import SwiftUI


extension Color {
    static let primaryBlack = Color(red: 18/255, green: 18/255, blue: 18/255)
    static let backgroundWhite = Color(red: 255/255, green: 255/255, blue: 255/255)
    static let surfaceGray = Color(red: 245/255, green: 245/255, blue: 245/255)
    static let textSecondary = Color(red: 117/255, green: 117/255, blue: 117/255)
    static let accentGreen = Color(red: 76/255, green: 175/255, blue: 80/255)
    static let gold = Color(red: 255/255, green: 215/255, blue: 0/255)
}


struct HabitTrackerScreen: View {
    var body: some View {
                ZStack {
            Color.backgroundWhite.ignoresSafeArea() 

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) { 
                    Spacer().frame(height: 24) 

                                        HStack(alignment: .center) { 
                        VStack(alignment: .leading, spacing: 0) { 
                            Text("THURSDAY")
                                .font(.system(size: 12, weight: .bold))
                                .kerning(1) 
                                .foregroundColor(.textSecondary)
                            Text("Dec 04")
                                .font(.system(size: 24, weight: .black))
                                .foregroundColor(.primaryBlack)
                        }
                        Spacer() 
                        Button(action: {
                                                    }) {
                            Image(systemName: "gearshape.fill") 
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24) 
                                .foregroundColor(.primaryBlack)
                        }
                        .frame(width: 40, height: 40) 
                        .background(
                            Circle()
                                .stroke(Color.surfaceGray, lineWidth: 1) 
                        )
                    }
                    .frame(maxWidth: .infinity) 

                    Spacer().frame(height: 32) 

                                        StatsCard()

                    Spacer().frame(height: 32) 

                    Text("TODAY'S GOALS")
                        .font(.system(size: 12, weight: .bold))
                        .kerning(1.5) 
                        .foregroundColor(.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading) 

                    Spacer().frame(height: 16) 

                                        HabitItem(
                        iconName: "face.smiling.fill", 
                        title: "Morning Meditation",
                        subtitle: "15 minutes mindfulness",
                        isCompleted: true
                    )

                    HabitItem(
                        iconName: "play.fill", 
                        title: "Gym Session",
                        subtitle: "Upper body workout",
                        isCompleted: false
                    )

                    HabitItem(
                        iconName: "star.fill", 
                        title: "Learn Spanish",
                        subtitle: "Daily lesson completed",
                        isCompleted: false
                    )

                    HabitItem(
                        iconName: "heart.fill", 
                        title: "Drink Water",
                        subtitle: "2L target",
                        isCompleted: false
                    )

                    Spacer().frame(height: 24) 

                                        VStack(alignment: .leading, spacing: 0) { 
                        Image(systemName: "checkmark.circle.fill") 
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20) 
                            .foregroundColor(.textSecondary)
                        Spacer().frame(height: 12) 
                        Text("Small steps every day add up to big results over time.")
                            .font(.system(size: 14))
                            .italic() 
                            .foregroundColor(.primaryBlack)
                            .lineSpacing(6) 
                    }
                    .padding(20) 
                    .frame(maxWidth: .infinity) 
                    .background(Color.surfaceGray) 
                    .cornerRadius(16) 

                    Spacer().frame(height: 48) 
                }
                .padding(24) 
            }
        }
        .statusBarHidden(true) 
    }
}


struct StatsCard: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) { 
            VStack(alignment: .leading, spacing: 0) { 
                Text("Overall Progress")
                    .foregroundColor(Color.white.opacity(0.7))
                    .font(.system(size: 14))
                Spacer().frame(height: 8) 
                Text("85%")
                    .foregroundColor(.white)
                    .font(.system(size: 48, weight: .bold))
                Spacer().frame(height: 4) 
                HStack(alignment: .center, spacing: 0) { 
                    Image(systemName: "star.fill") 
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16) 
                        .foregroundColor(.gold)
                    Spacer().frame(width: 4) 
                    Text("12 Day Streak!")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .medium))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) 
        }
        .frame(maxWidth: .infinity) 
        .frame(height: 140) 
        .background(Color.primaryBlack) 
        .cornerRadius(24) 
        .padding(24) 
    }
}

struct HabitItem: View {
    let iconName: String
    let title: String
    let subtitle: String
    @State var isCompleted: Bool 

    var body: some View {
        HStack(alignment: .center, spacing: 0) { 
                        ZStack { 
                Circle()
                    .fill(Color.surfaceGray) 
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24) 
                    .foregroundColor(.primaryBlack)
            }
            .frame(width: 48, height: 48) 

            Spacer().frame(width: 16) 

                        VStack(alignment: .leading, spacing: 0) { 
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(isCompleted ? .textSecondary : .primaryBlack)
                    .strikethrough(isCompleted, color: .textSecondary) 
                Spacer().frame(height: 2) 
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading) 

            Spacer().frame(width: 8) 

                        ZStack { 
                Circle()
                    .fill(isCompleted ? Color.accentGreen : Color.clear) 
                Circle()
                    .stroke(isCompleted ? Color.accentGreen : Color.surfaceGray, lineWidth: 2) 

                if isCompleted {
                    Image(systemName: "checkmark") 
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18) 
                        .foregroundColor(.white)
                }
            }
            .frame(width: 32, height: 32) 
        }
        .padding(16) 
        .frame(maxWidth: .infinity) 
        .background(Color.white) 
        .cornerRadius(16) 
        .overlay( 
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.surfaceGray, lineWidth: 1)
        )
        .padding(.vertical, 8) 
        .onTapGesture { 
            isCompleted.toggle()
        }
    }
}


@main
struct HabitTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            HabitTrackerScreen()
                .preferredColorScheme(.light) 
        }
    }
}


struct HabitTrackerScreen_Previews: PreviewProvider {
    static var previews: some View {
        HabitTrackerScreen()
    }
}