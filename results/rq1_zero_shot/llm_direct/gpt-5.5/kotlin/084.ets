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

@Component
struct StatItem {
  label: string = ''
  value: string = ''

  private getIcon(): string {
    if (this.label === 'Ratio') {
      return '+'
    }
    if (this.label === 'Beans') {
      return '♥'
    }
    return '↻'
  }

  build() {
    Column() {
      Stack() {
        Text(this.getIcon())
          .fontSize(20)
          .fontColor('#808080')
      }
      .width(48)
      .height(48)
      .border({
        width: 1,
        color: '#E0E0E0',
        radius: 24
      })

      Blank()
        .height(8)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)

      Text(this.label)
        .fontSize(11)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  number: number = 1
  step: BrewStep = new BrewStep('', '', '', '', false)

  build() {
    Row() {
      Column() {
        Stack() {
          if (this.step.isCompleted) {
            Text('✓')
              .fontSize(14)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
          } else {
            Text(this.number.toString())
              .fontSize(11)
              .fontColor(Color.White)
          }
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(this.step.isCompleted ? Color.Black : '#E0E0E0')

        Blank()
          .width(1)
          .height(60)
          .backgroundColor('#F0F0F0')
      }
      .alignItems(HorizontalAlign.Center)
      .padding({
        right: 16,
        top: 4
      })

      Column() {
        Row() {
          Text(this.step.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.step.isCompleted ? '#808080' : Color.Black)

          Text(this.step.waterTarget)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontFamily('monospace')
            .fontColor(this.step.isCompleted ? '#808080' : Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Blank()
          .height(4)

        Text(this.step.description)
          .fontSize(14)
          .fontColor('#808080')

        Blank()
          .height(8)

        Row() {
          Text(this.step.time)
            .fontSize(11)
            .fontColor('#808080')
        }
        .padding({
          left: 8,
          right: 8,
          top: 4,
          bottom: 4
        })
        .borderRadius(4)
        .backgroundColor('#F5F5F5')
      }
      .width('100%')
      .padding(16)
      .backgroundColor(this.step.isCompleted ? '#F8F8F8' : Color.White)
      .border({
        width: 1,
        color: this.step.isCompleted ? '#00000000' : '#EEEEEE',
        radius: 12
      })
      .borderRadius(12)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
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
            .fontColor(Color.Black)
            .letterSpacing(-0.5)

          Text('Ethiopia Yirgacheffe')
            .fontSize(14)
            .fontColor('#808080')
        }
        .alignItems(HorizontalAlign.Start)

        Button({ type: ButtonType.Circle }) {
          Text('⚙')
            .fontSize(24)
            .fontColor(Color.Black)
        }
        .width(48)
        .height(48)
        .backgroundColor('#00000000')
      }
      .width('100%')
      .padding({
        left: 24,
        right: 24,
        top: 48,
        bottom: 24
      })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Stack() {
          Column() {
            Text('00:45')
              .fontSize(80)
              .fontWeight(FontWeight.Lighter)
              .fontFamily('monospace')
              .fontColor(Color.Black)
              .letterSpacing(-2)

            Text('Target: 300g')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#808080')
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .padding({
          top: 24,
          bottom: 24
        })

        Row() {
          StatItem({
            label: 'Ratio',
            value: '1:15'
          })

          StatItem({
            label: 'Beans',
            value: '20g'
          })

          StatItem({
            label: 'Temp',
            value: '93°C'
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .padding({
          bottom: 32
        })

        Divider()
          .strokeWidth(1)
          .color('#F0F0F0')

        Blank()
          .height(24)

        Text('Brewing Steps')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width('100%')
          .padding({
            bottom: 16
          })

        List({ space: 16 }) {
          ForEach(this.steps, (step: BrewStep, index: number) => {
            ListItem() {
              StepCard({
                number: index + 1,
                step: step
              })
            }
          })

          ListItem() {
            Blank()
              .height(80)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: 24,
        right: 24
      })

      Stack() {
        Button({ type: ButtonType.Normal }) {
          Row() {
            Text('▶')
              .fontSize(22)
              .fontColor(Color.White)

            Blank()
              .width(8)

            Text('Start Brewing')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .height(64)
        .width('100%')
        .borderRadius(16)
        .backgroundColor(Color.Black)
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}