@Entry
@Component
struct TeaBrewingScreen {
  build() {
    Stack() {
      Column() {
        HeaderSection()
          .margin({ top: 24, bottom: 32 })

        TeaSelectionCard()
          .margin({ bottom: 32 })

        TimerDisplay({ time: '02:00' })
          .margin({ bottom: 40 })

        ControlButtons()

        Blank()
          .layoutWeight(1)

        PreparationSteps()
          .margin({ bottom: 24 })
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

class TeaColors {
  static readonly primary: string = '#6D4C41'
  static readonly secondary: string = '#A1887F'
  static readonly surfaceVariant: string = '#FAFAFA'
  static readonly outline: string = '#EEEEEE'
  static readonly backgroundTint: string = '#F5F5F5'
  static readonly teaLeafDetail: string = '#8D6E63'
  static readonly favoriteTint: string = '#FFCDD2'
  static readonly textSecondary: string = '#8E8E93'
  static readonly textPrimary: string = '#000000'
  static readonly iconTint: string = '#8A8A8E'
  static readonly buttonBorder: string = '#E0E0E0'
  static readonly leafBack: string = '#EFEBE9'
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(TeaColors.textSecondary)
          .fontWeight(FontWeight.Regular)
          .lineHeight(18)

        Text('Tea Master')
          .fontSize(22)
          .fontColor(TeaColors.textPrimary)
          .fontWeight(FontWeight.Bold)
          .lineHeight(28)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button() {
        Text('⚙')
          .fontSize(30)
          .fontColor(TeaColors.textPrimary)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(TeaColors.backgroundTint)
      .padding(0)
      .stateEffect(false)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Row() {
      Stack() {
        Circle()
          .width(60)
          .height(60)
          .fill(TeaColors.leafBack)

        TeaIcon()
          .width(30)
          .height(30)
      }
      .width(60)
      .height(60)
      .margin({ right: 16 })

      Column() {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontColor(TeaColors.textPrimary)
          .fontWeight(FontWeight.Bold)
          .lineHeight(22)

        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor(TeaColors.teaLeafDetail)
          .lineHeight(18)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Text('♥')
        .fontSize(32)
        .fontColor(TeaColors.favoriteTint)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .width(40)
    }
    .width('100%')
    .height(100)
    .padding({ left: 20, right: 20, top: 20, bottom: 20 })
    .backgroundColor(TeaColors.surfaceVariant)
    .borderRadius(24)
    .border({ width: 1, color: TeaColors.outline })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaIcon {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width(30)
      .height(30)
      .onReady(() => {
        this.context.clearRect(0, 0, 30, 30)
        this.context.strokeStyle = TeaColors.primary
        this.context.lineWidth = 3
        this.context.lineCap = 'round'
        this.context.beginPath()
        this.context.arc(15, 15, 14, 0, Math.PI * 2)
        this.context.stroke()
        this.context.beginPath()
        this.context.moveTo(15, 7)
        this.context.lineTo(15, 23)
        this.context.stroke()
      })
  }
}

@Component
struct TimerDisplay {
  time: string = '02:00'

  build() {
    Stack() {
      TimerRing()
        .width(240)
        .height(240)

      Column() {
        Text('Steeping')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(TeaColors.textSecondary)
          .letterSpacing(4)
          .lineHeight(20)
          .margin({ bottom: 4 })

        Text(this.time)
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor(TeaColors.textPrimary)
          .lineHeight(62)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(240)
    .height(240)
  }
}

@Component
struct TimerRing {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width(240)
      .height(240)
      .onReady(() => {
        const center: number = 120
        const radius: number = 104
        this.context.clearRect(0, 0, 240, 240)
        this.context.lineWidth = 12
        this.context.lineCap = 'round'

        this.context.strokeStyle = TeaColors.backgroundTint
        this.context.beginPath()
        this.context.arc(center, center, radius, 0, Math.PI * 2)
        this.context.stroke()

        this.context.strokeStyle = TeaColors.primary
        this.context.beginPath()
        this.context.arc(center, center, radius, 2.62, 6.81)
        this.context.stroke()
      })
  }
}

@Component
struct ControlButtons {
  build() {
    Row() {
      RoundIconButton({ icon: '↻' })

      Button() {
        Row() {
          Text('▶')
            .fontSize(24)
            .fontColor(Color.White)
            .margin({ right: 8 })

          Text('Start')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor(TeaColors.primary)
      .padding(0)
      .stateEffect(false)
      .margin({ left: 24, right: 24 })

      RoundIconButton({ icon: '+' })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .width('100%')
  }
}

@Component
struct RoundIconButton {
  icon: string = ''

  build() {
    Button() {
      Text(this.icon)
        .fontSize(this.icon === '+' ? 40 : 34)
        .fontColor(TeaColors.iconTint)
        .fontWeight(FontWeight.Regular)
        .textAlign(TextAlign.Center)
        .width(60)
        .height(60)
    }
    .width(60)
    .height(60)
    .borderRadius(30)
    .backgroundColor(Color.White)
    .border({ width: 1, color: TeaColors.buttonBorder })
    .padding(0)
    .stateEffect(false)
  }
}

@Component
struct PreparationSteps {
  build() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#9E9EA4')
        .lineHeight(16)
        .margin({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })
      Divider()
        .color('#D6D6D6')
      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })
      Divider()
        .color('#D6D6D6')
      StepItem({ step: '3', text: 'Pour water and wait for timer' })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StepItem {
  step: string = ''
  text: string = ''

  build() {
    Row() {
      Text(this.step)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(TeaColors.textPrimary)
        .textAlign(TextAlign.Center)
        .width(24)
        .height(24)
        .lineHeight(24)
        .borderRadius(12)
        .backgroundColor(TeaColors.backgroundTint)
        .margin({ right: 24 })

      Text(this.text)
        .fontSize(14)
        .fontColor(TeaColors.textSecondary)
        .lineHeight(24)
        .layoutWeight(1)

      Text('✓')
        .fontSize(20)
        .fontColor(TeaColors.outline)
        .textAlign(TextAlign.Center)
        .width(24)
    }
    .width('100%')
    .height(40)
    .alignItems(VerticalAlign.Center)
  }
}
