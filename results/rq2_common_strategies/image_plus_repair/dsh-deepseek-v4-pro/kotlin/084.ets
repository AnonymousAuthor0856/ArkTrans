interface BrewStep {
  title: string;
  description: string;
  waterTarget: string;
  time: string;
  isCompleted: boolean;
}

@Entry
@Component
struct BrewingScreen {
  private steps: BrewStep[] = [
    { title: 'Bloom', description: 'Wet the grounds evenly to release CO2.', waterTarget: '60g', time: '0:00 - 0:45', isCompleted: true },
    { title: 'First Pour', description: 'Pour slowly in concentric circles.', waterTarget: '180g', time: '0:45 - 1:30', isCompleted: false },
    { title: 'Second Pour', description: 'Gently pour remaining water.', waterTarget: '300g', time: '1:30 - 2:15', isCompleted: false },
    { title: 'Draw Down', description: 'Wait for the water to drain completely.', waterTarget: '300g', time: '2:15 - 3:00', isCompleted: false }
  ];

  @Builder
  StatItem(label: string, value: string) {
    Column() {
      Column() {
        if (label === 'Ratio') {
          Text('+').fontSize(20).fontColor('#888888')
        } else if (label === 'Beans') {
          Text('♥').fontSize(20).fontColor('#888888')
        } else {
          Text('↻').fontSize(20).fontColor('#888888')
        }
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Blank().height(8)

      Text(value).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
      Text(label).fontSize(11).fontColor('#888888')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(num: number, step: BrewStep) {
    Row() {
      Column() {
        Column() {
          if (step.isCompleted) {
            Text('✓').fontSize(12).fontColor('#FFFFFF')
          } else {
            Text(num.toString()).fontSize(11).fontColor('#FFFFFF')
          }
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(step.isCompleted ? '#000000' : '#E0E0E0')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Column()
          .width(1)
          .height(60)
          .backgroundColor('#F0F0F0')
      }
      .alignItems(HorizontalAlign.Center)
      .padding({ right: 16, top: 4 })

      Column() {
        Row() {
          Text(step.title).fontSize(16).fontWeight(FontWeight.Bold).fontColor(step.isCompleted ? '#888888' : '#000000')
          Text(step.waterTarget).fontSize(14).fontWeight(FontWeight.Bold).fontFamily('monospace').fontColor(step.isCompleted ? '#888888' : '#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Blank().height(4)

        Text(step.description).fontSize(14).fontColor('#888888')

        Blank().height(8)

        Column() {
          Text(step.time).fontSize(11).fontColor('#888888')
        }
        .backgroundColor('#F5F5F5')
        .borderRadius(4)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .padding(16)
      .backgroundColor(step.isCompleted ? '#F8F8F8' : '#FFFFFF')
      .borderRadius(12)
      .border({ width: 1, color: step.isCompleted ? '#00000000' : '#EEEEEE' })
      .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

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
        }
        Button() {
          Text('⚙').fontSize(24).fontColor('#000000')
        }
        .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48, bottom: 48 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
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
              .fontColor('#888888')
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .padding({ top: 24, bottom: 24 })
        .alignItems(HorizontalAlign.Center)

        Row() {
          this.StatItem('Ratio', '1:15')
          this.StatItem('Beans', '20g')
          this.StatItem('Temp', '93°C')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .padding({ bottom: 32 })

        Row().width('100%').height(1).backgroundColor('#F0F0F0')

        Blank().height(24)

        Text('Brewing Steps')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .padding({ bottom: 16 })

        List({ space: 16 }) {
          ForEach(this.steps, (step: BrewStep, index: number) => {
            ListItem() {
              this.StepCard(index + 1, step)
            }
          }, (step: BrewStep) => step.title)

          ListItem() {
            Row().height(80).width('100%')
          }
        }
        .layoutWeight(1)
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 24, right: 24 })

      Column() {
        Button() {
          Row({ space: 8 }) {
            Text('▶').fontSize(20).fontColor('#FFFFFF')
            Text('Start Brewing').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
          }
        }
        .height(64)
        .width('100%')
        .backgroundColor('#000000')
        .borderRadius(16)
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
