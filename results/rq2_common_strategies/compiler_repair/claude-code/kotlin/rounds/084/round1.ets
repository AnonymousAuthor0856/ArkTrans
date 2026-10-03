@Entry
@Component
struct BrewingScreen {
  @State steps: BrewStep[] = [
    { title: 'Bloom', description: 'Wet the grounds evenly to release CO2.', waterTarget: '60g', time: '0:00 - 0:45', isCompleted: true },
    { title: 'First Pour', description: 'Pour slowly in concentric circles.', waterTarget: '180g', time: '0:45 - 1:30', isCompleted: false },
    { title: 'Second Pour', description: 'Gently pour remaining water.', waterTarget: '300g', time: '1:30 - 2:15', isCompleted: false },
    { title: 'Draw Down', description: 'Wait for the water to drain completely.', waterTarget: '300g', time: '2:15 - 3:00', isCompleted: false }
  ]

  build() {
    Stack() {
      Column() {
        // Top Bar
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
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Image($r('sys.media.ohos_ic_public_settings'))
              .width(24)
              .height(24)
              .fillColor('#000000')
          }
          .type(ButtonType.Circle)
          .width(40)
          .height(40)
          .backgroundColor(Color.Transparent)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 48, bottom: 16 })

        Scroll() {
          Column() {
            // Timer Display
            Column() {
              Text('00:45')
                .fontSize(80)
                .fontWeight(FontWeight.Lighter)
                .fontFamily('monospace')
                .fontColor('#000000')
                .letterSpacing(-2)
              Text('Target: 300g')
                .fontSize(14)
                .fontColor('#888888')
                .margin({ top: 4 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
            .padding({ top: 24, bottom: 24 })

            // Stats Row
            Row() {
              StatItem({ label: 'Ratio', value: '1:15', iconType: 0 })
              StatItem({ label: 'Beans', value: '20g', iconType: 1 })
              StatItem({ label: 'Temp', value: '93°C', iconType: 2 })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
            .padding({ bottom: 32 })

            Divider()
              .color('#F0F0F0')

            Text('Brewing Steps')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .width('100%')
              .padding({ top: 24, bottom: 16 })

            // Steps List
            Column() {
              ForEach(this.steps, (step: BrewStep, index: number) => {
                StepCard({ number: index + 1, step: step })
              }, (step: BrewStep, index: number) => index.toString())
            }
            .width('100%')

            // Bottom spacing for button
            Blank()
              .height(80)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      // Bottom Button
      Column() {
        Blank()
        Button() {
          Row() {
            Image($r('sys.media.ohos_ic_public_play'))
              .width(20)
              .height(20)
              .fillColor('#FFFFFF')
            Text('Start Brewing')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .margin({ left: 8 })
          }
        }
        .width('100%')
        .height(64)
        .backgroundColor('#000000')
        .borderRadius(16)
        .margin({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

interface BrewStep {
  title: string
  description: string
  waterTarget: string
  time: string
  isCompleted: boolean
}

@Component
struct StatItem {
  label: string = ''
  value: string = ''
  iconType: number = 0

  build() {
    Column() {
      // Circular icon container with border
      Stack() {
        this.getIcon()
          .width(20)
          .height(20)
          .fillColor('#888888')
      }
      .width(48)
      .height(48)
      .border({ width: 1, color: '#E0E0E0' })
      .borderRadius(24)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 8 })

      Text(this.label)
        .fontSize(12)
        .fontColor('#888888')
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  getIcon() {
    if (this.iconType === 0) {
      Image($r('sys.media.ohos_ic_public_add'))
    } else if (this.iconType === 1) {
      Image($r('sys.media.ohos_ic_public_favorite'))
    } else {
      Image($r('sys.media.ohos_ic_public_refresh'))
    }
  }
}

@Component
struct StepCard {
  number: number = 1
  step: BrewStep = { title: '', description: '', waterTarget: '', time: '', isCompleted: false }

  @Builder
  timelineIndicator() {
    if (this.step.isCompleted) {
      Image($r('sys.media.ohos_ic_public_yes'))
        .width(14)
        .height(14)
        .fillColor('#FFFFFF')
    } else {
      Text(this.number.toString())
        .fontSize(11)
        .fontColor('#FFFFFF')
    }
  }

  build() {
    Row() {
      // Timeline Indicator
      Column() {
        Stack() {
          this.timelineIndicator()
        }
        .width(24)
        .height(24)
        .backgroundColor(this.step.isCompleted ? '#000000' : '#E0E0E0')
        .borderRadius(12)

        // Vertical connecting line
        Row()
          .width(1)
          .height(60)
          .backgroundColor('#F0F0F0')
          .margin({ top: 2 })
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

          Blank()

          Text(this.step.waterTarget)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontFamily('monospace')
            .fontColor(this.step.isCompleted ? '#888888' : '#000000')
        }
        .width('100%')

        Text(this.step.description)
          .fontSize(14)
          .fontColor('#888888')
          .margin({ top: 4 })

        Text(this.step.time)
          .fontSize(12)
          .fontColor('#888888')
          .backgroundColor('#F5F5F5')
          .borderRadius(4)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .margin({ top: 8 })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(this.step.isCompleted ? '#F8F8F8' : '#FFFFFF')
      .borderRadius(12)
      .border({
        width: 1,
        color: this.step.isCompleted ? Color.Transparent : '#EEEEEE'
      })
      .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .margin({ bottom: 16 })
  }
}
