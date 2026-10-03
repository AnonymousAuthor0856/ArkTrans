interface BrewStep {
  title: string
  description: string
  waterTarget: string
  time: string
  completed: boolean
}

@Entry
@Component
struct MainPage {
  @State private brewing: boolean = false
  @State private message: string = ''

  private steps: BrewStep[] = [
    {
      title: 'Bloom',
      description: 'Wet the grounds evenly to release CO2.',
      waterTarget: '60g',
      time: '0:00 - 0:45',
      completed: true
    },
    {
      title: 'First Pour',
      description: 'Pour slowly in concentric circles.',
      waterTarget: '180g',
      time: '0:45 - 1:30',
      completed: false
    },
    {
      title: 'Second Pour',
      description: 'Gently pour remaining water.',
      waterTarget: '300g',
      time: '1:30 - 2:15',
      completed: false
    },
    {
      title: 'Draw Down',
      description: 'Wait for the water to drain completely.',
      waterTarget: '300g',
      time: '2:15 - 3:00',
      completed: false
    }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          Row() {
            Column() {
              Text('V60 Guide')
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .lineHeight(38)
              Text('Ethiopia Yirgacheffe')
                .fontSize(18)
                .fontColor('#8B8B8B')
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()
              .layoutWeight(1)

            Button({ type: ButtonType.Circle }) {
              Text('⚙')
                .fontSize(27)
                .fontColor(Color.Black)
            }
            .width(50)
            .height(50)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.message = 'Settings'
            })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding({ top: 42, bottom: 20 })

          Column() {
            Text('00:45')
              .fontSize(80)
              .fontFamily('monospace')
              .fontWeight(FontWeight.Normal)
              .fontColor(Color.Black)
              .letterSpacing(-2)
              .lineHeight(92)
            Text('Target: 300g')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#898989')
              .margin({ top: 8 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({ top: 48, bottom: 46 })

          Row() {
            StatItem({ icon: '+', value: '1:15', label: 'Ratio' })
            StatItem({ icon: '♥', value: '20g', label: 'Beans' })
            StatItem({ icon: '⟳', value: '93°C', label: 'Temp' })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .padding({ bottom: 34 })

          Divider()
            .strokeWidth(1)
            .color('#EEEEEE')

          Text('Brewing Steps')
            .width('100%')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#202024')
            .margin({ top: 52, bottom: 28 })

          ForEach(this.steps, (step: BrewStep, index: number) => {
            StepCard({ number: index + 1, step: step })
          }, (step: BrewStep) => step.title)

          Blank().height(116)
        }
        .width('100%')
        .padding({ left: 48, right: 48 })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')

      Column() {
        if (this.message.length > 0) {
          Text(this.message)
            .fontSize(14)
            .fontColor(Color.White)
            .backgroundColor('#333333')
            .borderRadius(18)
            .padding({ left: 16, right: 16, top: 9, bottom: 9 })
            .margin({ bottom: 12 })
            .onClick(() => {
              this.message = ''
            })
        }

        Button({ type: ButtonType.Capsule }) {
          Text(this.brewing ? 'Brewing...' : '▶  Start Brewing')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .width('100%')
        .height(80)
        .backgroundColor(Color.Black)
        .borderRadius(28)
        .onClick(() => {
          this.brewing = !this.brewing
        })
      }
      .width('100%')
      .padding({ left: 48, right: 48, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct StatItem {
  @Prop icon: string
  @Prop value: string
  @Prop label: string

  build() {
    Column() {
      Button({ type: ButtonType.Circle }) {
        Text(this.icon)
          .fontSize(29)
          .fontColor('#8D8D8D')
      }
      .width(96)
      .height(96)
      .backgroundColor(Color.Transparent)
      .border({ width: 2, color: '#E1E1E1', radius: 48 })

      Text(this.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 18 })
      Text(this.label)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#898989')
        .margin({ top: 6 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  @Prop number: number
  @Prop step: BrewStep

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Row()
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor(this.step.completed ? Color.Black : '#E0E0E0')
          Text(this.step.completed ? '✓' : this.number.toString())
            .fontSize(this.step.completed ? 25 : 14)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
        .width(48)
        .height(48)

        Divider()
          .vertical(true)
          .height(54)
          .strokeWidth(1)
          .color('#EFEFEF')
      }
      .width(64)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Row() {
          Text(this.step.title)
            .fontSize(19)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.step.completed ? '#8B8B8B' : Color.Black)
          Blank().layoutWeight(1)
          Text(this.step.waterTarget)
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.step.completed ? '#8B8B8B' : Color.Black)
        }
        .width('100%')

        Text(this.step.description)
          .width('100%')
          .fontSize(15)
          .fontColor('#858585')
          .margin({ top: 8 })

        Text(this.step.time)
          .fontSize(13)
          .fontColor('#858585')
          .backgroundColor('#F3F3F3')
          .borderRadius(4)
          .padding({ left: 8, right: 8, top: 5, bottom: 5 })
          .margin({ top: 12 })
      }
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(this.step.completed ? '#F8F8F8' : Color.White)
      .border({
        width: this.step.completed ? 0 : 1,
        color: this.step.completed ? Color.Transparent : '#EEEEEE',
        radius: 12
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .margin({ bottom: 16 })
  }
}
