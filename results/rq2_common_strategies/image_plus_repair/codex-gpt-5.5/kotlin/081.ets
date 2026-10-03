@Entry
@Component
struct FurnitureDetailScreen {
  @State private isFavorite: boolean = false
  @State private selectedColor: number = 0

  build() {
    Column() {
      this.headerBar()

      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Text('🛒')
            .fontSize(76)
            .fontColor('#BDBDBD')
        }
        .width('100%')
        .height(600)
        .backgroundColor('#F5F5F5')
        .borderRadius(32)

        Column() {
          Row() {
            Column() {
              Text('Modern Lounge')
                .fontSize(52)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .lineHeight(64)
              Text('Chair')
                .fontSize(52)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .lineHeight(64)
                .margin({ top: 0 })
              Text('Minimalist Series')
                .fontSize(32)
                .fontColor('#8A8A8A')
                .margin({ top: 24 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Text('$1299')
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 2 })
          }
          .alignItems(VerticalAlign.Top)
          .width('100%')

          Row() {
            Text('★')
              .fontSize(38)
              .fontColor('#FFC107')
            Text('4.8')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ left: 12 })
            Text('(238 Reviews)')
              .fontSize(28)
              .fontColor('#8A8A8A')
              .margin({ left: 18 })
          }
          .alignItems(VerticalAlign.Center)
          .margin({ top: 54 })
          .width('100%')

          Text('Colors')
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .alignSelf(ItemAlign.Start)
            .margin({ top: 58 })

          Row({ space: 24 }) {
            this.colorSelector('#212121', 0)
            this.colorSelector('#795548', 1)
            this.colorSelector('#9E9E9E', 2)
          }
          .margin({ top: 20 })
          .alignSelf(ItemAlign.Start)

          Row({ space: 16 }) {
            Button('Add to Cart')
              .layoutWeight(1)
              .height(112)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .backgroundColor(Color.Black)
              .borderRadius(16)
              .onClick(() => {
                // The original action is intentionally a no-op.
              })

            Button(this.isFavorite ? '♥' : '♡')
              .width(112)
              .height(112)
              .fontSize(48)
              .fontColor(Color.Black)
              .backgroundColor('#F5F5F5')
              .borderRadius(16)
              .onClick(() => {
                this.isFavorite = !this.isFavorite
              })
          }
          .width('100%')
          .margin({ top: 64, bottom: 40 })
        }
        .width('100%')
        .margin({ top: 64 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 48, right: 48, top: 48 })
    .backgroundColor(Color.White)
  }

  @Builder
  headerBar() {
    Row() {
      Button('←')
        .width(96)
        .height(96)
        .fontSize(58)
        .fontColor(Color.Black)
        .backgroundColor(Color.White)
        .border({
          width: 2,
          color: '#E0E0E0',
          radius: 48
        })
        .padding(0)
        .onClick(() => {
          // The original action is intentionally a no-op.
        })

      Text('Details')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Button(this.isFavorite ? '♥' : '♡')
        .width(96)
        .height(96)
        .fontSize(56)
        .fontColor(Color.Black)
        .backgroundColor(Color.White)
        .border({
          width: 2,
          color: '#E0E0E0',
          radius: 48
        })
        .padding(0)
        .onClick(() => {
          this.isFavorite = !this.isFavorite
        })
    }
    .width('100%')
    .height(96)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  colorSelector(color: string, index: number) {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(64)
        .height(64)
        .fill(color)
        .border({
          width: this.selectedColor === index ? 4 : 0,
          color: '#D0D0D0'
        })
        .onClick(() => {
          this.selectedColor = index
        })

      if (this.selectedColor === index) {
        Circle()
          .width(20)
          .height(20)
          .fill(Color.White)
      }
    }
    .width(64)
    .height(64)
  }
}
