@Entry
@Component
struct TeaBrewingScreen {
  build() {
    Column() {
      HeaderSection()

      TeaSelectionCard()
        .margin({ top: 32 })

      TimerDisplay()
        .margin({ top: 32 })

      ControlButtons()
        .margin({ top: 40 })

      Column() {
        PreparationSteps()
      }
      .layoutWeight(1)
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(16)
          .fontColor('#9E9E9E')
        Text('Tea Master')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Text('⚙')
        .fontSize(28)
        .fontColor(Color.Black)
        .width(48)
        .height(48)
        .textAlign(TextAlign.Center)
        .backgroundColor('#F5F5F5')
        .borderRadius(24)
    }
    .width('100%')
    .height(48)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Row() {
      CanvasTeaIcon()

      Column() {
        Text('Earl Grey Reserve')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Black Tea • 95°C')
          .fontSize(16)
          .fontColor('#8D6E63')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Text('♥')
        .fontSize(28)
        .fontColor('#FFCDD2')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct CanvasTeaIcon {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToAppear() {
    const iconSize = 30
    const cx = iconSize / 2
    const cy = iconSize / 2
    const r = iconSize / 2 - 1

    this.context.strokeStyle = '#6D4C41'
    this.context.lineWidth = 2
    this.context.beginPath()
    this.context.arc(cx, cy, r, 0, Math.PI * 2)
    this.context.stroke()

    this.context.lineCap = 'round'
    this.context.beginPath()
    this.context.moveTo(cx, cy - r * 0.5)
    this.context.lineTo(cx, cy + r * 0.5)
    this.context.stroke()
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width(30)
        .height(30)
    }
    .width(60)
    .height(60)
    .backgroundColor('#EFEBE9')
    .borderRadius(30)
    .alignContent(Alignment.Center)
  }
}

@Component
struct TimerDisplay {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private ringSize: number = 220

  aboutToAppear() {
    const s = this.ringSize
    const cx = s / 2
    const cy = s / 2
    const r = s / 2 - 6

    this.context.strokeStyle = '#F5F5F5'
    this.context.lineWidth = 12
    this.context.beginPath()
    this.context.arc(cx, cy, r, 0, Math.PI * 2)
    this.context.stroke()

    this.context.strokeStyle = '#6D4C41'
    this.context.lineWidth = 12
    this.context.lineCap = 'round'
    this.context.beginPath()
    this.context.arc(cx, cy, r, -Math.PI / 2, -Math.PI / 2 + (240 * Math.PI / 180))
    this.context.stroke()
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width(this.ringSize)
        .height(this.ringSize)

      Column() {
        Text('Steeping')
          .fontSize(14)
          .fontColor('#9E9E9E')
          .letterSpacing(2)
        Text('02:00')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(this.ringSize)
    .height(this.ringSize)
    .alignContent(Alignment.Center)
  }
}

@Component
struct ControlButtons {
  build() {
    Row() {
      CircleButton({icon: '↻'})

      Button() {
        Row() {
          Text('▶')
            .fontSize(20)
            .fontColor(Color.White)
          Text('Start')
            .fontSize(18)
            .fontColor(Color.White)
            .margin({ left: 8 })
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor('#6D4C41')
      .margin({ left: 24, right: 24 })

      CircleButton({icon: '+'})
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct CircleButton {
  @Prop icon: string = ''

  build() {
    Button() {
      Text(this.icon)
        .fontSize(22)
        .fontColor('#9E9E9E')
    }
    .width(60)
    .height(60)
    .borderRadius(30)
    .backgroundColor(Color.White)
    .border({ width: 1, color: '#E0E0E0' })
  }
}

@Component
struct PreparationSteps {
  build() {
    Column() {
      Text('PREPARATION')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#E0E0E0')
        .margin({ bottom: 12 })

      StepItem({step: '1', content: 'Boil fresh water to 95°C', completed: true})
      StepItem({step: '2', content: 'Add 1 tsp of loose leaf per cup', completed: false})
      StepItem({step: '3', content: 'Pour water and wait for timer', completed: false})
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StepItem {
  @Prop step: string = ''
  @Prop content: string = ''
  @Prop completed: boolean = false

  build() {
    Column() {
      Row() {
        Text(this.step)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width(24)
          .height(24)
          .textAlign(TextAlign.Center)
          .backgroundColor('#F5F5F5')
          .borderRadius(12)

        Text(this.content)
          .fontSize(16)
          .fontColor(this.completed ? '#424242' : '#757575')
          .margin({ left: 12 })
          .layoutWeight(1)

        Text('✓')
          .fontSize(14)
          .fontColor(this.completed ? '#6D4C41' : '#EEEEEE')
      }
      .width('100%')
      .height(40)
      .alignItems(VerticalAlign.Center)

      Divider()
        .color('#FAFAFA')
        .strokeWidth(1)
    }
    .width('100%')
  }
}
