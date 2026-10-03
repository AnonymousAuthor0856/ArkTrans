const Dimensions = {
  screenPadding: 24,
  headerTopPadding: 16,
  headerSpacerHeight: 40,
  dialSectionSpacerHeight: 40,

  dialOuterBoxSize: 280,
  dialCanvasSize: 240,
  dialStrokeWidth: 40,
  knobRadiusOuter: 16,
  knobRadiusInner: 10,
  tempControlsSpacerHeight: 32,
  tempControlsHorizontalSpacing: 32,

  roundControlButtonSize: 56,
  roundControlButtonBorderWidth: 1,
  roundControlButtonIconSize: 28,

  quickActionsTitleBottomPadding: 16,
  quickActionsRowSpacing: 16,
  quickActionCardHeight: 100,
  quickActionCardCornerRadius: 20,
  quickActionCardPadding: 16,
  quickActionCardIconSize: 30,

  letterSpacingSmall: 2,
  fontSizeLabelMedium: 13,
  fontSizeBodySmall: 11,
  fontSizeDisplayMedium: 45,
  fontSizeLabelLarge: 15,
  fontSizeLabelSmall: 11
}

const AppColors = {
  pureWhite: '#FFFFFFFF',
  textBlack: '#FF1C1C1E',
  textGray: '#FF8E8E93',
  accentBlue: '#FF007AFF',
  softGrayBg: '#FFF2F2F7',
  activeOrange: '#FFFF9500',
  lightGrayBg: '#FFF9F9F9',
  lightBorderGray: '#FFEEEEEE',
  disabledIconGray: '#FFD1D1D6'
}

@Entry
@Component
struct ClimateControllerView {
  @State private targetTemp: number = 21.5
  @State private isActive: boolean = true

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
    Stack() {
      Column() {
        this.HeaderSection()

        Blank()
          .height(Dimensions.headerSpacerHeight)

        this.TemperatureDialSection()

        Blank()
          .height(Dimensions.dialSectionSpacerHeight)

        this.ControlGridSection()

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({
        left: Dimensions.screenPadding,
        right: Dimensions.screenPadding,
        top: Dimensions.headerTopPadding
      })
      .backgroundColor(AppColors.pureWhite)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.pureWhite)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  private HeaderSection() {
    Row() {
      Text('☰')
        .fontSize(Dimensions.roundControlButtonIconSize)
        .fontColor(AppColors.textBlack)
        .width(40)
        .height(40)
        .textAlign(TextAlign.Center)

      Blank()
        .layoutWeight(1)

      Column() {
        Text('LIVING ROOM')
          .fontSize(Dimensions.fontSizeLabelMedium)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.textGray)
          .letterSpacing(Dimensions.letterSpacingSmall)

        Text('Connected')
          .fontSize(Dimensions.fontSizeBodySmall)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.accentBlue)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()
        .layoutWeight(1)

      Text('⚙')
        .fontSize(Dimensions.roundControlButtonIconSize)
        .fontColor(AppColors.textBlack)
        .width(40)
        .height(40)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private TemperatureDialSection() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        TemperatureDialCanvas({
          progress: (this.targetTemp - 16.0) / (30.0 - 16.0),
          isActive: this.isActive
        })
          .width(Dimensions.dialCanvasSize)
          .height(Dimensions.dialCanvasSize)

        Column() {
          Text(`${this.targetTemp.toFixed(1)}°`)
            .fontSize(Dimensions.fontSizeDisplayMedium)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? AppColors.textBlack : AppColors.textGray)

          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(Dimensions.fontSizeLabelLarge)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.textGray)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(Dimensions.dialOuterBoxSize)
      .height(Dimensions.dialOuterBoxSize)

      Blank()
        .height(Dimensions.tempControlsSpacerHeight)

      Row({ space: Dimensions.tempControlsHorizontalSpacing }) {
        RoundControlButton({
          iconText: '⌄',
          enabledValue: this.isActive,
          action: () => {
            this.adjustTemp(-0.5)
          }
        })

        this.PowerSwitch()

        RoundControlButton({
          iconText: '⌃',
          enabledValue: this.isActive,
          action: () => {
            this.adjustTemp(0.5)
          }
        })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  private PowerSwitch() {
    Stack({
      alignContent: this.isActive ? Alignment.End : Alignment.Start
    }) {
      Row()
        .width(28)
        .height(28)
        .borderRadius(14)
        .backgroundColor(AppColors.pureWhite)
        .margin({ left: 2, right: 2 })
    }
    .width(52)
    .height(32)
    .borderRadius(16)
    .backgroundColor(this.isActive ? AppColors.textBlack : AppColors.softGrayBg)
    .onClick(() => {
      this.isActive = !this.isActive
    })
  }

  @Builder
  private ControlGridSection() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(Dimensions.fontSizeLabelSmall)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.textGray)
        .width('100%')
        .margin({ bottom: Dimensions.quickActionsTitleBottomPadding })

      Row({ space: Dimensions.quickActionsRowSpacing }) {
        QuickActionCard({
          iconText: '↻',
          label: 'Fan Speed',
          status: 'Auto'
        })

        QuickActionCard({
          iconText: '♥',
          label: 'Eco Mode',
          status: 'On',
          isActive: true
        })
      }
      .width('100%')

      Blank()
        .height(Dimensions.quickActionsRowSpacing)

      Row({ space: Dimensions.quickActionsRowSpacing }) {
        QuickActionCard({
          iconText: 'ℹ',
          label: 'Timer',
          status: 'Set 2h'
        })

        QuickActionCard({
          iconText: '⌂',
          label: 'Away',
          status: 'Off'
        })
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct TemperatureDialCanvas {
  @Prop @Watch('redraw') progress: number = 0
  @Prop @Watch('redraw') isActive: boolean = true

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private redraw(): void {
    setTimeout(() => {
      this.drawDial()
    }, 0)
  }

  private drawDial(): void {
    const size: number = Dimensions.dialCanvasSize
    const center: number = size / 2
    const radius: number = (size - Dimensions.dialStrokeWidth) / 2
    const startAngle: number = 135 * Math.PI / 180
    const normalizedProgress: number = Math.max(0, Math.min(1, this.progress))
    const endAngle: number = (135 + 270 * normalizedProgress) * Math.PI / 180

    this.context.clearRect(0, 0, size, size)

    this.context.beginPath()
    this.context.lineWidth = Dimensions.dialStrokeWidth
    this.context.lineCap = 'round'
    this.context.strokeStyle = AppColors.softGrayBg
    this.context.arc(center, center, radius, 0, Math.PI * 2, false)
    this.context.stroke()

    this.context.beginPath()
    this.context.lineWidth = Dimensions.dialStrokeWidth
    this.context.lineCap = 'round'
    this.context.strokeStyle = this.isActive ? AppColors.accentBlue : AppColors.textGray
    this.context.arc(center, center, radius, startAngle, endAngle, false)
    this.context.stroke()

    const knobX: number = center + radius * Math.cos(endAngle)
    const knobY: number = center + radius * Math.sin(endAngle)

    this.context.beginPath()
    this.context.fillStyle = AppColors.pureWhite
    this.context.arc(knobX, knobY, Dimensions.knobRadiusOuter, 0, Math.PI * 2, false)
    this.context.fill()

    this.context.beginPath()
    this.context.fillStyle = this.isActive ? AppColors.accentBlue : AppColors.textGray
    this.context.arc(knobX, knobY, Dimensions.knobRadiusInner, 0, Math.PI * 2, false)
    this.context.fill()
  }

  build() {
    Canvas(this.context)
      .width(Dimensions.dialCanvasSize)
      .height(Dimensions.dialCanvasSize)
      .onReady(() => {
        this.drawDial()
      })
  }
}

@Component
struct RoundControlButton {
  @Prop iconText: string = ''
  @Prop enabledValue: boolean = true
  action: () => void = () => {
  }

  build() {
    Button({ type: ButtonType.Circle, stateEffect: this.enabledValue }) {
      Text(this.iconText)
        .fontSize(Dimensions.roundControlButtonIconSize + 8)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.enabledValue ? AppColors.textBlack : AppColors.disabledIconGray)
        .textAlign(TextAlign.Center)
    }
    .width(Dimensions.roundControlButtonSize)
    .height(Dimensions.roundControlButtonSize)
    .backgroundColor(this.enabledValue ? AppColors.softGrayBg : AppColors.lightGrayBg)
    .border({
      width: this.enabledValue ? 0 : Dimensions.roundControlButtonBorderWidth,
      color: this.enabledValue ? Color.Transparent : AppColors.lightBorderGray
    })
    .enabled(this.enabledValue)
    .onClick(() => {
      if (this.enabledValue) {
        this.action()
      }
    })
  }
}

@Component
struct QuickActionCard {
  @Prop iconText: string = ''
  @Prop label: string = ''
  @Prop status: string = ''
  @Prop isActive: boolean = false

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        Text(this.iconText)
          .fontSize(Dimensions.quickActionCardIconSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isActive ? AppColors.pureWhite : AppColors.textBlack)
          .margin({ bottom: 8 })

        Blank()
          .layoutWeight(1)

        Column() {
          Text(this.label)
            .fontSize(Dimensions.fontSizeLabelMedium)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(this.isActive ? AppColors.pureWhite : AppColors.textBlack)

          Text(this.status)
            .fontSize(Dimensions.fontSizeBodySmall)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.textGray)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .height(Dimensions.quickActionCardHeight - Dimensions.quickActionCardPadding * 2)
      .alignItems(HorizontalAlign.Start)
    }
    .height(Dimensions.quickActionCardHeight)
    .layoutWeight(1)
    .padding(Dimensions.quickActionCardPadding)
    .backgroundColor(this.isActive ? AppColors.textBlack : AppColors.softGrayBg)
    .borderRadius(Dimensions.quickActionCardCornerRadius)
  }
}