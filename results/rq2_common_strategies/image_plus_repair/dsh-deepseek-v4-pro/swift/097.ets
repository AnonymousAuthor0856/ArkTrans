// Translated from SwiftUI (097.swift) to ArkTS (HarmonyOS)

// MARK: - 1. Constants and Colors for Atomic Correspondence

// Define dimensions as constants for easy modification and atomic correspondence
class Dimensions {
  static readonly screenPadding: number = 24
  static readonly headerTopPadding: number = 16 // Extra padding for immersive status bar area
  static readonly headerSpacerHeight: number = 40
  static readonly dialSectionSpacerHeight: number = 40

  // Temperature Dial Section
  static readonly dialOuterBoxSize: number = 280 // Corresponds to Modifier.size(280.dp)
  static readonly dialCanvasSize: number = 240 // Corresponds to Canvas Modifier.size(240.dp)
  static readonly dialStrokeWidth: number = 40
  static readonly knobRadiusOuter: number = 16
  static readonly knobRadiusInner: number = 10
  static readonly tempControlsSpacerHeight: number = 32
  static readonly tempControlsHorizontalSpacing: number = 32

  // Round Control Button
  static readonly roundControlButtonSize: number = 56
  static readonly roundControlButtonBorderWidth: number = 1
  static readonly roundControlButtonIconSize: number = 28

  // Control Grid Section
  static readonly quickActionsTitleBottomPadding: number = 16
  static readonly quickActionsRowSpacing: number = 16
  static readonly quickActionCardHeight: number = 100
  static readonly quickActionCardCornerRadius: number = 20
  static readonly quickActionCardPadding: number = 16
  static readonly quickActionCardIconSize: number = 24

  // Typography specific values
  static readonly letterSpacingSmall: number = 2 // Corresponds to 2.sp
  static readonly fontSizeLabelMedium: number = 13 // Estimate for MaterialTheme.typography.labelMedium
  static readonly fontSizeBodySmall: number = 11 // Estimate for MaterialTheme.typography.bodySmall
  static readonly fontSizeDisplayMedium: number = 45 // Estimate for MaterialTheme.typography.displayMedium
  static readonly fontSizeLabelLarge: number = 15 // Estimate for MaterialTheme.typography.labelLarge
  static readonly fontSizeLabelSmall: number = 11 // Estimate for MaterialTheme.typography.labelSmall
  static readonly fontWeightSemiBold: FontWeight = FontWeight.Bold // For labelMedium in QuickActionCard (ArkUI has no SemiBold)
}

// Define custom colors using hex values for precise matching
class Colors {
  static readonly pureWhite: string = '#FFFFFFFF'
  static readonly textBlack: string = '#FF1C1C1E'
  static readonly textGray: string = '#FF8E8E93'
  static readonly accentBlue: string = '#FF007AFF'
  static readonly softGrayBg: string = '#FFF2F2F7'
  static readonly activeOrange: string = '#FFFF9500' // Not used in this specific UI, but defined for completeness
  static readonly lightGrayBg: string = '#FFF9F9F9' // Corresponds to Color(0xFFF9F9F9)
  static readonly lightBorderGray: string = '#FFEEEEEE' // Corresponds to Color(0xFFEEEEEE)
  static readonly disabledIconGray: string = '#FFD1D1D6' // Corresponds to Color(0xFFD1D1D6)
}

// MARK: - 5. @main Entry Point

@Entry
@Component
struct ClimateControllerApp {
  build() {
    Stack() {
      ClimateControllerView()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Main View (ClimateControllerApp equivalent)

@Component
struct ClimateControllerView {
  build() {
    // Constraint: Global Pure White Background
    Column() {
      HeaderSection()
        // Extra padding for immersive status bar area, as in Android's .padding(top = 16.dp)
        .padding({ top: Dimensions.headerTopPadding })

      Blank()
        .height(Dimensions.headerSpacerHeight)

      TemperatureDialSection()

      Blank()
        .height(Dimensions.dialSectionSpacerHeight)

      ControlGridSection()

      Blank() // Pushes content to top if there's extra space
        .layoutWeight(1)
    }
    .padding({ left: Dimensions.screenPadding, right: Dimensions.screenPadding }) // Horizontal padding for the whole column
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.pureWhite) // Ensure the background fills the entire screen
  }
}

// MARK: - Header Section

@Component
struct HeaderSection {
  build() {
    Row() {
      Button() {
        Text('☰') // SF Symbol for Menu
          .fontSize(Dimensions.roundControlButtonIconSize) // Match icon size
          .fontColor(Colors.textBlack)
      }
      .backgroundColor(Color.Transparent) // Remove default button styling

      Blank()
        .layoutWeight(1)

      Column() {
        Text('LIVING ROOM')
          .fontSize(Dimensions.fontSizeLabelMedium)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.textGray)
          .letterSpacing(Dimensions.letterSpacingSmall) // letterSpacing = 2.sp
        Text('Connected')
          .fontSize(Dimensions.fontSizeBodySmall)
          .fontWeight(FontWeight.Regular)
          .fontColor(Colors.accentBlue)
      }

      Blank()
        .layoutWeight(1)

      Button() {
        Text('⚙') // SF Symbol for Settings
          .fontSize(Dimensions.roundControlButtonIconSize) // Match icon size
          .fontColor(Colors.textBlack)
      }
      .backgroundColor(Color.Transparent) // Remove default button styling
    }
    .width('100%') // Equivalent to Modifier.fillMaxWidth()
  }
}

// MARK: - Temperature Dial Section

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  // Logic to clamp temperature, ensuring one decimal place
  private adjustTemp(delta: number): void {
    let newTemp: number = this.targetTemp + delta
    if (newTemp < 16.0) {
      newTemp = 16.0
    }
    if (newTemp > 30.0) {
      newTemp = 30.0
    }
    this.targetTemp = Math.round(newTemp * 10) / 10.0
  }

  build() {
    Column() {
      Stack() {
        // Background Circle
        Circle()
          .stroke(Colors.softGrayBg)
          .strokeWidth(Dimensions.dialStrokeWidth)
          .width(Dimensions.dialCanvasSize)
          .height(Dimensions.dialCanvasSize)

        // Animated Arc Indicator and Knob
        TemperatureDial({
          progress: (this.targetTemp - 16.0) / (30.0 - 16.0), // Normalize 0..1
          isActive: this.isActive
        })
          .width(Dimensions.dialCanvasSize)
          .height(Dimensions.dialCanvasSize)

        // Center Text
        Column() {
          Text(`${this.targetTemp.toFixed(1)}°`) // Format to one decimal place
            .fontSize(Dimensions.fontSizeDisplayMedium)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? Colors.textBlack : Colors.textGray)
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(Dimensions.fontSizeLabelLarge)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.textGray)
        }
      }
      .width(Dimensions.dialOuterBoxSize)
      .height(Dimensions.dialOuterBoxSize) // Corresponds to Modifier.size(280.dp)

      Blank()
        .height(Dimensions.tempControlsSpacerHeight)

      // Temp Controls
      Row({ space: Dimensions.tempControlsHorizontalSpacing }) { // Equivalent to Arrangement.spacedBy(32.dp)
        RoundControlButton({
          iconName: '▼', // SF Symbol for KeyboardArrowDown
          action: (): void => { this.adjustTemp(-0.5) },
          isEnabled: this.isActive
        })

        // Power Switch
        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .onChange((isOn: boolean): void => { this.isActive = isOn })
          .selectedColor(Colors.textBlack) // Sets the track color when "on"

        RoundControlButton({
          iconName: '▲', // SF Symbol for KeyboardArrowUp (increasing temperature)
          action: (): void => { this.adjustTemp(0.5) },
          isEnabled: this.isActive
        })
      }
    }
    .alignItems(HorizontalAlign.Center) // Equivalent to Column(horizontalAlignment = Alignment.CenterHorizontally)
  }
}

// MARK: - Custom Temperature Dial Drawing (Canvas equivalent)

@Component
struct TemperatureDial {
  @Prop @Watch('onProgressChange') progress: number = 0.0 // Normalized progress 0.0 to 1.0
  @Prop isActive: boolean = true

  // Animate progress using @State and withAnimation
  @State animatedProgress: number = 0.0

  aboutToAppear(): void {
    // Apply animation when the view appears
    this.animatedProgress = this.progress
  }

  // Animate when progress changes
  onProgressChange(propName: string): void {
    animateTo({ duration: 500, curve: Curve.EaseOut }, () => {
      this.animatedProgress = this.progress
    })
  }

  private startAngleDegrees(): number {
    return 135
  }

  private sweepAngleDegrees(): number {
    return 270 * this.animatedProgress
  }

  private endAngleDegrees(): number {
    return this.startAngleDegrees() + this.sweepAngleDegrees()
  }

  private arcCommands(): string {
    const size: number = Dimensions.dialCanvasSize
    const strokeWidth: number = Dimensions.dialStrokeWidth
    const radius: number = (size - strokeWidth) / 2
    const centerX: number = size / 2
    const centerY: number = size / 2
    const startAngle: number = this.startAngleDegrees() * Math.PI / 180
    const endAngle: number = this.endAngleDegrees() * Math.PI / 180
    const startX: number = centerX + radius * Math.cos(startAngle)
    const startY: number = centerY + radius * Math.sin(startAngle)
    const endX: number = centerX + radius * Math.cos(endAngle)
    const endY: number = centerY + radius * Math.sin(endAngle)
    const sweep: number = this.sweepAngleDegrees()
    const largeArc: number = sweep > 180 ? 1 : 0
    return `M ${startX} ${startY} A ${radius} ${radius} 0 ${largeArc} 1 ${endX} ${endY}`
  }

  private knobX(): number {
    const radius: number = (Dimensions.dialCanvasSize - Dimensions.dialStrokeWidth) / 2
    const endAngle: number = this.endAngleDegrees() * Math.PI / 180
    return Dimensions.dialCanvasSize / 2 + radius * Math.cos(endAngle)
  }

  private knobY(): number {
    const radius: number = (Dimensions.dialCanvasSize - Dimensions.dialStrokeWidth) / 2
    const endAngle: number = this.endAngleDegrees() * Math.PI / 180
    return Dimensions.dialCanvasSize / 2 + radius * Math.sin(endAngle)
  }

  build() {
    Stack() {
      // Arc
      Path()
        .commands(this.arcCommands())
        .stroke(this.isActive ? Colors.accentBlue : Colors.textGray)
        .strokeWidth(Dimensions.dialStrokeWidth)
        .strokeLineCap(LineCapStyle.Round)
        .fill(Color.Transparent)
        .width(Dimensions.dialCanvasSize)
        .height(Dimensions.dialCanvasSize)

      // Knob Indicator
      Stack() {
        Circle()
          .fill(Colors.pureWhite)
          .width(Dimensions.knobRadiusOuter * 2)
          .height(Dimensions.knobRadiusOuter * 2)
        Circle()
          .fill(this.isActive ? Colors.accentBlue : Colors.textGray)
          .width(Dimensions.knobRadiusInner * 2)
          .height(Dimensions.knobRadiusInner * 2)
      }
      .width(Dimensions.knobRadiusOuter * 2)
      .height(Dimensions.knobRadiusOuter * 2)
      .position({ x: this.knobX() - Dimensions.knobRadiusOuter, y: this.knobY() - Dimensions.knobRadiusOuter })
    }
    .width(Dimensions.dialCanvasSize)
    .height(Dimensions.dialCanvasSize)
  }
}

// MARK: - Round Control Button

@Component
struct RoundControlButton {
  iconName: string = '' // SF Symbol name
  action: () => void = () => {}
  @Prop isEnabled: boolean = true

  build() {
    Button() {
      Text(this.iconName)
        .fontSize(Dimensions.roundControlButtonIconSize)
        .fontColor(this.isEnabled ? Colors.textBlack : Colors.disabledIconGray)
    }
    .onClick((): void => {
      this.action()
    })
    .width(Dimensions.roundControlButtonSize)
    .height(Dimensions.roundControlButtonSize)
    .backgroundColor(this.isEnabled ? Colors.softGrayBg : Colors.lightGrayBg)
    .borderRadius(Dimensions.roundControlButtonSize / 2) // Equivalent to .clip(CircleShape)
    .border({
      width: this.isEnabled ? 0 : Dimensions.roundControlButtonBorderWidth,
      color: Colors.lightBorderGray
    }) // Equivalent to .border(..., CircleShape)
    .enabled(this.isEnabled) // Disable button interaction
  }
}

// MARK: - Control Grid Section

@Component
struct ControlGridSection {
  build() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(Dimensions.fontSizeLabelSmall)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.textGray)
        .padding({ bottom: Dimensions.quickActionsTitleBottomPadding })

      Row({ space: Dimensions.quickActionsRowSpacing }) { // Equivalent to Arrangement.spacedBy(16.dp)
        QuickActionCard({
          iconName: '↻', // SF Symbol for Refresh
          label: 'Fan Speed',
          status: 'Auto'
        })
          .layoutWeight(1)

        QuickActionCard({
          iconName: '♥', // SF Symbol for Favorite
          label: 'Eco Mode',
          status: 'On',
          isActive: true
        })
          .layoutWeight(1)
      }

      Blank()
        .height(Dimensions.quickActionsRowSpacing) // Equivalent to Modifier.height(16.dp)

      Row({ space: Dimensions.quickActionsRowSpacing }) {
        QuickActionCard({
          iconName: 'ℹ', // SF Symbol for Info (used as timer icon)
          label: 'Timer',
          status: 'Set 2h'
        })
          .layoutWeight(1)

        QuickActionCard({
          iconName: '⌂', // SF Symbol for Home
          label: 'Away',
          status: 'Off'
        })
          .layoutWeight(1)
      }
    }
    .alignItems(HorizontalAlign.Start) // Equivalent to Column(horizontalAlignment = Alignment.Start)
    .width('100%') // Equivalent to Modifier.fillMaxWidth()
  }
}

// MARK: - Quick Action Card

@Component
struct QuickActionCard {
  iconName: string = '' // SF Symbol name
  label: string = ''
  status: string = ''
  isActive: boolean = false

  build() {
    Column() {
      Text(this.iconName)
        .fontSize(Dimensions.quickActionCardIconSize)
        .fontColor(this.isActive ? Colors.pureWhite : Colors.textBlack)
        .padding({ bottom: 8 }) // Manual spacing between icon and text

      Blank() // Equivalent to verticalArrangement = Arrangement.SpaceBetween, pushing content apart
        .layoutWeight(1)

      Column() {
        Text(this.label)
          .fontSize(Dimensions.fontSizeLabelMedium)
          .fontWeight(Dimensions.fontWeightSemiBold)
          .fontColor(this.isActive ? Colors.pureWhite : Colors.textBlack)
        Text(this.status)
          .fontSize(Dimensions.fontSizeBodySmall)
          .fontWeight(FontWeight.Regular)
          .fontColor(Colors.textGray) // TextGray for both active/inactive status as per Kotlin
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start) // Equivalent to Column(horizontalAlignment = Alignment.Start)
    .padding(Dimensions.quickActionCardPadding) // Equivalent to Modifier.padding(16.dp)
    .height(Dimensions.quickActionCardHeight) // Equivalent to Modifier.height(100.dp)
    .backgroundColor(this.isActive ? Colors.textBlack : Colors.softGrayBg) // Equivalent to CardDefaults.cardColors
    .borderRadius(Dimensions.quickActionCardCornerRadius) // Equivalent to RoundedCornerShape(20.dp)
    // No shadow needed as elevation = 0.dp in Kotlin
  }
}

// MARK: - Preview

// Note: SwiftUI's PreviewProvider has no direct ArkTS equivalent;
// previews are provided by the DevEco Studio Previewer instead.
