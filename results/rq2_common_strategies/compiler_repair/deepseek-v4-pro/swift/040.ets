@Entry
@Component
struct RootScreen {
  @State query: string = ""
  private results: ResultItem[] = [
    { id: 1, title: "Result 1" },
    { id: 2, title: "Result 2" },
    { id: 3, title: "Result 3" },
    { id: 4, title: "Result 4" },
    { id: 5, title: "Result 5" },
    { id: 6, title: "Result 6" }
  ]

  build() {
    Stack() {
      Column({ space: 12 }) {
        // Title
        Text('Retro Filter Search')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FF3E2723')
          .width('100%')
          .textAlign(TextAlign.Start)

        // Search TextInput
        TextInput({ placeholder: 'Search products', text: this.query })
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .foregroundColor('#FF3E2723')
          .placeholderColor('rgba(62,39,35,0.4)')
          .padding({ left: 16, right: 16 })
          .height(56)
          .backgroundColor('#FFFFFFFF')
          .borderRadius(10)
          .border({ width: 1, color: '#FFE0C080' })
          .onChange((value: string) => {
            this.query = value
          })

        // Filter Buttons Row
        Row({ space: 8 }) {
          ForEach(["Popular", "New", "Discount", "Premium"], (text: string) => {
            Button() {
              Text(text)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FF3E2723')
                .padding({ left: 12, right: 12, top: 12, bottom: 12 })
            }
            .height(36)
            .backgroundColor('#FFFFD166')
            .borderRadius(6)
            .onClick(() => { })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start) // Corrected from alignItems to justifyContent

        // Canvas Area (simulated)
        Stack() {
          // Background
          Column() { }
            .width('100%')
            .height(180)
            .backgroundColor('#FFF0C1')
            .borderRadius(14)

          // Simulated content
          Column() {
            // Radial gradient circle (approximated with solid circle)
            Button() { }
              .width(120)
              .height(120)
              .borderRadius(60)
              .backgroundColor('#FFFF7B00')

            // Knob circle
            Button() { }
              .width(32)
              .height(32)
              .borderRadius(16)
              .backgroundColor('#FFFF7B00')
              .margin({ left: 144, top: -40 }) // approximate position
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height(180)
        .padding(16)
        .backgroundColor('#FFFFFFFF')
        .borderRadius(14)

        // Results Grid
        Grid() {
          ForEach(this.results, (item: ResultItem) => {
            GridItem() {
              Column({ space: 8 }) {
                // Image placeholder
                Button() { }
                  .width(96)
                  .height(96)
                  .backgroundColor('#FFF0C1')
                  .borderRadius(10)

                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF3E2723')

                Button() {
                  Text('Add')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#FFFFFFFF')
                }
                .width('100%')
                .height(48)
                .backgroundColor('#FFFF7B00')
                .borderRadius(10)
                .onClick(() => { })
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFFFF')
              .borderRadius(14)
              .shadow({
                radius: 8,
                color: 'rgba(0,0,0,0.12)',
                offsetX: 0,
                offsetY: 4
              })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .width('100%')
        .padding({ bottom: 24 })
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFF6E5')
  }
}

interface ResultItem {
  id: number
  title: string
}