interface BrewStep {
  title: string
  description: string
  waterTarget: string
  time: string
  isCompleted: boolean
}

const brewSteps: BrewStep[] = [
  { title: 'Bloom', description: 'Wet the grounds evenly to release CO2.', waterTarget: '60g', time: '0:00 - 0:45', isCompleted: true },
  { title: 'First Pour', description: 'Pour slowly in concentric circles.', waterTarget: '180g', time: '0:45 - 1:30', isCompleted: false },
  { title: 'Second Pour', description: 'Gently pour remaining water.', waterTarget: '300g', time: '1:30 - 2:15', isCompleted: false },
  { title: 'Draw Down', description: 'Wait for the water to drain completely.', waterTarget: '300g', time: '2:15 - 3:00', isCompleted: false }
]

@Entry
@Component
struct Index {
  build() {
    Column() {
      Row() {
        Column() {
          Text('V60 Guide')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(-0.5)
            .fontColor('#000000')
          Text('Ethiopia Yirgacheffe')
            .fontSize(14)
            .fontColor('#888888')
        }
        Button({ type: ButtonType.Circle }) {
          Text('⚙').fontSize(24).fontColor('#000000')
        }
        .width(48).height(48)
        .backgroundColor('#00000000')
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
              .letterSpacing(-2)
              .fontColor('#000000')
            Text('Target: 300g')
              .fontSize(14)
              .fontColor('#888888')
          }
          .width('100%')
          .padding({ top: 24, bottom: 24 })
          .alignItems(HorizontalAlign.Center)

          Row() {
            StatItem({ label: 'Ratio', value: '1:15' })
            StatItem({ label: 'Beans', value: '20g' })
            StatItem({ label: 'Temp', value: '93°C' })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .margin({ bottom: 32 })

          Divider().color('#F0F0F0').strokeWidth(1)

          Blank().height(24)

          Text('Brewing Steps')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 16 })

          Column() {
            ForEach(brewSteps, (step: BrewStep, index: number) => {
              StepCard({
                number: index + 1,
                title: step.title,
                description: step.description,
                waterTarget: step.waterTarget,
                time: step.time,
                isCompleted: step.isCompleted
              })
            }, (step: BrewStep) => step.title)

            Blank().height(80)
          }
          .space(16)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        Button({ type: ButtonType.Normal }) {
          Row() {
            Text('▶').fontSize(20).fontColor('#FFFFFF')
            Blank().width(8)
            Text('Start Brewing')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
        }
        .width('100%')
        .height(64)
        .backgroundColor('#000000')
        .borderRadius(16)
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct StatItem {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column() {
      Stack() {
        Text(this.label == 'Ratio' ? '+' : (this.label == 'Beans' ? '♥' : '↻'))
          .fontSize(20)
          .fontColor('#888888')
      }
      .width(48).height(48)
      .border({ width: 1, color: '#E0E0E0', radius: 24 })
      .alignContent(Alignment.Center)

      Blank().height(8)

      Text(this.value)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .fontSize(16)

      Text(this.label)
        .fontSize(11)
        .fontColor('#888888')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  @Prop number: number = 0
  @Prop title: string = ''
  @Prop description: string = ''
  @Prop waterTarget: string = ''
  @Prop time: string = ''
  @Prop isCompleted: boolean = false

  build() {
    Row() {
      Column() {
        Stack() {
          if (this.isCompleted) {
            Text('✓').fontSize(14).fontColor('#FFFFFF')
          } else {
            Text(this.number.toString()).fontSize(11).fontColor('#FFFFFF')
          }
        }
        .width(24).height(24)
        .backgroundColor(this.isCompleted ? '#000000' : '#E0E0E0')
        .borderRadius(12)
        .alignContent(Alignment.Center)

        Stack() {}
          .width(1).height(60)
          .backgroundColor('#F0F0F0')
      }
      .alignItems(HorizontalAlign.Center)
      .padding({ right: 16, top: 4 })

      Column() {
        Row() {
          Text(this.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isCompleted ? '#888888' : '#000000')
          Text(this.waterTarget)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isCompleted ? '#888888' : '#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Blank().height(4)

        Text(this.description)
          .fontSize(14)
          .fontColor('#888888')

        Blank().height(8)

        Text(this.time)
          .fontSize(12)
          .fontColor('#888888')
          .backgroundColor('#F5F5F5')
          .borderRadius(4)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(this.isCompleted ? '#F8F8F8' : '#FFFFFF')
      .borderRadius(12)
      .border({ width: 1, color: this.isCompleted ? '#00000000' : '#EEEEEE' })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}
