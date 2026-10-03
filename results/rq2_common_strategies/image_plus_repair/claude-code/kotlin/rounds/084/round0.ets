@Entry
@Component
struct BrewingScreen {
  @State steps: BrewStep[] = [
    new BrewStep('Bloom', 'Wet the grounds evenly to release CO2.', '60g', '0:00 - 0:45', true),
    new BrewStep('First Pour', 'Pour slowly in concentric circles.', '180g', '0:45 - 1:30', false),
    new BrewStep('Second Pour', 'Gently pour remaining water.', '300g', '1:30 - 2:15', false),
    new BrewStep('Draw Down', 'Wait for the water to drain completely.', '300g', '2:15 - 3:00', false)
  ]

  build() {
    Stack() {
      Column() {
        // Top Bar
        Row() {
          Column() {
            Text('V60 Guide')
              .fontSize(40)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Text('Ethiopia Yirgacheffe')
              .fontSize(18)
              .fontColor('#888888')
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)

          Image($r('sys.media.ohos_ic_public_settings'))
            .width(28)
            .height(28)
            .fillColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 24, right: 24, top: 48, bottom: 16 })

        Scroll() {
          Column() {
            // Timer Display
            Column() {
              Text('00:45')
                .fontSize(80)
                .fontWeight(FontWeight.Lighter)
                .fontColor('#000000')
                .letterSpacing(-2)
              Text('Target: 300g')
                .fontSize(16)
                .fontColor('#888888')
                .margin({ top: 8 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
            .padding({ top: 24, bottom: 24 })

            // Stats Row
            Row() {
              StatItem({ label: 'Ratio', value: '1:15', iconType: 'add' })
              StatItem({ label: 'Beans', value: '20g', iconType: 'heart' })
              StatItem({ label: 'Temp', value: '93°C', iconType: 'refresh' })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
            .padding({ bottom: 32 })

            // Divider
            Divider()
              .color('#F0F0F0')
              .strokeWidth(1)

            Text('Brewing Steps')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .width('100%')
              .textAlign(TextAlign.Start)
              .padding({ top: 24, bottom: 16, left: 0, right: 0 })

            // Steps List
            Column() {
              ForEach(this.steps, (step: BrewStep, index: number) => {
                StepCard({ number: index + 1, step: step })
              }, (step: BrewStep, index: number) => index.toString())
            }
            .width('100%')

            // Bottom spacer for button clearance
            Blank()
              .height(80)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      // Bottom Start Brewing Button
      Column() {
        Blank()
        Row() {
          Button() {
            Row() {
              Image($r('sys.media.ohos_ic_public_play'))
                .width(24)
                .height(24)
                .fillColor('#FFFFFF')
              Text('Start Brewing')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .margin({ left: 12 })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .height(64)
          .backgroundColor('#000000')
          .borderRadius(32)
          .shadow({ radius: 0 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24, top: 16 })
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

class BrewStep {
  title: string = ''
  description: string = ''
  waterTarget: string = ''
  time: string = ''
  isCompleted: boolean = false

  constructor(title: string, description: string, waterTarget: string, time: string, isCompleted: boolean) {
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
  iconType: string = ''

  build() {
    Column() {
      Circle({ width: 48, height: 48 }) {
        if (this.iconType === 'add') {
          Image($r('sys.media.ohos_ic_public_add'))
            .width(20)
            .height(20)
            .fillColor('#888888')
        } else if (this.iconType === 'heart') {
          Image($r('sys.media.ohos_ic_public_heart'))
            .width(20)
            .height(20)
            .fillColor('#888888')
        } else {
          Image($r('sys.media.ohos_ic_public_refresh'))
            .width(20)
            .height(20)
            .fillColor('#888888')
        }
      }
      .fill('#FFFFFF')
      .stroke('#E0E0E0')
      .strokeWidth(1)

      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ top: 12 })
      Text(this.label)
        .fontSize(14)
        .fontColor('#888888')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct StepCard {
  number: number = 0
  step: BrewStep = new BrewStep('', '', '', '', false)

  build() {
    Row() {
      // Timeline Indicator
      Column() {
        Circle({ width: 24, height: 24 }) {
          if (this.step.isCompleted) {
            Image($r('sys.media.ohos_ic_public_selected'))
              .width(14)
              .height(14)
              .fillColor('#FFFFFF')
          } else {
            Text(this.number.toString())
              .fontSize(12)
              .fontColor('#FFFFFF')
          }
        }
        .fill(this.step.isCompleted ? '#000000' : '#E0E0E0')

        // Vertical line
        Rect({ width: 1, height: 60 }) {
        }
        .fill('#F0F0F0')
        .margin({ top: 0 })
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ right: 16, top: 4 })

      // Content Card
      Column() {
        Row() {
          Text(this.step.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.step.isCompleted ? '#888888' : '#000000')
            .layoutWeight(1)
          Text(this.step.waterTarget)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Text(this.step.description)
          .fontSize(14)
          .fontColor('#888888')
          .margin({ top: 4 })

        // Time badge
        Text(this.step.time)
          .fontSize(12)
          .fontColor('#888888')
          .backgroundColor('#F5F5F5')
          .borderRadius(4)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .margin({ top: 8 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(this.step.isCompleted ? '#F8F8F8' : '#FFFFFF')
      .borderRadius(12)
      .border({
        width: 1,
        color: this.step.isCompleted ? 'rgba(0,0,0,0)' : '#EEEEEE'
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .margin({ bottom: 16 })
  }
}
