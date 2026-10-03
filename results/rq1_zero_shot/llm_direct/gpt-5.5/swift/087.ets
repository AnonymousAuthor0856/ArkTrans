class TeaColors {
  static readonly primary: string = '#6D4C41'
  static readonly secondary: string = '#A1887F'
  static readonly surfaceVariant: string = '#FAFAFA'
  static readonly outline: string = '#EEEEEE'
  static readonly backgroundTint: string = '#F5F5F5'
  static readonly teaLeafDetail: string = '#8D6E63'
  static readonly favoriteTint: string = '#FFCDD2'
  static readonly textSecondary: string = '#808080'
  static readonly textPrimary: string = '#000000'
  static readonly iconBox: string = '#EFEBE9'
  static readonly borderGray: string = '#E0E0E0'
}

@Entry
@Component
struct TeaMasterApp {
  build() {
    TeaBrewingScreen()
      .backgroundColor(Color.White)
  }
}

@Component
struct TeaBrewingScreen {
  build() {
    Stack() {
      Column() {
        HeaderSection()
          .padding({ top: 24, bottom: 32 })

        TeaSelectionCard()
          .padding({ bottom: 32 })

        TimerDisplay({ time: '02:00' })
          .padding({ bottom: 40 })

        ControlButtons()

        Blank()
          .layoutWeight(1)

        PreparationSteps()
          .padding({ bottom: 24 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(TeaColors.textSecondary)

        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)

      Blank()
        .layoutWeight(1)

      Button({ stateEffect: true }) {
        Text('⚙')
          .fontSize(24)
          .fontColor(TeaColors.textPrimary)
          .width(48)
          .height(48)
          .textAlign(TextAlign.Center)
      }
      .width(48)
      .height(48)
      .backgroundColor(TeaColors.backgroundTint)
      .borderRadius(24)
      .padding(0)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Row({ space: 16 }) {
      Stack() {
        Circle({ width: 60, height: 60 })
          .fill(TeaColors.iconBox)

        CustomLeafIcon()
          .width(30)
          .height(30)
      }
      .width(60)
      .height(60)

      Column({ space: 2 }) {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)

        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor(TeaColors.teaLeafDetail)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)

      Blank()
        .layoutWeight(1)

      Text('♥')
        .fontSize(26)
        .fontColor(TeaColors.favoriteTint)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(TeaColors.surfaceVariant)
    .borderRadius(24)
    .border({ width: 1, color: TeaColors.outline })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct CustomLeafIcon {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private draw(): void {
    this.context.clearRect(0, 0, 30, 30)
    this.context.strokeStyle = TeaColors.primary
    this.context.lineWidth = 2
    this.context.lineCap = 'round'

    this.context.beginPath()
    this.context.arc(15, 15, 13, 0, Math.PI * 2)
    this.context.stroke()

    this.context.beginPath()
    this.context.moveTo(15, 7.5)
    this.context.lineTo(15, 22.5)
    this.context.stroke()
  }

  build() {
    Canvas(this.context)
      .width(30)
      .height(30)
      .onReady(() => {
        this.draw()
      })
  }
}

@Component
struct TimerDisplay {
  @Prop time: string = '02:00'

  build() {
    Stack() {
      TimerRing()

      Column({ space: 4 }) {
        Text('Steeping')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(TeaColors.textSecondary)
          .letterSpacing(2)

        Text(this.time)
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor(TeaColors.textPrimary)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width(244)
    .height(244)
  }
}

@Component
struct TimerRing {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private draw(): void {
    const size: number = 244
    const center: number = size / 2
    const radius: number = 104
    const lineWidth: number = 12
    const startAngle: number = -210 * Math.PI / 180
    const endAngle: number = startAngle + Math.PI * 2 * 0.66

    this.context.clearRect(0, 0, size, size)

    this.context.lineWidth = lineWidth
    this.context.lineCap = 'round'

    this.context.beginPath()
    this.context.strokeStyle = TeaColors.backgroundTint
    this.context.arc(center, center, radius, 0, Math.PI * 2)
    this.context.stroke()

    this.context.beginPath()
    this.context.strokeStyle = TeaColors.primary
    this.context.arc(center, center, radius, startAngle, endAngle)
    this.context.stroke()
  }

  build() {
    Canvas(this.context)
      .width(244)
      .height(244)
      .onReady(() => {
        this.draw()
      })
  }
}

@Component
struct ControlButtons {
  build() {
    Row({ space: 24 }) {
      Stack() {
        Circle({ width: 60, height: 60 })
          .fill(Color.White)
          .stroke({ width: 1, color: TeaColors.borderGray })

        Text('↺')
          .fontSize(28)
          .fontColor(TeaColors.textSecondary)
      }
      .width(60)
      .height(60)
      .onClick(() => {
      })

      Row({ space: 8 }) {
        Text('▶')
          .fontSize(18)
          .fontColor(Color.White)

        Text('Start')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
      }
      .width(120)
      .height(60)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(TeaColors.primary)
      .borderRadius(24)
      .onClick(() => {
      })

      Stack() {
        Circle({ width: 60, height: 60 })
          .fill(Color.White)
          .stroke({ width: 1, color: TeaColors.borderGray })

        Text('+')
          .fontSize(30)
          .fontColor(TeaColors.textSecondary)
      }
      .width(60)
      .height(60)
      .onClick(() => {
      })
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct PreparationSteps {
  build() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('rgba(128,128,128,0.8)')
        .padding({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })

      Divider()
        .color(TeaColors.backgroundTint)

      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })

      Divider()
        .color(TeaColors.backgroundTint)

      StepItem({ step: '3', text: 'Pour water and wait for timer' })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StepItem {
  @Prop step: string = ''
  @Prop text: string = ''

  build() {
    Row({ space: 12 }) {
      Text(this.step)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(TeaColors.textPrimary)
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .backgroundColor(TeaColors.backgroundTint)
        .borderRadius(12)

      Text(this.text)
        .fontSize(14)
        .fontColor(TeaColors.textSecondary)

      Blank()
        .layoutWeight(1)

      Text('✓')
        .fontSize(12)
        .fontColor(TeaColors.outline)
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
  }
}