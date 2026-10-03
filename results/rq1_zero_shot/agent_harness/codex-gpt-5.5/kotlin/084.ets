class BrewStep {
  title: string;
  description: string;
  waterTarget: string;
  time: string;
  completed: boolean;

  constructor(title: string, description: string, waterTarget: string, time: string, completed: boolean) {
    this.title = title;
    this.description = description;
    this.waterTarget = waterTarget;
    this.time = time;
    this.completed = completed;
  }
}

@Entry
@Component
struct MainActivity {
  private steps: BrewStep[] = [
    new BrewStep('Bloom', 'Wet the grounds evenly to release CO2.', '60g', '0:00 - 0:45', true),
    new BrewStep('First Pour', 'Pour slowly in concentric circles.', '180g', '0:45 - 1:30', false),
    new BrewStep('Second Pour', 'Gently pour remaining water.', '300g', '1:30 - 2:15', false),
    new BrewStep('Draw Down', 'Wait for the water to drain completely.', '300g', '2:15 - 3:00', false)
  ];

  @Builder
  TopBar() {
    Row() {
      Column() {
        Text('V60 Guide')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Ethiopia Yirgacheffe')
          .fontSize(14)
          .fontColor('#808080')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Text('⚙')
        .fontSize(24)
        .fontColor('#000000')
        .width(44)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 48, bottom: 48 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  StatItem(label: string, value: string, icon: string) {
    Column() {
      Text(icon)
        .fontSize(20)
        .fontColor('#808080')
        .textAlign(TextAlign.Center)
        .width(48)
        .height(48)
        .lineHeight(48)
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(24)
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#000000')
        .margin({ top: 8 })
      Text(label)
        .fontSize(11)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(number: number, step: BrewStep) {
    Row() {
      Column() {
        Text(step.completed ? '✓' : `${number}`)
          .fontSize(12)
          .fontColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .width(24)
          .height(24)
          .lineHeight(24)
          .backgroundColor(step.completed ? '#000000' : '#E0E0E0')
          .borderRadius(12)
        Blank()
          .width(1)
          .height(60)
          .backgroundColor('#F0F0F0')
      }
      .padding({ top: 4, right: 16 })
      .alignItems(HorizontalAlign.Center)

      Column() {
        Row() {
          Text(step.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(step.completed ? '#808080' : '#000000')
          Text(step.waterTarget)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontFamily('monospace')
            .fontColor(step.completed ? '#808080' : '#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Text(step.description)
          .fontSize(14)
          .fontColor('#808080')
          .width('100%')
          .margin({ top: 4 })

        Text(step.time)
          .fontSize(11)
          .fontColor('#808080')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor('#F5F5F5')
          .borderRadius(4)
          .margin({ top: 8 })
      }
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(step.completed ? '#F8F8F8' : '#FFFFFF')
      .borderRadius(12)
      .border({ width: 1, color: step.completed ? Color.Transparent : '#EEEEEE' })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  BottomBar() {
    Button('▶  Start Brewing')
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .fontColor('#FFFFFF')
      .width('100%')
      .height(64)
      .backgroundColor('#000000')
      .borderRadius(16)
      .margin(24)
  }

  build() {
    Column() {
      this.TopBar()
      Column() {
        Column() {
          Text('00:45')
            .fontSize(80)
            .fontWeight(FontWeight.Light)
            .fontFamily('monospace')
            .fontColor('#000000')
          Text('Target: 300g')
            .fontSize(12)
            .fontColor('#808080')
        }
        .width('100%')
        .padding({ top: 24, bottom: 24 })
        .alignItems(HorizontalAlign.Center)

        Row() {
          this.StatItem('Ratio', '1:15', '+')
          this.StatItem('Beans', '20g', '♥')
          this.StatItem('Temp', '93°C', '↻')
        }
        .width('100%')
        .padding({ bottom: 32 })
        .justifyContent(FlexAlign.SpaceEvenly)

        Divider().color('#F0F0F0')
        Text('Brewing Steps')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .width('100%')
          .margin({ top: 24, bottom: 16 })

        Scroll() {
          Column({ space: 16 }) {
            ForEach(this.steps, (step: BrewStep, index: number) => {
              this.StepCard(index + 1, step)
            })
            Blank().height(80)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 24, right: 24 })

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
