@Entry
@Component
struct Index {
  @State selectedPage: number = 1
  @State isSelected: boolean = false

  build() {
    Stack() {
      Column() {
        // Header Row
        Row({ space: 8 }) {
          Button() {
            Text('Back')
          }.buttonStyle(ButtonStyle.Capsule)

          Blank()

          Text('Document.pdf').fontColor('#FF1B1B1F').fontSize(18)

          Blank()

          Button() {
            Text('More')
          }
          .buttonStyle(ButtonStyle.Capsule)
          .clipShape(RoundedRectangle({ radius: 8 }))
          .backgroundColor('#FFA0C4FF')
        }
        .width('100%')
        .height(56)
        .padding(12)
        .backgroundColor('#FFFFFF')

        // Main Content Row
        Row({ space: 12 }) {
          // Left Grid (Thumbnails)
          Grid() {
            ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], (page: number) => {
              GridItem() {
                Button() {
                  Text(`P${page}`)
                    .textAlign(TextAlign.Center)
                    .width('100%')
                    .height('100%')
                    .backgroundColor(this.selectedPage === page ? '#FFEADDFF' : '#FFF0F0F5')
                    .borderRadius(8)
                }
                .onClick(() => {
                  this.selectedPage = page
                })
                .buttonStyle(ButtonStyle.Capsule)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .width(150)
          .layoutWeight(1)
          .padding(4)

          // Right Stack (Preview & Controls)
          Stack() {
            Text(`Page ${this.selectedPage}`)
              .fontColor('#FF1B1B1F')
              .fontSize(24)

            Column({ space: 8 }) {
              // Control Buttons
              Button() {
                Text('⬅')
                  .fontColor(this.isSelected ? '#FFFFFFFF' : '#FF1B1B1F')
                  .fontWeight(FontWeight.Bold)
                  .fontSize(17)
              }
              .type(ButtonType.Normal)
              .buttonStyle(ButtonStyle.Capsule)
              .clipShape(Circle())
              .backgroundColor(this.isSelected ? '#FFB7E4C7' : '#FFF0F0F5')
              .width(40)
              .height(40)
              .onClick(() => {
                this.isSelected = !this.isSelected
              })

              Button() {
                Text('➡')
                  .fontColor(this.isSelected ? '#FFFFFFFF' : '#FF1B1B1F')
                  .fontWeight(FontWeight.Bold)
                  .fontSize(17)
              }
              .type(ButtonType.Normal)
              .buttonStyle(ButtonStyle.Capsule)
              .clipShape(Circle())
              .backgroundColor(this.isSelected ? '#FFB7E4C7' : '#FFF0F0F5')
              .width(40)
              .height(40)
              .onClick(() => {
                this.isSelected = !this.isSelected
              })

              Button() {
                Text('🔍')
                  .fontColor(this.isSelected ? '#FFFFFFFF' : '#FF1B1B1F')
                  .fontWeight(FontWeight.Bold)
                  .fontSize(17)
              }
              .type(ButtonType.Normal)
              .buttonStyle(ButtonStyle.Capsule)
              .clipShape(Circle())
              .backgroundColor(this.isSelected ? '#FFB7E4C7' : '#FFF0F0F5')
              .width(40)
              .height(40)
              .onClick(() => {
                this.isSelected = !this.isSelected
              })

              Button() {
                Text('⚙️')
                  .fontColor(this.isSelected ? '#FFFFFFFF' : '#FF1B1B1F')
                  .fontWeight(FontWeight.Bold)
                  .fontSize(17)
              }
              .type(ButtonType.Normal)
              .buttonStyle(ButtonStyle.Capsule)
              .clipShape(Circle())
              .backgroundColor(this.isSelected ? '#FFB7E4C7' : '#FFF0F0F5')
              .width(40)
              .height(40)
              .onClick(() => {
                this.isSelected = !this.isSelected
              })
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.End)
            .width('100%')
            .height('100%')
            .padding(12)
            .backgroundColor('#CCFFFFFF') // Opacity equivalent
            .borderRadius(16)
          }
          .layoutWeight(2)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 12, right: 12 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
  }
}