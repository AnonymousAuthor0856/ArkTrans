@Entry
@Component
struct Index {
  build() {
    Column() {
      Column() {
        Blank().height(48)
        Text('MATCHA RITUAL')
          .fontSize(14)
          .letterSpacing(4)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
        Blank().height(8)
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Center)

      Column() {
        Blank()
        this.MatchaBowlCanvas()
        Blank().height(40)
        Row() {
          Blank()
          this.InfoItem('TEMP', '80°C')
          Blank()
          this.InfoItem('WATER', '70ml')
          Blank()
          this.InfoItem('BAMBOO', 'Whisk')
          Blank()
        }
        .width('100%')
        Blank()
      }
      .layoutWeight(1)
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      Column() {
        this.StepCard('01', 'Sift 2g of matcha powder.')
        Blank().height(12)
        this.StepCard('02', "Add hot water. Whisk in 'M' shape.")
        Blank().height(32)
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
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .height(56)
        .backgroundColor('#556B2F')
        .borderRadius(28)
        Blank().height(24)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }

  @Builder
  MatchaBowlCanvas() {
    Stack() {
      Rect()
        .width(112)
        .height(72)
        .radius(36)
        .fill('#333333')
        .offset({ y: 30 })
      Rect()
        .width(112)
        .height(34)
        .fill(Color.White)
        .offset({ y: 6 })
      Ellipse()
        .width(96)
        .height(24)
        .fill('#8BBD52')
        .offset({ y: 8 })
      Rect()
        .width(4)
        .height(24)
        .radius(2)
        .fill('#80808080')
        .offset({ x: -16, y: -38 })
      Rect()
        .width(4)
        .height(24)
        .radius(2)
        .fill('#80808080')
        .offset({ x: 0, y: -46 })
      Rect()
        .width(4)
        .height(24)
        .radius(2)
        .fill('#80808080')
        .offset({ x: 16, y: -38 })
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
        .fontColor('#80808080')
      Blank().height(4)
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(number: string, text: string) {
    Row() {
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill('#F5F5F5')
        Text(number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(32)
      .height(32)
      Text(text)
        .fontSize(14)
        .fontColor('#4D4D4D')
        .margin({ left: 16 })
        .layoutWeight(1)
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE' })
  }
}