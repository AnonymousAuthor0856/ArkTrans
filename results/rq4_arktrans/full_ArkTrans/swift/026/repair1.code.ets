@Entry
@Component
struct Index {
  @State scrollOffset: number = 0

  build() {
    Stack() {
      Column() {
        Text('Glass Doc Reader')
          .backgroundColor('#F1F5F9')
          .width('100%')
          .padding({ top: 20, bottom: 12 })
          .fontColor('#1E1E1E')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)

        Stack() {
          // Background Gradient
          Column()
            .width('100%')
            .height('100%')
            .linearGradient({
              angle: 180,
              colors: [['#E2E8F0', 0], ['#F1F5F9', 0.5], ['#E2E8F0', 1]]
            })

          // Glass Card Content
          Column() {
            Text('Document Reader')
              .fontColor('#38BDF8')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
            
            ForEach(this.generateArray(8), (index: number) => {
              Text(`This is a sample line of text content number ${index + 1}.`)
                .fontColor('#1E1E1E')
                .fontSize(14)
                .margin({ bottom: 12 })
            })

            Blank()
          }
          .width('90%')
          .height('70%')
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
          .shadow({ radius: 20, color: '#1A000000', offsetY: 10 })
          .padding(24)
          .alignItems(HorizontalAlign.Start)
          .translate({ y: this.scrollOffset / 5 })
          .gesture(
            PanGesture()
              .onActionEnd((event: GestureEvent) => {
                if (event && event.offsetY) {
                  this.scrollOffset += event.offsetY
                }
              })
          )
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  private generateArray(length: number): number[] {
    const arr: number[] = [];
    for (let i = 0; i < length; i++) {
      arr.push(i);
    }
    return arr;
  }
}