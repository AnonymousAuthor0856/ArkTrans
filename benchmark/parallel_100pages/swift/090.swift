import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}

@main
struct LumenApp: App {
    var body: some Scene {
        WindowGroup {
            LumenAppScreen()
                                                                .ignoresSafeArea()
                .statusBarHidden(true)
        }
    }
}

struct LumenAppScreen: View {
        @State private var selectedIso: String = "400"
    @State private var apertureValue: Double = 2.8 
    @State private var selectedSpeedIndex: Int = 4
    
    let shutterSpeeds = ["1/1000", "1/500", "1/250", "1/125", "1/60", "1/30", "1/15", "1/8"]
    
        private let screenPadding: CGFloat = 24
    private let verticalSpacingLarge: CGFloat = 32
    private let verticalSpacingMedium: CGFloat = 16
    private let horizontalSpacingSmall: CGFloat = 12

    var body: some View {
                Color.white
            .ignoresSafeArea() 
            .overlay(
                VStack(spacing: 0) { 
                                        HeaderSection()
                        .padding(.bottom, verticalSpacingMedium) 

                                        CurrentSettingsDisplay(
                        iso: selectedIso,
                        aperture: String(format: "%.1f", apertureValue), 
                        shutter: shutterSpeeds[selectedSpeedIndex]
                    )

                                        Spacer()
                    
                                        VStack(spacing: verticalSpacingLarge) { 
                                                IsoSelector(
                            currentIso: selectedIso,
                            onIsoSelected: { iso in selectedIso = iso }
                        )

                                                ApertureControl(
                            value: $apertureValue 
                        )
                        
                                                ShutterSpeedControl(
                            speeds: shutterSpeeds,
                            selectedIndex: selectedSpeedIndex,
                            onSelect: { index in selectedSpeedIndex = index }
                        )
                    }
                    
                                        Spacer()

                                        LogShotButton()
                }
                .padding(screenPadding) 
            )
    }
}

struct HeaderSection: View {
    private let bottomPadding: CGFloat = 16
    private let letterSpacingHeader: CGFloat = 2 
    private let iconButtonSize: CGFloat = 44 

    var body: some View {
        HStack { 
            VStack(alignment: .leading, spacing: 0) { 
                Text("LUMEN LOG")
                    .font(.system(size: 14, weight: .bold))
                    .kerning(letterSpacingHeader) 
                    .foregroundColor(.gray)
                Text("Roll #034")
                    .font(.system(size: 24, weight: .heavy)) 
                    .foregroundColor(.black)
            }
            
            Spacer() 
            
            HStack(spacing: 0) { 
                Button(action: {  }) {
                    Image(systemName: "line.horizontal.3") 
                        .font(.system(size: 22)) 
                        .foregroundColor(.black)
                }
                .frame(width: iconButtonSize, height: iconButtonSize) 
                
                Button(action: {  }) {
                    Image(systemName: "gear") 
                        .font(.system(size: 22)) 
                        .foregroundColor(.black)
                }
                .frame(width: iconButtonSize, height: iconButtonSize) 
            }
        }
    }
}

struct CurrentSettingsDisplay: View {
    let iso: String
    let aperture: String
    let shutter: String
    
    private let cardHeight: CGFloat = 160 
    private let cornerRadius: CGFloat = 16 
    private let horizontalPadding: CGFloat = 24 
    private let dividerHeight: CGFloat = 80 
    private let detailSpacing: CGFloat = 16 

    var body: some View {
                RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color(hex: 0xFFF8F8F8)) 
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(hex: 0xFFEEEEEE), lineWidth: 1) 
            )
            .frame(height: cardHeight) 
            .frame(maxWidth: .infinity) 
            .overlay( 
                HStack(spacing: 0) { 
                                        VStack(alignment: .leading, spacing: 0) { 
                        Text("f/\(aperture)")
                            .font(.system(size: 56, weight: .light))
                            .foregroundColor(.black)
                            .kerning(-2) 
                        Text("APERTURE")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, horizontalPadding)
                    .frame(maxWidth: .infinity, alignment: .leading) 
                    .layoutPriority(1.5) 
                    
                                        Rectangle()
                        .fill(Color(hex: 0xFFE0E0E0)) 
                        .frame(width: 1, height: dividerHeight) 
                    
                                        VStack(alignment: .leading, spacing: 0) { 
                        SettingItemSmall(label: "ISO", value: iso)
                        Spacer() 
                            .frame(height: detailSpacing)
                        SettingItemSmall(label: "SHUTTER", value: shutter)
                    }
                    .padding(.leading, horizontalPadding)
                    .frame(maxWidth: .infinity, alignment: .leading) 
                    .layoutPriority(1) 
                }
            )
    }
}

struct SettingItemSmall: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { 
            Text(value)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
            Text(label)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.gray)
        }
    }
}

struct IsoSelector: View {
    let isoValues = ["100", "200", "400", "800", "1600", "3200"]
    let currentIso: String
    let onIsoSelected: (String) -> Void
    
    private let bottomPadding: CGFloat = 12 
    private let itemWidth: CGFloat = 60 
    private let itemHeight: CGFloat = 36 
    private let cornerRadius: CGFloat = 50 
    private let horizontalSpacing: CGFloat = 12 

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { 
            Text("Film Stock ISO")
                .font(.system(size: 14, weight: .medium))
                .padding(.bottom, bottomPadding)
            
            ScrollView(.horizontal, showsIndicators: false) { 
                LazyHStack(spacing: horizontalSpacing) { 
                    ForEach(isoValues, id: \.self) { iso in
                        let isSelected = currentIso == iso
                        
                        Text(iso)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(isSelected ? .white : .black)
                            .frame(width: itemWidth, height: itemHeight) 
                            .background(isSelected ? Color.black : Color.clear) 
                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius)) 
                                                        .overlay(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .stroke(isSelected ? Color.black : Color(hex: 0xFFE0E0E0), lineWidth: 1) 
                            )
                            .contentShape(RoundedRectangle(cornerRadius: cornerRadius)) 
                            .onTapGesture { 
                                onIsoSelected(iso)
                            }
                    }
                }
            }
        }
    }
}

struct ApertureControl: View {
    @Binding var value: Double 
    
    private let sliderTopSpacing: CGFloat = 8 
    private let iconSize: CGFloat = 16 
    private let sliderStep: Double = (16.0 - 1.4) / 20.0 
    private let trackHeight: CGFloat = 2 
    private let thumbDiameter: CGFloat = 28 

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { 
            HStack { 
                Text("Aperture Control")
                    .font(.system(size: 14, weight: .medium))
                Spacer()
                Image(systemName: "gear") 
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(.gray)
            }
            
            Spacer() 
                .frame(height: sliderTopSpacing)
            
                        GeometryReader { geometry in
                let totalRange = 16.0 - 1.4 
                let normalizedValue = CGFloat((value - 1.4) / totalRange) 
                
                ZStack(alignment: .leading) {
                                        Capsule()
                        .fill(Color(hex: 0xFFE0E0E0))
                        .frame(height: trackHeight)
                    
                                        Capsule()
                        .fill(Color.black)
                        .frame(width: geometry.size.width * normalizedValue, height: trackHeight)
                    
                                        Circle()
                        .fill(Color.black)
                        .frame(width: thumbDiameter, height: thumbDiameter)
                        .offset(x: geometry.size.width * normalizedValue - thumbDiameter / 2)
                        .shadow(radius: 2) 
                }
                .frame(height: geometry.size.height, alignment: .center) 
                
                                Slider(value: $value, in: 1.4...16.0, step: sliderStep) {
                    Text("") 
                } minimumValueLabel: {
                    Text("") 
                } maximumValueLabel: {
                    Text("") 
                }
                .opacity(0.001) 
                .accentColor(.clear) 
            }
            .frame(height: thumbDiameter) 
            
            HStack { 
                Text("f/1.4")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Spacer()
                Text("f/16")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ShutterSpeedControl: View {
    let speeds: [String]
    let selectedIndex: Int
    let onSelect: (Int) -> Void
    
    private let bottomPadding: CGFloat = 12 
    private let horizontalSpacing: CGFloat = 12 

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { 
            Text("Shutter Speed")
                .font(.system(size: 14, weight: .medium))
                .padding(.bottom, bottomPadding)
            
            HStack(spacing: horizontalSpacing) { 
                                let prev = speeds.indices.contains(selectedIndex - 1) ? speeds[selectedIndex - 1] : "-"
                let curr = speeds[selectedIndex]
                let next = speeds.indices.contains(selectedIndex + 1) ? speeds[selectedIndex + 1] : "-"
                
                SpeedOption(text: prev, isSelected: false) {
                    if selectedIndex > 0 { onSelect(selectedIndex - 1) }
                }
                
                SpeedOption(text: curr, isSelected: true, onClick: {}) 
                
                SpeedOption(text: next, isSelected: false) {
                    if selectedIndex < speeds.count - 1 { onSelect(selectedIndex + 1) }
                }
            }
            .frame(maxWidth: .infinity) 
        }
    }
}

struct SpeedOption: View {
    let text: String
    let isSelected: Bool
    let onClick: () -> Void
    
    private let itemWidth: CGFloat = 100 
    private let itemHeight: CGFloat = 50 
    private let cornerRadius: CGFloat = 12 

    var body: some View {
        Text(text)
            .font(.system(size: isSelected ? 22 : 16, weight: isSelected ? .bold : .regular)) 
            .foregroundColor(isSelected ? .black : Color(hex: 0xFFE0E0E0)) 
            .frame(width: itemWidth, height: itemHeight) 
            .background(isSelected ? Color(hex: 0xFFF0F0F0) : Color.clear) 
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius)) 
            .contentShape(RoundedRectangle(cornerRadius: cornerRadius)) 
            .onTapGesture { 
                if !isSelected && text != "-" {
                    onClick()
                }
            }
    }
}

struct LogShotButton: View {
    private let buttonHeight: CGFloat = 56 
    private let cornerRadius: CGFloat = 12 
    private let iconBoxSize: CGFloat = 24 
    private let iconSize: CGFloat = 16 
    private let iconTextSpacing: CGFloat = 12 
    private let letterSpacingButton: CGFloat = 1 

    var body: some View {
        Button(action: {  }) {
            HStack(alignment: .center, spacing: iconTextSpacing) { 
                ZStack { 
                    Circle()
                        .fill(Color.white) 
                        .frame(width: iconBoxSize, height: iconBoxSize) 
                    Image(systemName: "plus") 
                        .resizable()
                        .frame(width: iconSize, height: iconSize) 
                        .foregroundColor(.black)
                }
                                Text("LOG EXPOSURE")
                    .font(.system(size: 16, weight: .bold))
                    .kerning(letterSpacingButton) 
                    .foregroundColor(.white) 
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) 
        }
        .frame(height: buttonHeight) 
        .frame(maxWidth: .infinity) 
        .background(Color.black) 
        .cornerRadius(cornerRadius) 
    }
}

struct LumenAppScreen_Previews: PreviewProvider {
    static var previews: some View {
        LumenAppScreen()
    }
}