const PAGE_BACKGROUND: string = '#FFF9FAFB';
const INK: string = '#FF111827';
const BORDER: string = '#FFD1D5DB';
const BLUE: string = '#FF60A5FA';
const INNER_BLUE: string = '#4D93C5FD';
const OUTER_BLUE: string = '#3393C5FD';

@Entry
@Component
struct FavoriteSpotsMap {
  build() {
    Column() {
      Column() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(INK)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor(PAGE_BACKGROUND)

      Column() {
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Circle()
              .width(720)
              .height(720)
              .fill(OUTER_BLUE)

            Circle()
              .width(480)
              .height(480)
              .fill(INNER_BLUE)

            Stack({ alignContent: Alignment.Center }) {
              Circle()
                .width(24)
                .height(24)
                .fill('#1F60A5FA')

              Circle()
                .width(8)
                .height(8)
                .fill(BLUE)
            }
            .width(24)
            .height(24)
            .offset({ x: -104, y: 0 })
          }
          .width('100%')
          .height(400)
          .borderRadius(24)
          .border({ width: 1, color: BORDER })
          .clip(true)
        }
        .width('calc(100% - 32vp)')
        .height(400)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F2F8FF')

        Column({ space: 16 }) {
          Text('Spot Coordinates: (200, 400)')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(INK)
            .textAlign(TextAlign.Center)
            .width('100%')

          Button('Save Marker', { type: ButtonType.Normal })
            .width('100%')
            .height(48)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .backgroundColor(BLUE)
            .borderRadius(16)
            .onClick(() => {})

          Column({ space: 12 }) {
            Text('Saved Markers')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(INK)

            ForEach([0, 1], (index: number) => {
              Row({ space: 16 }) {
                Circle()
                  .width(8)
                  .height(8)
                  .fill(BLUE)

                Text('Saved Marker')
                  .fontSize(14)
                  .fontColor(INK)

                Blank()
              }
              .width('100%')
              .height(20)
            }, (index: number) => index.toString())
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ top: 8 })
        }
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 24 })
      }
      .layoutWeight(1)
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .backgroundColor('#FCFCFE')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PAGE_BACKGROUND)
  }
}
