class BrewStep {
  title: string
  description: string
  waterTarget: string
  time: string
  isCompleted: boolean

  constructor(title: string, description: string, waterTarget: string, time: string, isCompleted: boolean = false) {
    this.title = title
    this.description = description
    this.waterTarget = waterTarget
    this.time = time
    this.isCompleted = isCompleted
  }
}

@Entry
@Component
struct BrewingScreen {
  private steps: BrewStep[] = [
    new BrewStep('Bloom', 'Wet the grounds evenly to release CO2.', '60g', '0:00 - 0:45', true),
    new BrewStep('First Pour', 'Pour slowly in concentric circles.', '180g', '0:45 - 1:30', false),
    new BrewStep('Second Pour', 'Gently pour remaining water.', '300g', '1:30 - 2:15', false),
    new BrewStep('Draw Down', 'Wait for the water to drain completely.', '300g', '2:15 - 3:00', false)
  ]

  build() {
    Column() {
      Row() {
        Column() {
          Text('V60 Guide')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .letterSpacing(-0.5)

          Text('Ethiopia Yirgacheffe')
            .fontSize(14)
            .fontColor('#888888')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        Text('⚙')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48, bottom: 48 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          Column() {
            Text('00:45')
              .fontSize(80)
              .fontWeight(FontWeight.Lighter)
              .fontFamily('monospace')
              .fontColor('#000000')
              .letterSpacing(-2)

            Text('Target: 300g')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#888888')
              .margin({ top: 4 })
          }
          .width('100%')
          .height(170)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          Row() {
            StatItem({ label: 'Ratio', value: '1:15' })
            StatItem({ label: 'Beans', value: '20g' })
            StatItem({ label: 'Temp', value: '93°C' })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .margin({ bottom: 32 })

          Divider()
            .width('100%')
            .height(1)
            .color('#F0F0F0')

          Text('Brewing Steps')
            .width('100%')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#222222')
            .margin({ top: 24, bottom: 16 })

          ForEach(this.steps, (step: BrewStep, index: number) => {
            StepCard({ number: index + 1, step: step })
              .margin({ bottom: 16 })
          }, (step: BrewStep, index: number) => `${index}-${step.title}`)

          Blank()
            .height(16)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)

      Column() {
        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Row() {
            Text('▶')
              .fontSize(22)
              .fontColor('#FFFFFF')
              .margin({ right: 12 })

            Text('Start Brewing')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(64)
        .borderRadius(16)
        .backgroundColor('#000000')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 16, bottom: 24 })
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct StatItem {
  label: string = ''
  value: string = ''

  private iconText(): string {
    if (this.label === 'Ratio') {
      return '+'
    }
    if (this.label === 'Beans') {
      return '♥'
    }
    return '⟳'
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.iconText())
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#888888')
      }
      .width(48)
      .height(48)
      .border({ width: 1, color: '#E0E0E0' })
      .borderRadius(24)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ top: 8 })

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#888888')
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  number: number = 0
  step: BrewStep = new BrewStep('', '', '', '')

  private containerColor(): string {
    return this.step.isCompleted ? '#F8F8F8' : '#FFFFFF'
  }

  private borderColor(): string {
    return this.step.isCompleted ? '#00000000' : '#EEEEEE'
  }

  private titleColor(): string {
    return this.step.isCompleted ? '#888888' : '#000000'
  }

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.Center }) {
          if (this.step.isCompleted) {
            Text('✓')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          } else {
            Text(this.number.toString())
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
        }
        .width(24)
        .height(24)
        .backgroundColor(this.step.isCompleted ? '#000000' : '#E0E0E0')
        .borderRadius(12)

        Blank()
          .width(1)
          .height(60)
          .backgroundColor('#F0F0F0')
      }
      .width(24)
      .alignItems(HorizontalAlign.Center)
      .margin({ right: 16, top: 4 })

      Column() {
        Row() {
          Text(this.step.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.titleColor())

          Text(this.step.waterTarget)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontFamily('monospace')
            .fontColor(this.step.isCompleted ? this.titleColor() : '#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Text(this.step.description)
          .fontSize(14)
          .fontColor('#888888')
          .margin({ top: 4 })

        Row() {
          Text(this.step.time)
            .fontSize(11)
            .fontColor('#888888')
        }
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor('#F5F5F5')
        .borderRadius(4)
        .margin({ top: 8 })
      }
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(this.containerColor())
      .border({ width: 1, color: this.borderColor() })
      .borderRadius(12)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}