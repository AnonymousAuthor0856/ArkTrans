@Entry
@Component
struct Index {
  @State paymentProgress: number = 0

  build() {
    Stack() {
      Column() {
        Text('Installment Plan')
          .backgroundColor('#FFFBF2')
          .height(64)
          .width('100%')
          .fontColor('#1E1E1E')
          .fontSize(28)

        Column() {
          Stack() {
            Rect()
              .height(240)
              .shadow({ radius: 4, color: '#33000000', offsetX: 0, offsetY: 2 })
              .fill(Color.White)
            
            Canvas(this)
              .height(240)
              .padding(12)
          }
          .width('100%')

          Text('Payment Progress')
            .fontColor('#FFA500')
            .fontSize(18)

          Stack()
            .alignContent(Alignment.Start)

          CustomSlider({ value: this.paymentProgress })
            .width('100%')

          Button()
            .type(ButtonType.Normal)
            .borderRadius(8)
            .backgroundColor('#FFE066')
            .height(48)
            .onClick(() => {
              this.paymentProgress = 0
            })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(12)
        .background(new LinearGradient({ angle: 180, colors: [['#FFFFFF', 0], ['#F0F0F0', 1]] }))
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFBF2')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct CustomSlider {
  private controller: CanvasRenderingContext2D = new CanvasRenderingContext2D()
  @Link value: number

  build() {
    Slider({ value: this.value, min: 0, max: 100, step: 1 })
      .width('100%')
      .trackColor('#E0E0E0')
      .selectedColor('#FFA500')
      .blockColor('#FFE066')
  }
}