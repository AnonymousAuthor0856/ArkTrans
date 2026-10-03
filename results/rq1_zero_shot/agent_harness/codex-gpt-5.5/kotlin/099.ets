@Entry
@Component
struct MainActivity {
  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#C8C8C8')
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(number: string, textValue: string) {
    Row() {
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill('#F5F5F5')
        Text(number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width(32)
      .height(32)
      .margin({ right: 16 })

      Text(textValue)
        .fontSize(14)
        .fontColor('#444444')
        .layoutWeight(1)
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#EEEEEE', radius: 12 })
  }

  @Builder
  MatchaBowl() {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        Row() {
          Rect()
            .width(4)
            .height(32)
            .fill('#D8D8D8')
            .radius(2)
          Rect()
            .width(4)
            .height(44)
            .fill('#D8D8D8')
            .radius(2)
            .margin({ left: 20, right: 20 })
          Rect()
            .width(4)
            .height(32)
            .fill('#D8D8D8')
            .radius(2)
        }
        .justifyContent(FlexAlign.Center)
        .height(52)

        Stack({ alignContent: Alignment.Top }) {
          Ellipse()
            .width(120)
            .height(94)
            .fill('#333333')
            .margin({ top: 20 })
          Ellipse()
            .width(96)
            .height(24)
            .fill('#8BBD52')
            .margin({ top: 24 })
          Ellipse()
            .width(120)
            .height(28)
            .fill(Color.Transparent)
            .stroke('#222222')
            .strokeWidth(4)
            .margin({ top: 16 })
        }
        .width(160)
        .height(108)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(160)
    .height(160)
  }

  build() {
    Column() {
      Column() {
        Blank()
          .height(48)
        Text('MATCHA RITUAL')
          .fontSize(14)
          .letterSpacing(4)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)

      Column() {
        this.MatchaBowl()
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
      .justifyContent(FlexAlign.Center)

      Column() {
        this.StepCard('01', 'Sift 2g of matcha powder.')
        this.StepCard('02', "Add hot water. Whisk in 'M' shape.")
          .margin({ top: 12 })

        Button() {
          Row() {
            Text('▶')
              .fontSize(20)
              .fontColor('#FFFFFF')
            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#FFFFFF')
              .margin({ left: 8 })
          }
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .height(56)
        .backgroundColor('#556B2F')
        .borderRadius(28)
        .margin({ top: 32 })

        Blank()
          .height(24)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
  }
}
