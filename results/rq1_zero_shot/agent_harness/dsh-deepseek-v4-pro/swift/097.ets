// Translated from 097.swift (Climate Controller App)

class Dimensions {
  static readonly screenPadding: number = 24
  static readonly headerTopPadding: number = 16
  static readonly headerSpacerHeight: number = 40
  static readonly dialSectionSpacerHeight: number = 40
  static readonly dialOuterBoxSize: number = 280
  static readonly dialCanvasSize: number = 240
  static readonly dialStrokeWidth: number = 40
  static readonly knobRadiusOuter: number = 16
  static readonly knobRadiusInner: number = 10
  static readonly tempControlsSpacerHeight: number = 32
  static readonly tempControlsHorizontalSpacing: number = 32
  static readonly roundControlButtonSize: number = 56
  static readonly roundControlButtonBorderWidth: number = 1
  static readonly roundControlButtonIconSize: number = 28
  static readonly quickActionsTitleBottomPadding: number = 16
  static readonly quickActionsRowSpacing: number = 16
  static readonly quickActionCardHeight: number = 100
  static readonly quickActionCardCornerRadius: number = 20
  static readonly quickActionCardPadding: number = 16
  static readonly quickActionCardIconSize: number = 24
  static readonly letterSpacingSmall: number = 2
  static readonly fontSizeLabelMedium: number = 13
  static readonly fontSizeBodySmall: number = 11
  static readonly fontSizeDisplayMedium: number = 45
  static readonly fontSizeLabelLarge: number = 15
  static readonly fontSizeLabelSmall: number = 11
}

@Entry
@Component
struct Index {
  build() {
    ClimateControllerView()
  }
}

@Component
struct ClimateControllerView {
  build() {
    Stack() {
      Column() {
        HeaderSection()
          .padding({ top: Dimensions.headerTopPadding })

        Blank().height(Dimensions.headerSpacerHeight)

        TemperatureDialSection()

        Blank().height(Dimensions.dialSectionSpacerHeight)

        ControlGridSection()

        Blank()
      }
      .padding({ left: Dimensions.screenPadding, right: Dimensions.screenPadding })
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(Dimensions.roundControlButtonIconSize)
          .fontColor('#1C1C1E')
      }
      .onClick(() => {})

      Blank()

      Column() {
        Text('LIVING ROOM')
          .fontSize(Dimensions.fontSizeLabelMedium)
          .fontWeight(FontWeight.Bold)
          .fontColor('#8E8E93')
          .letterSpacing(Dimensions.letterSpacingSmall)
        Text('Connected')
          .fontSize(Dimensions.fontSizeBodySmall)
          .fontWeight(FontWeight.Regular)
          .fontColor('#007AFF')
      }

      Blank()

      Button() {
        Text('⚙')
          .fontSize(Dimensions.roundControlButtonIconSize)
          .fontColor('#1C1C1E')
      }
      .onClick(() => {})
    }
    .width('100%')
  }
}

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  private adjustTemp(delta: number): void {
    let newTemp = this.targetTemp + delta
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
        Circle()
          .fillOpacity(0)
          .stroke('#F2F2F7')
          .strokeWidth(Dimensions.dialStrokeWidth)
          .width(Dimensions.dialCanvasSize)
          .height(Dimensions.dialCanvasSize)

        TemperatureDial({
          progress: (this.targetTemp - 16.0) / (30.0 - 16.0),
          isActive: this.isActive
        })
        .width(Dimensions.dialCanvasSize)
        .height(Dimensions.dialCanvasSize)

        Column() {
          Text(this.targetTemp.toFixed(1) + '°')
            .fontSize(Dimensions.fontSizeDisplayMedium)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? '#1C1C1E' : '#8E8E93')
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(Dimensions.fontSizeLabelLarge)
            .fontWeight(FontWeight.Medium)
            .fontColor('#8E8E93')
        }
      }
      .width(Dimensions.dialOuterBoxSize)
      .height(Dimensions.dialOuterBoxSize)

      Blank().height(Dimensions.tempControlsSpacerHeight)

      Row({ space: Dimensions.tempControlsHorizontalSpacing }) {
        RoundControlButton({
          iconName: '▼',
          action: () => { this.adjustTemp(-0.5) },
          enabled: this.isActive
        })

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .onChange((isOn: boolean) => { this.isActive = isOn })
          .selectedColor('#1C1C1E')

        RoundControlButton({
          iconName: '▲',
          action: () => { this.adjustTemp(0.5) },
          enabled: this.isActive
        })
      }
    }
  }
}

@Component
struct TemperatureDial {
  @Prop progress: number = 0
  @Prop isActive: boolean = true
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width(Dimensions.dialCanvasSize)
      .height(Dimensions.dialCanvasSize)
      .onReady(() => {
        const size = Dimensions.dialCanvasSize
        const strokeWidth = Dimensions.dialStrokeWidth
        const startAngleDegrees = 135
        const sweepAngleDegrees = 270 * this.progress
        const endAngleDegrees = startAngleDegrees + sweepAngleDegrees
        const radius = (size - strokeWidth) / 2
        const center = size / 2

        this.context.strokeStyle = this.isActive ? '#007AFF' : '#8E8E93'
        this.context.lineWidth = strokeWidth
        this.context.lineCap = 'round'
        this.context.beginPath()
        this.context.arc(center, center, radius,
          (startAngleDegrees * Math.PI) / 180,
          (endAngleDegrees * Math.PI) / 180, false)
        this.context.stroke()

        const angleRad = (endAngleDegrees * Math.PI) / 180
        const knobX = center + radius * Math.cos(angleRad)
        const knobY = center + radius * Math.sin(angleRad)

        this.context.fillStyle = '#FFFFFF'
        this.context.beginPath()
        this.context.arc(knobX, knobY, Dimensions.knobRadiusOuter, 0, Math.PI * 2)
        this.context.fill()

        this.context.fillStyle = this.isActive ? '#007AFF' : '#8E8E93'
        this.context.beginPath()
        this.context.arc(knobX, knobY, Dimensions.knobRadiusInner, 0, Math.PI * 2)
        this.context.fill()
      })
  }
}

@Component
struct RoundControlButton {
  @Prop iconName: string = ''
  action: () => void = () => {}
  @Prop enabled: boolean = true

  build() {
    Button() {
      Text(this.iconName)
        .fontSize(Dimensions.roundControlButtonIconSize)
        .fontColor(this.enabled ? '#1C1C1E' : '#D1D1D6')
        .width(Dimensions.roundControlButtonSize)
        .height(Dimensions.roundControlButtonSize)
        .textAlign(TextAlign.Center)
    }
    .backgroundColor(this.enabled ? '#F2F2F7' : '#F9F9F9')
    .borderRadius(Dimensions.roundControlButtonSize / 2)
    .border({
      width: Dimensions.roundControlButtonBorderWidth,
      color: this.enabled ? '#00000000' : '#EEEEEE',
      radius: Dimensions.roundControlButtonSize / 2
    })
    .enabled(this.enabled)
    .onClick(() => { this.action() })
  }
}

@Component
struct ControlGridSection {
  build() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(Dimensions.fontSizeLabelSmall)
        .fontWeight(FontWeight.Bold)
        .fontColor('#8E8E93')
        .padding({ bottom: Dimensions.quickActionsTitleBottomPadding })

      Row({ space: Dimensions.quickActionsRowSpacing }) {
        QuickActionCard({ iconName: '↻', label: 'Fan Speed', status: 'Auto' })
          .layoutWeight(1)
        QuickActionCard({ iconName: '♥', label: 'Eco Mode', status: 'On', isActive: true })
          .layoutWeight(1)
      }

      Blank().height(Dimensions.quickActionsRowSpacing)

      Row({ space: Dimensions.quickActionsRowSpacing }) {
        QuickActionCard({ iconName: 'ⓘ', label: 'Timer', status: 'Set 2h' })
          .layoutWeight(1)
        QuickActionCard({ iconName: '⌂', label: 'Away', status: 'Off' })
          .layoutWeight(1)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct QuickActionCard {
  @Prop iconName: string = ''
  @Prop label: string = ''
  @Prop status: string = ''
  @Prop isActive: boolean = false

  build() {
    Column() {
      Text(this.iconName)
        .fontSize(Dimensions.quickActionCardIconSize)
        .fontColor(this.isActive ? '#FFFFFF' : '#1C1C1E')
        .padding({ bottom: 8 })

      Blank()

      Column() {
        Text(this.label)
          .fontSize(Dimensions.fontSizeLabelMedium)
          .fontWeight(FontWeight.Semibold)
          .fontColor(this.isActive ? '#FFFFFF' : '#1C1C1E')
        Text(this.status)
          .fontSize(Dimensions.fontSizeBodySmall)
          .fontWeight(FontWeight.Regular)
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(Dimensions.quickActionCardPadding)
    .height(Dimensions.quickActionCardHeight)
    .backgroundColor(this.isActive ? '#1C1C1E' : '#F2F2F7')
    .borderRadius(Dimensions.quickActionCardCornerRadius)
  }
}
