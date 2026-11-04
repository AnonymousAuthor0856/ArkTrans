class StepItem {
  number: string
  text: string

  constructor(number: string, text: string) {
    this.number = number
    this.text = text
  }
}

@Entry
@Component
struct Index {
  private steps: StepItem[] = [
    new StepItem('01', 'Sift 2g of matcha powder.'),
    new StepItem('02', "Add hot water. Whisk in 'M' shape.")
  ]

  build() {
    Column() {
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 48 })

      Column() {
        this.MatchaBowlVisual()
        Row() {
          this.InfoItem('TEMP', '80°C')
          this.InfoItem('WATER', '70ml')
          this.InfoItem('BAMBOO', 'Whisk')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 40 })
      }
      .alignItems(HorizontalAlign.Center)

      Column() {
        ForEach(this.steps, (step: StepItem) => {
          this.StepCard(step)
        })
        Button() {
          Row() {
            Text('▶')
              .fontSize(20)
              .fontColor(Color.White)
            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .margin({ left: 8 })
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .height(56)
        .borderRadius(28)
        .backgroundColor('#556B2F')
        .margin({ top: 32 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .margin({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
  }

  @Builder
  MatchaBowlVisual() {
    Stack({ alignContent: Alignment.Center }) {
      Rect()
        .width(112)
        .height(62)
        .radius(28)
        .fill('#333333')
        .margin({ top: 36 })
      Ellipse()
        .width(96)
        .height(24)
        .fill('#8BBD52')
        .margin({ top: 16 })
      Rect()
        .width(4)
        .height(28)
        .radius(2)
        .fill('rgba(211,211,211,0.5)')
        .margin({ bottom: 72, right: 32 })
      Rect()
        .width(4)
        .height(34)
        .radius(2)
        .fill('rgba(211,211,211,0.5)')
        .margin({ bottom: 84 })
      Rect()
        .width(4)
        .height(28)
        .radius(2)
        .fill('rgba(211,211,211,0.5)')
        .margin({ bottom: 72, left: 32 })
    }
    .width(160)
    .height(160)
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#D3D3D3')
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(step: StepItem) {
    Row() {
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill('#F5F5F5')
        Text(step.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      Text(step.text)
        .fontSize(14)
        .fontColor('#444444')
        .layoutWeight(1)
        .margin({ left: 16 })
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#EEEEEE', radius: 12 })
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 12 })
  }
}
