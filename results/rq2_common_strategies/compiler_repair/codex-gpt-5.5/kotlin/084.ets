class BrewStep {
  title: string
  description: string
  waterTarget: string
  time: string
  completed: boolean

  constructor(title: string, description: string, waterTarget: string, time: string, completed: boolean) {
    this.title = title
    this.description = description
    this.waterTarget = waterTarget
    this.time = time
    this.completed = completed
  }
}

@Entry
@Component
struct Index {
  private steps: BrewStep[] = [
    new BrewStep('Bloom', 'Wet the grounds evenly to release CO2.', '60g', '0:00 - 0:45', true),
    new BrewStep('First Pour', 'Pour slowly in concentric circles.', '180g', '0:45 - 1:30', false),
    new BrewStep('Second Pour', 'Gently pour remaining water.', '300g', '1:30 - 2:15', false),
    new BrewStep('Draw Down', 'Wait for the water to drain completely.', '300g', '2:15 - 3:00', false)
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column() {
            Column() {
              Text('00:45')
                .fontSize(80)
                .fontWeight(FontWeight.Lighter)
                .fontFamily('monospace')
                .fontColor(Color.Black)
              Text('Target: 300g')
                .fontSize(14)
                .fontColor(Color.Gray)
                .margin({ top: 4 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
            .padding({ top: 24, bottom: 24 })

            Row() {
              this.StatItem('Ratio', '1:15', '+')
              this.StatItem('Beans', '20g', '♥')
              this.StatItem('Temp', '93°C', '↻')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
            .margin({ bottom: 32 })

            Divider()
              .color('#F0F0F0')
            Text('Brewing Steps')
              .width('100%')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 24, bottom: 16 })

            ForEach(this.steps, (step: BrewStep, index: number) => {
              this.StepCard(index + 1, step)
            })
          }
          .width('100%')
          .padding({ left: 24, right: 24, bottom: 104 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      Button() {
        Row() {
          Text('▶')
            .fontSize(22)
            .fontColor(Color.White)
          Text('Start Brewing')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .margin({ left: 8 })
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .height(64)
      .width('100%')
      .borderRadius(16)
      .backgroundColor(Color.Black)
      .margin({ left: 24, right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  TopBar() {
    Row() {
      Column() {
        Text('V60 Guide')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Ethiopia Yirgacheffe')
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('⚙')
        .fontSize(24)
        .fontColor(Color.Black)
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .padding(0)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 48, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  StatItem(label: string, value: string, icon: string) {
    Column() {
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(Color.Transparent)
          .stroke('#E0E0E0')
          .strokeWidth(1)
        Text(icon)
          .fontSize(20)
          .fontColor(Color.Gray)
      }
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 8 })
      Text(label)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(number: number, step: BrewStep) {
    Row() {
      Column() {
        Stack() {
          Circle()
            .width(24)
            .height(24)
            .fill(step.completed ? Color.Black : '#E0E0E0')
          Text(step.completed ? '✓' : number.toString())
            .fontSize(step.completed ? 14 : 12)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
        Rect()
          .width(1)
          .height(60)
          .fill('#F0F0F0')
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ right: 16, top: 4 })

      Column() {
        Row() {
          Text(step.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(step.completed ? Color.Gray : Color.Black)
          Text(step.waterTarget)
            .fontSize(14)
            .fontFamily('monospace')
            .fontWeight(FontWeight.Bold)
            .fontColor(step.completed ? Color.Gray : Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        Text(step.description)
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
        Text(step.time)
          .fontSize(12)
          .fontColor(Color.Gray)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(4)
          .backgroundColor('#F5F5F5')
          .margin({ top: 8 })
      }
      .layoutWeight(1)
      .padding(16)
      .border({ width: 1, color: step.completed ? Color.Transparent : '#EEEEEE', radius: 12 })
      .backgroundColor(step.completed ? '#F8F8F8' : Color.White)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .margin({ bottom: 16 })
  }
}
