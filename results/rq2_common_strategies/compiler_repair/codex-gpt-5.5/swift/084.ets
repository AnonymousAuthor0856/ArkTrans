class BrewColors {
  static white: string = '#FFFFFF'
  static black: string = '#000000'
  static gray: string = '#808080'
  static lightGray: string = '#E0E0E0'
  static systemGray6: string = '#F2F2F7'
}

class ParameterData {
  icon: string
  value: string
  label: string

  constructor(icon: string, value: string, label: string) {
    this.icon = icon
    this.value = value
    this.label = label
  }
}

@Entry
@Component
struct Index {
  private params: ParameterData[] = [
    new ParameterData('+', '1:15', 'Ratio'),
    new ParameterData('♥', '20g', 'Beans'),
    new ParameterData('↻', '93°C', 'Temp')
  ]

  @Builder
  HeaderSection() {
    Row() {
      Column({ space: 4 }) {
        Text('V60 Guide')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(BrewColors.black)
        Text('Ethiopia Yirgacheffe')
          .fontSize(16)
          .fontColor(BrewColors.gray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button('Gear')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(BrewColors.black)
        .backgroundColor('#00000000')
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 30, bottom: 30 })
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  TimerSection() {
    Column({ space: 10 }) {
      Text('00:45')
        .fontSize(90)
        .fontWeight(FontWeight.Regular)
        .fontColor(BrewColors.black)
        .maxLines(1)
      Text('Target: 300g')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(BrewColors.gray)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ParameterItem(item: ParameterData) {
    Column({ space: 12 }) {
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill('#00000000')
          .stroke(BrewColors.lightGray)
          .strokeWidth(1.5)
        Text(item.icon)
          .fontSize(24)
          .fontColor(BrewColors.gray)
      }
      .width(64)
      .height(64)

      Column({ space: 4 }) {
        Text(item.value)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(BrewColors.black)
        Text(item.label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor(BrewColors.gray)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(80)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ParametersGrid() {
    Row() {
      this.ParameterItem(this.params[0])
      Blank().layoutWeight(1)
      this.ParameterItem(this.params[1])
      Blank().layoutWeight(1)
      this.ParameterItem(this.params[2])
    }
    .width('100%')
    .padding({ left: 30, right: 30 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BrewingSteps() {
    Column({ space: 15 }) {
      Text('Brewing Steps')
        .fontSize(19)
        .fontWeight(FontWeight.Bold)
        .fontColor(BrewColors.black)
        .width('100%')
        .padding({ left: 24, right: 24 })

      Row({ space: 16 }) {
        Text('✓')
          .fontSize(28)
          .fontColor(BrewColors.black)
          .backgroundColor(BrewColors.white)
          .borderRadius(14)

        Rect()
          .height(52)
          .layoutWeight(1)
          .fill(BrewColors.systemGray6)
          .radius(10)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  StartButton() {
    Button('▶  Start Brewing')
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
      .fontColor(BrewColors.white)
      .width('100%')
      .height(60)
      .backgroundColor(BrewColors.black)
      .borderRadius(18)
  }

  build() {
    Column() {
      this.HeaderSection()

      Blank().layoutWeight(1)
      this.TimerSection()
      Blank().layoutWeight(1)
      this.ParametersGrid()
      Blank().layoutWeight(1)

      Rect()
        .width('100%')
        .height(1)
        .fill(BrewColors.lightGray)
        .margin({ left: 24, right: 24, bottom: 20 })

      this.BrewingSteps()

      Blank().layoutWeight(1)

      Column() {
        this.StartButton()
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BrewColors.white)
  }
}
