@Entry
@Component
struct Index {
  build() {
    Column() {
      this.HeaderSection()

      Blank()
        .height(32)

      this.TeaSelectionCard()

      Blank()
        .height(32)

      TimerRing({ time: '02:00' })

      Blank()
        .height(40)

      this.ControlButtons()

      Blank()
        .layoutWeight(1)

      this.PreparationSteps()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(15)
          .fontColor('#808080')
          .fontWeight(FontWeight.Regular)

        Text('Tea Master')
          .fontSize(28)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Stack({ alignContent: Alignment.Center }) {
        Text('⚙')
          .fontSize(30)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .onClick(() => {
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TeaSelectionCard() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        TeaLeafIcon()
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor('#EFEBE9')

      Blank()
        .width(16)

      Column() {
        Text('Earl Grey Reserve')
          .fontSize(20)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)

        Text('Black Tea • 95°C')
          .fontSize(14)
          .fontColor('#8D6E63')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text('❤')
        .fontSize(30)
        .fontColor('#FFCDD2')
    }
    .width('100%')
    .height(100)
    .padding(20)
    .borderRadius(24)
    .border({
      width: 1,
      color: '#EEEEEE'
    })
    .backgroundColor('#FAFAFA')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ControlButtons() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text('↻')
          .fontSize(34)
          .fontColor('#808080')
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .border({
        width: 1,
        color: '#E0E0E0'
      })
      .backgroundColor('#FFFFFF')
      .onClick(() => {
      })

      Blank()
        .width(24)

      Row() {
        Text('▶')
          .fontSize(24)
          .fontColor('#FFFFFF')
          .margin({ right: 10 })

        Text('Start')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor('#6D4C41')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .onClick(() => {
      })

      Blank()
        .width(24)

      Stack({ alignContent: Alignment.Center }) {
        Text('+')
          .fontSize(34)
          .fontColor('#808080')
          .fontWeight(FontWeight.Regular)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .border({
        width: 1,
        color: '#E0E0E0'
      })
      .backgroundColor('#FFFFFF')
      .onClick(() => {
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  PreparationSteps() {
    Column() {
      Text('PREPARATION')
        .fontSize(12)
        .fontColor('#CFCFCF')
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 12 })

      StepItem({ step: '1', label: 'Boil fresh water to 95°C' })
      StepItem({ step: '2', label: 'Add 1 tsp of loose leaf per cup' })
      StepItem({ step: '3', label: 'Pour water and wait for timer' })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct TeaLeafIcon {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawLeaf(): void {
    this.context.clearRect(0, 0, 30, 30)

    this.context.strokeStyle = '#6D4C41'
    this.context.lineWidth = 2
    this.context.lineCap = 'round'

    this.context.beginPath()
    this.context.arc(15, 15, 14, 0, Math.PI * 2)
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
        this.drawLeaf()
      })
  }
}

@Component
struct TimerRing {
  time: string = '02:00'

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawRing(): void {
    const center: number = 110
    const radius: number = 100
    const start: number = -Math.PI / 2
    const end: number = start + Math.PI * 240 / 180

    this.context.clearRect(0, 0, 220, 220)

    this.context.lineWidth = 12
    this.context.lineCap = 'round'

    this.context.strokeStyle = '#F5F5F5'
    this.context.beginPath()
    this.context.arc(center, center, radius, 0, Math.PI * 2)
    this.context.stroke()

    this.context.strokeStyle = '#6D4C41'
    this.context.beginPath()
    this.context.arc(center, center, radius, start, end)
    this.context.stroke()
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width(220)
        .height(220)
        .onReady(() => {
          this.drawRing()
        })

      Column() {
        Text('Steeping')
          .fontSize(14)
          .fontColor('#8E8E8E')
          .fontWeight(FontWeight.Medium)
          .letterSpacing(2)

        Text(this.time)
          .fontSize(54)
          .fontColor('#000000')
          .fontWeight(FontWeight.Lighter)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
  }
}

@Component
struct StepItem {
  step: string = ''
  label: string = ''

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Text(this.step)
            .fontSize(12)
            .fontColor('#000000')
            .fontWeight(FontWeight.Bold)
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor('#F5F5F5')

        Blank()
          .width(12)

        Text(this.label)
          .fontSize(16)
          .fontColor('#444444')
          .layoutWeight(1)

        Text('✓')
          .fontSize(18)
          .fontColor('#EEEEEE')
      }
      .width('100%')
      .height(40)
      .alignItems(VerticalAlign.Center)

      Divider()
        .width('100%')
        .height(1)
        .color('#FAFAFA')
    }
    .width('100%')
  }
}