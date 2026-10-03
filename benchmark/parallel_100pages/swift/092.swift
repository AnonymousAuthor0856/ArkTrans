import SwiftUI

extension Color {
    static let zenGreen = Color(red: 0x6A / 255.0, green: 0x8E / 255.0, blue: 0x6A / 255.0)
    static let zenGreenLight = Color(red: 0xE8 / 255.0, green: 0xF5 / 255.0, blue: 0xE9 / 255.0)
    static let zenBrown = Color(red: 0x8D / 255.0, green: 0x6E / 255.0, blue: 0x63 / 255.0)
    static let zenTextPrimary = Color(red: 0x2C / 255.0, green: 0x3E / 255.0, blue: 0x50 / 255.0)
    static let zenTextSecondary = Color(red: 0x7F / 255.0, green: 0x8C / 255.0, blue: 0x8D / 255.0)
    static let zenWhite = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
    static let zenAccent = Color(red: 0xD4 / 255.0, green: 0xE1 / 255.0, blue: 0x57 / 255.0)

        static let statusItemBg = Color(red: 0xF7 / 255.0, green: 0xF9 / 255.0, blue: 0xF9 / 255.0)
    static let statusItemBorder = Color(red: 0xEC / 255.0, green: 0xEF / 255.0, blue: 0xF1 / 255.0)
    static let careLogBg = Color(red: 0xFA / 255.0, green: 0xFA / 255.0, blue: 0xFA / 255.0)
    static let careLogBorder = Color(red: 0xF0 / 255.0, green: 0xF0 / 255.0, blue: 0xF0 / 255.0)
    static let careLogSubtitle = Color(red: 0x9E / 255.0, green: 0x9E / 255.0, blue: 0x9E / 255.0)
    static let navIconInactive = Color(red: 0xCF / 255.0, green: 0xD8 / 255.0, blue: 0xDC / 255.0)
    static let bottomBarDivider = Color(red: 0xF5 / 255.0, green: 0xF5 / 255.0, blue: 0xF5 / 255.0)
    static let lightGrayCircle = Color(red: 0xE0 / 255.0, green: 0xE0 / 255.0, blue: 0xE0 / 255.0)
    static let trunkColor = Color(red: 0x5D / 255.0, green: 0x40 / 255.0, blue: 0x37 / 255.0)
    static let healthRed = Color(red: 0xE5 / 255.0, green: 0x73 / 255.0, blue: 0x73 / 255.0)
    static let waterBlue = Color(red: 0x64 / 255.0, green: 0xB5 / 255.0, blue: 0xF6 / 255.0)
}

struct AppTypography {
    static let labelMedium = Font.system(size: 12, weight: .medium)
    static let displaySmallLight = Font.system(size: 36, weight: .light)
    static let titleMediumBold = Font.system(size: 16, weight: .bold)
    static let titleMediumSemiBold = Font.system(size: 16, weight: .semibold)
    static let labelSmall = Font.system(size: 11, weight: .regular)
    static let bodyMedium = Font.system(size: 14, weight: .regular)
}

@main
struct ZenBonsaiApp: App {
    var body: some Scene {
        WindowGroup {
            ZenBonsaiAppView()
                                .ignoresSafeArea(.all)
                                .statusBarHidden(true)
        }
    }
}

struct ZenBonsaiAppView: View {
    var body: some View {
                ZStack(alignment: .bottom) {
                        ScrollView {
                                VStack(alignment: .center, spacing: 0) {
                    HeaderSection()
                        .padding(.top, 24) 

                    Spacer().frame(height: 32)

                    BonsaiVisual()
                        .frame(width: 220, height: 220) 

                    Spacer().frame(height: 32)

                    StatusRow()

                    Spacer().frame(height: 32)

                    ActivityLogSection()
                        .padding(.bottom, 24) 

                }
                .padding(.horizontal, 24) 
                .background(Color.zenWhite) 
                                .padding(.bottom, 80) 
            }
            .background(Color.zenWhite) 

                        SimpleBottomNav()
                .background(Color.zenWhite) 
                .ignoresSafeArea(.keyboard) 
        }
        .background(Color.zenWhite) 
    }
}

struct HeaderSection: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("JUNIPER · #04")
                .font(AppTypography.labelMedium)
                .foregroundColor(.zenTextSecondary)
                .kerning(2) 
            Spacer().frame(height: 8) 
            Text("Zen Garden")
                .font(AppTypography.displaySmallLight)
                .foregroundColor(.zenTextPrimary)
        }
    }
}

struct StatusRow: View {
    var body: some View {
                HStack(alignment: .center) {
            Spacer() 
            StatusItem(icon: "heart.fill", label: "Health", value: "98%", tint: .healthRed)
            Spacer() 
            StatusItem(icon: "calendar", label: "Age", value: "4 Yrs", tint: .zenBrown)
            Spacer() 
            StatusItem(icon: "checkmark.circle.fill", label: "Water", value: "2 Days", tint: .waterBlue)
            Spacer() 
        }
        .frame(maxWidth: .infinity) 
    }
}

struct StatusItem: View {
    let icon: String 
    let label: String
    let value: String
    let tint: Color

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack {
                Circle()
                    .fill(Color.statusItemBg)
                    .frame(width: 50, height: 50) 
                    .overlay(
                        Circle()
                            .stroke(Color.statusItemBorder, lineWidth: 1) 
                    )
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24) 
                    .foregroundColor(tint)
            }
            Spacer().frame(height: 8) 
            Text(value)
                .font(AppTypography.titleMediumBold)
                .foregroundColor(.zenTextPrimary)
            Text(label)
                .font(AppTypography.labelSmall)
                .foregroundColor(.zenTextSecondary)
        }
    }
}

struct ActivityLogSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Care Schedule")
                    .font(AppTypography.titleMediumSemiBold)
                    .foregroundColor(.zenTextPrimary)
                Spacer() 
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20) 
                    .foregroundColor(.zenGreen)
                    .padding(4) 
                    .background(Color.zenGreenLight)
                    .clipShape(Circle()) 
                    .frame(width: 28, height: 28) 
                    .onTapGesture {
                                            }
            }
            .frame(maxWidth: .infinity) 

            Spacer().frame(height: 16) 

            CareLogItem(title: "Watering", subtitle: "Today, 8:00 AM", isDone: true)
            Spacer().frame(height: 12) 
            CareLogItem(title: "Pruning", subtitle: "Tomorrow", isDone: false)
            Spacer().frame(height: 12) 
            CareLogItem(title: "Fertilizer", subtitle: "In 5 days", isDone: false)
        }
        .frame(maxWidth: .infinity) 
    }
}

struct CareLogItem: View {
    let title: String
    let subtitle: String
    let isDone: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Circle()
                .fill(isDone ? Color.zenGreen : Color.lightGrayCircle)
                .frame(width: 12, height: 12) 
            Spacer().frame(width: 16) 
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(AppTypography.bodyMedium)
                    .foregroundColor(isDone ? .zenTextPrimary : .zenTextSecondary)
                Text(subtitle)
                    .font(AppTypography.labelSmall)
                    .foregroundColor(.careLogSubtitle)
            }
            .frame(maxWidth: .infinity, alignment: .leading) 
            if isDone {
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20) 
                    .foregroundColor(.zenGreen)
            }
        }
        .padding(16) 
        .background(Color.careLogBg)
        .cornerRadius(12) 
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.careLogBorder, lineWidth: 1) 
        )
        .frame(maxWidth: .infinity) 
    }
}

struct SimpleBottomNav: View {
    var body: some View {
        VStack(spacing: 0) {
                        Rectangle() 
                .fill(Color.bottomBarDivider)
                .frame(height: 1) 
            HStack(spacing: 0) {
                                NavIcon(icon: "house.fill", isSelected: true)
                NavIcon(icon: "info.circle.fill", isSelected: false)
                NavIcon(icon: "gearshape.fill", isSelected: false)
            }
            .frame(maxWidth: .infinity) 
            .frame(height: 80) 
            .background(Color.zenWhite) 
        }
    }
}

struct NavIcon: View {
    let icon: String 
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28) 
                .foregroundColor(isSelected ? .zenGreen : .navIconInactive)
            if isSelected {
                Spacer().frame(height: 4) 
                Circle()
                    .fill(Color.zenGreen)
                    .frame(width: 4, height: 4) 
            }
        }
        .frame(maxWidth: .infinity) 
    }
}

struct BonsaiVisual: View {
    var body: some View {
                Canvas { context, size in
            let w = size.width
            let h = size.height

                        let potWidth = w * 0.5
            let potHeight = h * 0.15
            let potTop = h * 0.85

            context.fill(Path(CGRect(x: (w - potWidth) / 2, y: potTop, width: potWidth, height: potHeight)), with: .color(.zenBrown))
                        context.fill(Path(CGRect(x: (w - potWidth) / 2 - 10, y: potTop, width: potWidth + 20, height: 15)), with: .color(Color.zenBrown.opacity(0.8)))

                        var trunkPath = Path()
            trunkPath.move(to: CGPoint(x: w * 0.5, y: potTop)) 
                        trunkPath.addQuadCurve(to: CGPoint(x: w * 0.35, y: h * 0.5), control: CGPoint(x: w * 0.45, y: h * 0.6))
                        trunkPath.addQuadCurve(to: CGPoint(x: w * 0.6, y: h * 0.3), control: CGPoint(x: w * 0.4, y: h * 0.35))

            context.stroke(trunkPath, with: .color(.trunkColor), style: StrokeStyle(lineWidth: 25, lineCap: .round))

                        var secondaryBranchPath = Path()
            secondaryBranchPath.move(to: CGPoint(x: w * 0.38, y: h * 0.55))
            secondaryBranchPath.addLine(to: CGPoint(x: w * 0.25, y: h * 0.45))
            context.stroke(secondaryBranchPath, with: .color(.trunkColor), style: StrokeStyle(lineWidth: 15, lineCap: .round))

                                    context.fill(Path(ellipseIn: CGRect(x: w * 0.6 - 45, y: h * 0.25 - 45, width: 90, height: 90)), with: .color(.zenGreen))
            context.fill(Path(ellipseIn: CGRect(x: w * 0.68 - 35, y: h * 0.28 - 35, width: 70, height: 70)), with: .color(Color.zenGreen.opacity(0.8)))
            context.fill(Path(ellipseIn: CGRect(x: w * 0.55 - 30, y: h * 0.22 - 30, width: 60, height: 60)), with: .color(Color.zenGreen.opacity(0.9)))

                        context.fill(Path(ellipseIn: CGRect(x: w * 0.35 - 35, y: h * 0.5 - 35, width: 70, height: 70)), with: .color(.zenGreen))
            context.fill(Path(ellipseIn: CGRect(x: w * 0.30 - 25, y: h * 0.45 - 25, width: 50, height: 50)), with: .color(Color.zenGreen.opacity(0.8)))

                        context.fill(Path(ellipseIn: CGRect(x: w * 0.22 - 25, y: h * 0.42 - 25, width: 50, height: 50)), with: .color(.zenGreen))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) 
    }
}

struct ZenBonsaiAppView_Previews: PreviewProvider {
    static var previews: some View {
        ZenBonsaiAppView()
    }
}