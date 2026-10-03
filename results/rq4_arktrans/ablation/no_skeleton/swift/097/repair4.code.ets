import { drawing } from '@kit.ArkGraphics';

@Entry
@Component
struct ClimateControllerView {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  // Dimensions Constants
  private readonly screenPadding: number = 24
  private readonly headerTopPadding: number = 16
  private readonly headerSpacerHeight: number = 40
  private readonly dialSectionSpacerHeight: number = 40
  private readonly dialOuterBoxSize: number = 280
  private readonly dialCanvasSize: number = 240
  private readonly dialStrokeWidth: number = 40
  private readonly knobRadiusOuter: number = 16
  private readonly knobRadiusInner: number = 10
  private readonly tempControlsSpacerHeight: number = 32
  private readonly tempControlsHorizontalSpacing: number = 32
  private readonly roundControlButtonSize: number = 56
  private readonly quickActionsTitleBottomPadding: number = 16
  private readonly quickActionsRowSpacing: number = 16
  private readonly quickActionCardHeight: number = 100
  private readonly quickActionCardCornerRadius: number = 20
  private readonly quickActionCardPadding: number = 16
  private readonly quickActionCardIconSize: number = 24

  // Colors
  private readonly pureWhite: string = '#FFFFFF'
  private readonly textBlack: string = '#1C1C1E'
  private readonly textGray: string = '#8E8E93'
  private readonly accentBlue: string = '#007AFF'
  private readonly softGrayBg: string = '#F2F2F7'
  private readonly lightBorderGray: string = '#EEEEEE'
  private readonly disabledIconGray: string = '#D1D1D6'

  build() {
    Column() {
      // Header Section
      this.HeaderSection()
        .padding({ top: this.headerTopPadding })

      Blank().height(this.headerSpacerHeight)

      // Temperature Dial Section
      this.TemperatureDialSection()

      Blank().height(this.dialSectionSpacerHeight)

      // Control Grid Section
      this.ControlGridSection()

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pureWhite)
    .padding({ left: this.screenPadding, right: this.screenPadding })
  }

  @Builder
  HeaderSection() {
    Row() {
      // Menu Button (Using generic icon as placeholder per rules)
      Button() {
        Image($r('app.media.startIcon'))
          .width(28)
          .height(28)
          .fillColor(this.textBlack)
      }
      .backgroundColor(Color.Transparent)

      Blank()

      Column() {
        Text("LIVING ROOM")
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor(this.textGray)
        Text("Connected")
          .fontSize(11)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.accentBlue)
      }

      Blank()

      // Settings Button (Using generic icon as placeholder per rules)
      Button() {
        Image($r('app.media.startIcon'))
          .width(28)
          .height(28)
          .fillColor(this.textBlack)
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }

  @Builder
  TemperatureDialSection() {
    Column() {
      Stack() {
        // Background Circle
        Circle()
          .stroke(this.softGrayBg)
          .strokeWidth(this.dialStrokeWidth)
          .width(this.dialCanvasSize)
          .height(this.dialCanvasSize)

        // Animated Arc Indicator and Knob
        this.TemperatureDial(
          (this.targetTemp - 16.0) / (30.0 - 16.0),
          this.isActive
        )

        // Center Text
        Column() {
          Text(`${this.targetTemp.toFixed(1)}°`)
            .fontSize(45)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? this.textBlack : this.textGray)
          Text(this.isActive ? "COOLING" : "OFF")
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.textGray)
        }
      }
      .width(this.dialOuterBoxSize)
      .height(this.dialOuterBoxSize)

      Blank().height(this.tempControlsSpacerHeight)

      // Temp Controls
      Row({ space: this.tempControlsHorizontalSpacing }) {
        this.RoundControlButton(
          () => this.adjustTemp(-0.5),
          this.isActive,
          false
        )

        // Power Switch
        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .onChange((value: boolean) => {
            this.isActive = value
          })
          .width(50) // Approximate width for visual balance
          .height(30)
          .selectedColor(this.textBlack)

        this.RoundControlButton(
          () => this.adjustTemp(0.5),
          this.isActive,
          true
        )
      }
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  TemperatureDial(progress: number, isActive: boolean) {
    // Using a simplified drawing approach compatible with ArkTS Canvas/Path logic
    // Note: Full animation requires Animation class usage, here we render the state directly
    // to ensure compilability without complex animation controller setup.
    DrawingCanvas({ drawImage: (ctx: drawing.DrawingContext, size: Size) => {
      const strokeWidth = this.dialStrokeWidth
      const radius = (Math.min(size.width, size.height) - strokeWidth) / 2
      const centerX = size.width / 2
      const centerY = size.height / 2
      
      // Start angle: 135 degrees (bottom-leftish)
      // Sweep: 270 degrees total range
      const startAngleDeg = 135
      const sweepAngleDeg = 270 * progress
      
      ctx.lineWidth = strokeWidth
      ctx.lineCap = drawing.LineCap.ROUND
      ctx.strokeStyle = isActive ? this.accentBlue : this.textGray
      
      ctx.beginPath()
      // Convert degrees to radians. Canvas 0 is at 3 o'clock. 
      // We need to adjust standard math angles to match SwiftUI's coordinate system if necessary,
      // but usually adding rotation handles this.
      // Let's assume standard canvas coordinates where 0 is East.
      // 135 deg in standard math is South-West.
      const startRad = (startAngleDeg * Math.PI) / 180
      const endRad = ((startAngleDeg + sweepAngleDeg) * Math.PI) / 180
      
      // Draw Arc
      ctx.arc(centerX, centerY, radius, startRad, endRad, false) // false = clockwise
      ctx.stroke()

      // Draw Knob
      const knobX = centerX + radius * Math.cos(endRad)
      const knobY = centerY + radius * Math.sin(endRad)
      
      // Outer Knob
      ctx.fillStyle = this.pureWhite
      ctx.beginPath()
      ctx.arc(knobX, knobY, this.knobRadiusOuter, 0, 2 * Math.PI)
      ctx.fill()

      // Inner Knob
      ctx.fillStyle = isActive ? this.accentBlue : this.textGray
      ctx.beginPath()
      ctx.arc(knobX, knobY, this.knobRadiusInner, 0, 2 * Math.PI)
      ctx.fill()
    }})
      .width(this.dialCanvasSize)
      .height(this.dialCanvasSize)
  }

  @Builder
  RoundControlButton(action: () => void, enabled: boolean, isUp: boolean) {
    Button() {
      // Simulating Chevron Up/Down using rotation on the same icon resource
      Image($r('app.media.startIcon'))
        .width(28)
        .height(28)
        .fillColor(enabled ? this.textBlack : this.disabledIconGray)
        .rotate({ angle: isUp ? 180 : 0 })
    }
    .width(this.roundControlButtonSize)
    .height(this.roundControlButtonSize)
    .backgroundColor(enabled ? this.softGrayBg : this.lightBorderGray)
    .borderWidth(1)
    .borderColor(enabled ? Color.Transparent : this.lightBorderGray)
    .borderRadius(this.roundControlButtonSize / 2)
    .onClick(action)
    .enabled(enabled)
  }

  @Builder
  ControlGridSection() {
    Column() {
      Text("QUICK ACTIONS")
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textGray)
        .padding({ bottom: this.quickActionsTitleBottomPadding })

      Row({ space: this.quickActionsRowSpacing }) {
        this.QuickActionCard(
          "Fan Speed",
          "Auto",
          false
        )
        this.QuickActionCard(
          "Eco Mode",
          "On",
          true
        )
      }
      .width('100%')

      Blank().height(this.quickActionsRowSpacing)

      Row({ space: this.quickActionsRowSpacing }) {
        this.QuickActionCard(
          "Timer",
          "Set 2h",
          false
        )
        this.QuickActionCard(
          "Away",
          "Off",
          false
        )
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  QuickActionCard(label: string, status: string, isActive: boolean) {
    Column() {
      // Icon
      Image($r('app.media.startIcon'))
        .width(this.quickActionCardIconSize)
        .height(this.quickActionCardIconSize)
        .fillColor(isActive ? this.pureWhite : this.textBlack)
      
      Blank()

      Column() {
        Text(label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor(isActive ? this.pureWhite : this.textBlack)
        Text(status)
          .fontSize(11)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.textGray)
      }
    }
    .width('100%')
    .height(this.quickActionCardHeight)
    .padding(this.quickActionCardPadding)
    .backgroundColor(isActive ? this.textBlack : this.softGrayBg)
    .borderRadius(this.quickActionCardCornerRadius)
  }

  private adjustTemp(delta: number): void {
    let newTemp = this.targetTemp + delta
    if (newTemp < 16.0) newTemp = 16.0
    if (newTemp > 30.0) newTemp = 30.0
    // Round to 1 decimal place
    this.targetTemp = Math.round(newTemp * 10) / 10
  }
}