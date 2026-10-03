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

class AppColors {
  static readonly pureWhite: string = '#FFFFFF'
  static readonly textBlack: string = '#1C1C1E'
  static readonly textGray: string = '#8E8E93'
  static readonly accentBlue: string = '#007AFF'
  static readonly softGrayBg: string = '#F2F2F7'
  static readonly activeOrange: string = '#FF9500'
  static readonly lightGrayBg: string = '#F9F9F9'
  static readonly lightBorderGray: string = '#EEEEEE'
  static readonly disabledIconGray: string = '#D1D1D6'
  static readonly transparent: string = '#00000000'
}

@Entry
@Component
struct ClimateControllerView {
  build() {
    Stack() {
      Column({ space: 0 }) {
        HeaderSection()
          .margin({ top: Dimensions.headerTopPadding })

        Blank()
          .height(Dimensions.headerSpacerHeight)

        TemperatureDialSection()

        Blank()
          .height(Dimensions.dialSectionSpacerHeight)

        ControlGridSection()

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({
        left: Dimensions.screenPadding,
        right: Dimensions.screenPadding
      })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.pureWhite)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Button({ type: ButtonType.Normal, stateEffect: false }) {
        Text('☰')
          .fontSize(Dimensions.roundControlButtonIconSize)
          .fontColor(AppColors.textBlack)
      }
      .width(56)
      .height(56)
      .backgroundColor(Color.Transparent)

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

      Button({ type: ButtonType.Normal, stateEffect: false }) {
        Text('⚙')
          .fontSize(Dimensions.roundControlButtonIconSize)
          .fontColor(AppColors.textBlack)
      }
      .width(56)
      .height(56)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  private adjustTemp(delta: number): void {
    const nextValue = Math.min(Math.max(this.targetTemp + delta, 16.0), 30.0)
    this.targetTemp = Math.round(nextValue * 10) / 10
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        TemperatureDial({
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
          iconName: '⌄',
          enabled: this.isActive,
          action: () => {
            this.adjustTemp(-0.5)
          }
        })

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor(AppColors.textBlack)
          .onChange((isOn: boolean) => {
            this.isActive = isOn
          })

        RoundControlButton({
          iconName: '⌃',
          enabled: this.isActive,
          action: () => {
            this.adjustTemp(0.5)
          }
        })
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct TemperatureDial {
  @Prop @Watch('onProgressChange') progress: number = 0
  @Prop @Watch('onActiveChange') isActive: boolean = true

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private animatedProgress: number = 0
  private isCanvasReady: boolean = false
  private animationTimer: number | undefined = undefined

  private onProgressChange(): void {
    this.animateToProgress()
  }

  private onActiveChange(): void {
    this.drawDial()
  }

  private animateToProgress(): void {
    if (!this.isCanvasReady) {
      return
    }

    if (this.animationTimer !== undefined) {
      clearInterval(this.animationTimer)
      this.animationTimer = undefined
    }

    const startProgress = this.animatedProgress
    const endProgress = Math.min(Math.max(this.progress, 0), 1)
    const duration = 500
    const startTime = Date.now()

    this.animationTimer = setInterval(() => {
      const elapsed = Date.now() - startTime
      const fraction = Math.min(elapsed / duration, 1)
      const eased = 1 - Math.pow(1 - fraction, 3)

      this.animatedProgress = startProgress + (endProgress - startProgress) * eased
      this.drawDial()

      if (fraction >= 1 && this.animationTimer !== undefined) {
        clearInterval(this.animationTimer)
        this.animationTimer = undefined
      }
    }, 16)
  }

  private drawDial(): void {
    if (!this.isCanvasReady) {
      return
    }

    const size = Dimensions.dialCanvasSize
    const strokeWidth = Dimensions.dialStrokeWidth
    const center = size / 2
    const radius = (size - strokeWidth) / 2
    const startAngle = 135 * Math.PI / 180
    const endAngle = (135 + 270 * this.animatedProgress) * Math.PI / 180

    this.context.clearRect(0, 0, size, size)

    this.context.beginPath()
    this.context.lineWidth = strokeWidth
    this.context.lineCap = 'butt'
    this.context.strokeStyle = AppColors.softGrayBg
    this.context.arc(center, center, radius, 0, 2 * Math.PI, false)
    this.context.stroke()

    this.context.beginPath()
    this.context.lineWidth = strokeWidth
    this.context.lineCap = 'round'
    this.context.strokeStyle = this.isActive ? AppColors.accentBlue : AppColors.textGray
    this.context.arc(center, center, radius, startAngle, endAngle, false)
    this.context.stroke()

    const knobX = center + radius * Math.cos(endAngle)
    const knobY = center + radius * Math.sin(endAngle)

    this.context.beginPath()
    this.context.fillStyle = AppColors.pureWhite
    this.context.arc(knobX, knobY, Dimensions.knobRadiusOuter, 0, 2 * Math.PI, false)
    this.context.fill()

    this.context.beginPath()
    this.context.fillStyle = this.isActive ? AppColors.accentBlue : AppColors.textGray
    this.context.arc(knobX, knobY, Dimensions.knobRadiusInner, 0, 2 * Math.PI, false)
    this.context.fill()
  }

  aboutToDisappear(): void {
    if (this.animationTimer !== undefined) {
      clearInterval(this.animationTimer)
      this.animationTimer = undefined
    }
  }

  build() {
    Canvas(this.context)
      .width(Dimensions.dialCanvasSize)
      .height(Dimensions.dialCanvasSize)
      .onReady(() => {
        this.isCanvasReady = true
        this.animatedProgress = 0
        this.animateToProgress()
      })
  }
}

@Component
struct RoundControlButton {
  iconName: string = ''
  action: () => void = () => {
  }
  enabled: boolean = true

  build() {
    Button({ type: ButtonType.Circle, stateEffect: this.enabled }) {
      Text(this.iconName)
        .fontSize(Dimensions.roundControlButtonIconSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.enabled ? AppColors.textBlack : AppColors.disabledIconGray)
    }
    .width(Dimensions.roundControlButtonSize)
    .height(Dimensions.roundControlButtonSize)
    .backgroundColor(this.enabled ? AppColors.softGrayBg : AppColors.lightGrayBg)
    .border({
      width: this.enabled ? 0 : Dimensions.roundControlButtonBorderWidth,
      color: this.enabled ? AppColors.transparent : AppColors.lightBorderGray
    })
    .enabled(this.enabled)
    .onClick(() => {
      if (this.enabled) {
        this.action()
      }
    })
  }
}

@Component
struct ControlGridSection {
  build() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(Dimensions.fontSizeLabelSmall)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.textGray)
        .margin({ bottom: Dimensions.quickActionsTitleBottomPadding })

      Row({ space: Dimensions.quickActionsRowSpacing }) {
        QuickActionCard({
          iconName: '↻',
          label: 'Fan Speed',
          status: 'Auto'
        })
          .layoutWeight(1)

        QuickActionCard({
          iconName: '♥',
          label: 'Eco Mode',
          status: 'On',
          isActive: true
        })
          .layoutWeight(1)
      }
      .width('100%')

      Blank()
        .height(Dimensions.quickActionsRowSpacing)

      Row({ space: Dimensions.quickActionsRowSpacing }) {
        QuickActionCard({
          iconName: 'ⓘ',
          label: 'Timer',
          status: 'Set 2h'
        })
          .layoutWeight(1)

        QuickActionCard({
          iconName: '⌂',
          label: 'Away',
          status: 'Off'
        })
          .layoutWeight(1)
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct QuickActionCard {
  iconName: string = ''
  label: string = ''
  status: string = ''
  isActive: boolean = false

  build() {
    Column({ space: 0 }) {
      Text(this.iconName)
        .fontSize(Dimensions.quickActionCardIconSize)
        .fontWeight(FontWeight.Medium)
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
    .width('100%')
    .height(Dimensions.quickActionCardHeight)
    .padding(Dimensions.quickActionCardPadding)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.isActive ? AppColors.textBlack : AppColors.softGrayBg)
    .borderRadius(Dimensions.quickActionCardCornerRadius)
  }
}