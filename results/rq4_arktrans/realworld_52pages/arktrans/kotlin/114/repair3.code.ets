@Entry
@Component
struct Index {
  @State currentPage: number = 0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        // === LazyRow (List) ===
        List({ space: 0 }) {
          ListItem() {
            Stack({ alignContent: Alignment.Center }) {
              Column({ space: 0 }) {
                // === Icon (Arrow) ===
                Image($r('app.media.startIcon'))
                  .width(120)
                  .height(120)
                  .objectFit(ImageFit.Contain)
                  .opacity(0.3)

                // === Icon (Main Image) ===
                Image($r('app.media.startIcon'))
                  .width(48)
                  .height(48)
                  .objectFit(ImageFit.Contain)

                // === Spacer ===
                Blank().height(32)

                // === Text (Title) ===
                Text('Audio Recording')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.Center)
                  .fontColor('#000000')

                // === Spacer ===
                Blank().height(12)

                // === Text (Description) ===
                Text('Taking notes shouldn\'t be about typing or\nwriting alone.')
                  .fontSize(12)
                  .textAlign(TextAlign.Center)
                  .fontColor('#666666')
              }
              .alignItems(HorizontalAlign.Center)
              .width('100%')
              .height('100%')
              .padding({ left: 24, right: 24 })
            }.height('100%')
          }
        }
        .layoutWeight(1)
        .width('100%')

        // === Row (Dots) ===
        Row({ space: 8 }) {
          ForEach([0, 1, 2], (index: number) => {
            Stack({ alignContent: Alignment.Center }) {
              DotCircle({ widthValue: this.currentPage === index ? 12 : 10, heightValue: this.currentPage === index ? 12 : 10, color: this.currentPage === index ? '#B5838D' : '#AEBAB9' })
            }
          })
        }
        .justifyContent(FlexAlign.Center)
        .padding({ top: 16, bottom: 16 })

        // === Button ===
        Button() {
          Text('Get Started')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .backgroundColor('#DCA7B3')
        .borderRadius(12)
        .width('40%')
        .height(48)

        // === Spacer ===
        Blank().height(32)
      }
      .alignItems(HorizontalAlign.Center)
      .padding(16)
      .width('100%')
      .height('100%')
      .backgroundColor('#FFF0F5')
    }
    .width('100%')
    .height('100%')
  }
}

// Helper component for the dots to ensure valid ArkTS syntax without complex conditionals in modifiers
@Component
struct DotCircle {
  private widthValue: number = 10
  private heightValue: number = 10
  private color: ResourceColor = Color.Gray

  build() {
    Circle()
      .width(this.widthValue)
      .height(this.heightValue)
      .fill(this.color)
  }
}