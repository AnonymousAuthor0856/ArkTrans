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

@Entry
@Component
struct BrewingScreen {
  private steps: BrewStep[] = [
    new BrewStep('Bloom', 'Wet the grounds evenly to release CO2.', '60g', '0:00 - 0:45', true),
    new BrewStep('First Pour', 'Pour slowly in concentric circles.', '180g', '0:45 - 1:30', false),
    new BrewStep('Second Pour', 'Gently pour remaining water.', '300g', '1:30 - 2:15', false),
    new BrewStep('Draw Down', 'Wait for the water to drain completely.', '300g', '2:15 - 3:00', false),
  ]

  @Builder
  StatItemBuilder(label: string, value: string, icon: string) {
    Column() {
      Column() {
        Text(icon)
          .fontSize(18)
          .fontColor('#888888')
      }
      .width(48)
      .height(48)
      .borderWidth(1)
      .borderColor('#E0E0E0')
      .borderRadius(24)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 8 })
      Text(label)
        .fontSize(11)
        .fontColor('#888888')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCardBuilder(number: number, step: BrewStep) {
    Row() {
      Column() {
        Column() {
          if (step.isCompleted) {
            Text('✓')
              .fontSize(14)
              .fontColor('#FFFFFF')
          } else {
            Text(`${number}`)
              .fontSize(11)
              .fontColor('#FFFFFF')
          }
        }
        .width(24)
        .height(24)
        .backgroundColor(step.isCompleted ? '#000000' : '#E0E0E0')
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Column() {}
          .width(1)
          .height(60)
          .backgroundColor('#F0F0F0')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ right: 16, top: 4 })

      Column() {
        Row() {
          Text(step.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(step.isCompleted ? '#888888' : '#000000')
            .layoutWeight(1)
          Text(step.waterTarget)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(step.isCompleted ? '#888888' : '#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Text(step.description)
          .fontSize(14)
          .fontColor('#888888')
          .margin({ top: 4 })

        Text(step.time)
          .fontSize(11)
          .fontColor('#888888')
          .backgroundColor('#F5F5F5')
          .borderRadius(4)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .margin({ top: 8 })
      }
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(step.isCompleted ? '#F8F8F8' : '#FFFFFF')
      .borderRadius(12)
      .borderWidth(step.isCompleted ? 0 : 1)
      .borderColor(step.isCompleted ? '#00000000' : '#EEEEEE')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  build() {
    Column() {
      Row() {
        Column() {
          Text('V60 Guide')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
          Text('Ethiopia Yirgacheffe')
            .fontSize(14)
            .fontColor('#888888')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text('⚙')
          .fontSize(22)
          .fontColor('#000000')
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48, bottom: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          Column() {
            Text('00:45')
              .fontSize(80)
              .fontWeight(FontWeight.Lighter)
              .fontColor('#000000')
            Text('Target: 300g')
              .fontSize(14)
              .fontColor('#888888')
              .margin({ top: 4 })
          }
          .width('100%')
          .padding({ top: 24, bottom: 24 })
          .alignItems(HorizontalAlign.Center)

          Row() {
            this.StatItemBuilder('Ratio', '1:15', '+')
            this.StatItemBuilder('Beans', '20g', '♥')
            this.StatItemBuilder('Temp', '93°C', '↻')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .padding({ bottom: 32 })

          Column() {}
            .width('100%')
            .height(1)
            .backgroundColor('#F0F0F0')

          Text('Brewing Steps')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ top: 24, bottom: 16 })

          ForEach(this.steps, (step: BrewStep, index: number) => {
            this.StepCardBuilder(index + 1, step)
          }, (step: BrewStep) => step.title)
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 80 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Button('Start Brewing') {
        Row() {
          Text('▶')
            .fontSize(18)
            .fontColor('#FFFFFF')
          Text('Start Brewing')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
      }
        .type(ButtonType.Normal)
        .backgroundColor('#000000')
        .borderRadius(16)
        .width('100%')
        .height(64)
        .margin({ left: 24, right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}