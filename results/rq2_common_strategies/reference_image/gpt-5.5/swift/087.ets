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
}

@Entry
@Component
struct TeaMasterApp {
  build() {
    Stack() {
      TeaBrewingScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct TeaBrewingScreen {
  build() {
    Column() {
      HeaderSection()
        .margin({ top: 24, bottom: 32 })

      TeaSelectionCard()
        .margin({ bottom: 40 })

      TimerDisplay({ time: '02:00' })
        .margin({ bottom: 40 })

      ControlButtons()
        .margin({ bottom: 18 })

      PreparationSteps()
        .margin({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(TeaColors.textSecondary)

        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Text('⚙')
          .fontSize(30)
          .fontColor(TeaColors.textPrimary)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(TeaColors.backgroundTint)
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
        LeafIcon()
          .width(34)
          .height(34)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor('#EFEBE9')

      Column({ space: 2 }) {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor(TeaColors.teaLeafDetail)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('♥')
        .fontSize(34)
        .fontColor(TeaColors.favoriteTint)
    }
    .width('100%')
    .height(100)
    .padding(20)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(TeaColors.surfaceVariant)
    .borderRadius(24)
    .border({ width: 1, color: TeaColors.outline })
  }
}

@Component
struct LeafIcon {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawLeaf(): void {
    const ctx = this.context
    const size = 34
    const center = size / 2

    ctx.clearRect(0, 0, size, size)
    ctx.strokeStyle = TeaColors.primary
    ctx.lineWidth = 2.6
    ctx.lineCap = 'round'

    ctx.beginPath()
    ctx.arc(center, center, 15, 0, Math.PI * 2)
    ctx.stroke()

    ctx.beginPath()
    ctx.moveTo(center, 9)
    ctx.lineTo(center, 25)
    ctx.stroke()
  }

  build() {
    Canvas(this.context)
      .width(34)
      .height(34)
      .onReady(() => {
        this.drawLeaf()
      })
  }
}

@Component
struct TimerDisplay {
  @Prop time: string

  build() {
    Stack() {
      TimerArc()
        .width(240)
        .height(240)

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
    }
    .width(240)
    .height(240)
  }
}

@Component
struct TimerArc {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawArc(): void {
    const ctx = this.context
    const size = 240
    const center = size / 2
    const radius = 104

    ctx.clearRect(0, 0, size, size)

    ctx.lineWidth = 12
    ctx.lineCap = 'round'

    ctx.strokeStyle = TeaColors.backgroundTint
    ctx.beginPath()
    ctx.arc(center, center, radius, 0, Math.PI * 2)
    ctx.stroke()

    ctx.strokeStyle = TeaColors.primary
    ctx.beginPath()
    const startAngle = -210 * Math.PI / 180
    const endAngle = startAngle + Math.PI * 2 * 0.66
    ctx.arc(center, center, radius, startAngle, endAngle)
    ctx.stroke()
  }

  build() {
    Canvas(this.context)
      .width(240)
      .height(240)
      .onReady(() => {
        this.drawArc()
      })
  }
}

@Component
struct ControlButtons {
  build() {
    Row({ space: 24 }) {
      Stack() {
        Text('↻')
          .fontSize(36)
          .fontColor('#8E8E93')
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0' })

      Row({ space: 8 }) {
        Text('▶')
          .fontSize(22)
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

      Stack() {
        Text('+')
          .fontSize(38)
          .fontColor('#8E8E93')
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0' })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
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
        .margin({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })

      Divider()
        .strokeWidth(1)
        .color(TeaColors.outline)

      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })

      Divider()
        .strokeWidth(1)
        .color(TeaColors.outline)

      StepItem({ step: '3', text: 'Pour water and wait for timer' })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StepItem {
  @Prop step: string
  @Prop text: string

  build() {
    Row({ space: 12 }) {
      Stack() {
        Text(this.step)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor(TeaColors.backgroundTint)

      Text(this.text)
        .fontSize(14)
        .fontColor('#8E8E93')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Blank()

      Text('✓')
        .fontSize(18)
        .fontColor(TeaColors.outline)
    }
    .width('100%')
    .height(40)
    .alignItems(VerticalAlign.Center)
  }
}