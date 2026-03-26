import SwiftUI

// MARK: - UI Constants & Colors

// Define custom colors to match the Android version
extension Color {
    static let primaryBlack = Color(red: 18/255, green: 18/255, blue: 18/255)
    static let backgroundWhite = Color(red: 255/255, green: 255/255, blue: 255/255)
    static let surfaceGray = Color(red: 245/255, green: 245/255, blue: 245/255)
    static let textSecondary = Color(red: 117/255, green: 117/255, blue: 117/255)
    static let accentGreen = Color(red: 76/255, green: 175/255, blue: 80/255)
    static let gold = Color(red: 255/255, green: 215/255, blue: 0/255)
}

// MARK: - Main Screen

struct HabitTrackerScreen: View {
    var body: some View {
        // Equivalent to Android's Surface with fillMaxSize and backgroundWhite
        ZStack {
            Color.backgroundWhite.ignoresSafeArea() // Set background color and ignore safe area for full screen

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) { // Equivalent to Column with horizontalAlignment = .CenterHorizontally
                    Spacer().frame(height: 24) // Spacer(modifier = Modifier.height(24.dp))

                    // -- Top Bar --
                    HStack(alignment: .center) { // Equivalent to Row
                        VStack(alignment: .leading, spacing: 0) { // Equivalent to Column
                            Text("THURSDAY")
                                .font(.system(size: 12, weight: .bold))
                                .kerning(1) // letterSpacing = 1.sp
                                .foregroundColor(.textSecondary)
                            Text("Dec 04")
                                .font(.system(size: 24, weight: .black))
                                .foregroundColor(.primaryBlack)
                        }
                        Spacer() // Equivalent to Arrangement.SpaceBetween
                        Button(action: {
                            // No op
                        }) {
                            Image(systemName: "gearshape.fill") // Icons.Default.Settings
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24) // Icon size 24.dp
                                .foregroundColor(.primaryBlack)
                        }
                        .frame(width: 40, height: 40) // IconButton size 40.dp
                        .background(
                            Circle()
                                .stroke(Color.surfaceGray, lineWidth: 1) // border(1.dp, SurfaceGray, CircleShape)
                        )
                    }
                    .frame(maxWidth: .infinity) // fillMaxWidth()

                    Spacer().frame(height: 32) // Spacer(modifier = Modifier.height(32.dp))

                    // -- Hero Stats Card --
                    StatsCard()

                    Spacer().frame(height: 32) // Spacer(modifier = Modifier.height(32.dp))

                    Text("TODAY'S GOALS")
                        .font(.system(size: 12, weight: .bold))
                        .kerning(1.5) // letterSpacing = 1.5.sp
                        .foregroundColor(.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading) // fillMaxWidth()

                    Spacer().frame(height: 16) // Spacer(modifier = Modifier.height(16.dp))

                    // -- Habit List --
                    HabitItem(
                        iconName: "face.smiling.fill", // Icons.Default.Face
                        title: "Morning Meditation",
                        subtitle: "15 minutes mindfulness",
                        isCompleted: true
                    )

                    HabitItem(
                        iconName: "play.fill", // Icons.Default.PlayArrow
                        title: "Gym Session",
                        subtitle: "Upper body workout",
                        isCompleted: false
                    )

                    HabitItem(
                        iconName: "star.fill", // Icons.Default.Star
                        title: "Learn Spanish",
                        subtitle: "Daily lesson completed",
                        isCompleted: false
                    )

                    HabitItem(
                        iconName: "heart.fill", // Icons.Default.Favorite
                        title: "Drink Water",
                        subtitle: "2L target",
                        isCompleted: false
                    )

                    Spacer().frame(height: 24) // Spacer(modifier = Modifier.height(24.dp))

                    // -- Inspiration Section --
                    VStack(alignment: .leading, spacing: 0) { // Equivalent to Box with Column inside
                        Image(systemName: "checkmark.circle.fill") // Icons.Default.CheckCircle
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20) // size(20.dp)
                            .foregroundColor(.textSecondary)
                        Spacer().frame(height: 12) // Spacer(modifier = Modifier.height(12.dp))
                        Text("Small steps every day add up to big results over time.")
                            .font(.system(size: 14))
                            .italic() // fontStyle = FontStyle.Italic
                            .foregroundColor(.primaryBlack)
                            .lineSpacing(6) // lineHeight = 20.sp for 14.sp text (20 - 14 = 6)
                    }
                    .padding(20) // padding(20.dp)
                    .frame(maxWidth: .infinity) // fillMaxWidth()
                    .background(Color.surfaceGray) // background(SurfaceGray)
                    .cornerRadius(16) // RoundedCornerShape(16.dp)

                    Spacer().frame(height: 48) // Spacer(modifier = Modifier.height(48.dp))
                }
                .padding(24) // padding(24.dp) for the whole column
            }
        }
        .statusBarHidden(true) // Hide status bar
    }
}

// MARK: - Components

struct StatsCard: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) { // Equivalent to Row with Arrangement.SpaceBetween, VerticalAlignment.CenterVertically
            VStack(alignment: .leading, spacing: 0) { // Equivalent to Column with VerticalArrangement.Center
                Text("Overall Progress")
                    .foregroundColor(Color.white.opacity(0.7))
                    .font(.system(size: 14))
                Spacer().frame(height: 8) // Spacer(modifier = Modifier.height(8.dp))
                Text("85%")
                    .foregroundColor(.white)
                    .font(.system(size: 48, weight: .bold))
                Spacer().frame(height: 4) // Spacer(modifier = Modifier.height(4.dp))
                HStack(alignment: .center, spacing: 0) { // Equivalent to Row with VerticalAlignment.CenterVertically
                    Image(systemName: "star.fill") // Icons.Default.Star
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16) // size(16.dp)
                        .foregroundColor(.gold)
                    Spacer().frame(width: 4) // Spacer(modifier = Modifier.width(4.dp))
                    Text("12 Day Streak!")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .medium))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) // fillMaxSize() for Column inside Row, effectively takes all space
        }
        .frame(maxWidth: .infinity) // fillMaxWidth()
        .frame(height: 140) // height(140.dp)
        .background(Color.primaryBlack) // background(PrimaryBlack)
        .cornerRadius(24) // RoundedCornerShape(24.dp)
        .padding(24) // padding(24.dp)
    }
}

struct HabitItem: View {
    let iconName: String
    let title: String
    let subtitle: String
    @State var isCompleted: Bool // Equivalent to remember { mutableStateOf(isCompleted) }

    var body: some View {
        HStack(alignment: .center, spacing: 0) { // Equivalent to Row with VerticalAlignment.CenterVertically
            // Icon Box
            ZStack { // Equivalent to Box
                Circle()
                    .fill(Color.surfaceGray) // background(SurfaceGray, CircleShape)
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24) // size(24.dp)
                    .foregroundColor(.primaryBlack)
            }
            .frame(width: 48, height: 48) // size(48.dp)

            Spacer().frame(width: 16) // Spacer(modifier = Modifier.width(16.dp))

            // Text Info
            VStack(alignment: .leading, spacing: 0) { // Equivalent to Column with weight(1f)
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(isCompleted ? .textSecondary : .primaryBlack)
                    .strikethrough(isCompleted, color: .textSecondary) // textDecoration = TextDecoration.LineThrough
                Spacer().frame(height: 2) // Spacer(modifier = Modifier.height(2.dp))
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Equivalent to Modifier.weight(1f)

            Spacer().frame(width: 8) // Spacer(modifier = Modifier.width(8.dp))

            // Checkbox Button
            ZStack { // Equivalent to Box
                Circle()
                    .fill(isCompleted ? Color.accentGreen : Color.clear) // background(...)
                Circle()
                    .stroke(isCompleted ? Color.accentGreen : Color.surfaceGray, lineWidth: 2) // border(...)

                if isCompleted {
                    Image(systemName: "checkmark") // Icons.Default.Check
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18) // size(18.dp)
                        .foregroundColor(.white)
                }
            }
            .frame(width: 32, height: 32) // size(32.dp)
        }
        .padding(16) // padding(16.dp)
        .frame(maxWidth: .infinity) // fillMaxWidth()
        .background(Color.white) // background(Color.White)
        .cornerRadius(16) // RoundedCornerShape(16.dp)
        .overlay( // Equivalent to border(1.dp, SurfaceGray, RoundedCornerShape(16.dp))
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.surfaceGray, lineWidth: 1)
        )
        .padding(.vertical, 8) // padding(vertical = 8.dp)
        .onTapGesture { // clickable { checked.value = !checked.value }
            isCompleted.toggle()
        }
    }
}

// MARK: - App Entry Point

@main
struct HabitTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            HabitTrackerScreen()
                .preferredColorScheme(.light) // Force light mode to match the Android example's aesthetic
        }
    }
}

// MARK: - Preview

struct HabitTrackerScreen_Previews: PreviewProvider {
    static var previews: some View {
        HabitTrackerScreen()
    }
}