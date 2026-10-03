@Entry
@Component
struct Index {
  @State selectedPage: number = 0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold Content Area ===
      Row({ space: 0 }) {
        // === LazyVerticalGrid (Left Sidebar) ===
        Grid() {
          // Simulating a single item for the grid as per skeleton structure
          GridItem() {
            Column() {
              Stack({ alignContent: Alignment.Center }) {
                Text('1')
                  .fontColor(this.selectedPage == 1 ? '#6750A4' : '#1C1B1F')
                  .fontSize(12)
              }
            }
            .backgroundColor(this.selectedPage == 1 ? '#6750A4' : '#E7E0EC')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
            .onClick(() => {
              this.selectedPage = 1
            })
          }
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(8)
        .rowsGap(8)
        .width('150vp')
        .height('100%')
        .padding(8)

        // === Spacer ===
        Blank().width(12)

        // === Main Content Area ===
        Stack({ alignContent: Alignment.Center }) {
          // === Card (Main Page Display) ===
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Text(`Page ${this.selectedPage}`)
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
            }
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })

          // === Floating Tool Bar ===
          Column({ space: 8 }) {
            // AnnotationToolButton: Pen
            Button() {
              Text('P')
                .fontWeight(FontWeight.Bold)
                .fontColor('#1C1B1F')
            }
            .type(ButtonType.Circle)
            .backgroundColor('#E7E0EC')
            .width(40)
            .height(40)

            // AnnotationToolButton: Highlighter
            Button() {
              Text('H')
                .fontWeight(FontWeight.Bold)
                .fontColor('#1C1B1F')
            }
            .type(ButtonType.Circle)
            .backgroundColor('#E7E0EC')
            .width(40)
            .height(40)

            // AnnotationToolButton: Text
            Button() {
              Text('T')
                .fontWeight(FontWeight.Bold)
                .fontColor('#1C1B1F')
            }
            .type(ButtonType.Circle)
            .backgroundColor('#E7E0EC')
            .width(40)
            .height(40)

            // AnnotationToolButton: Shape
            Button() {
              Text('S')
                .fontWeight(FontWeight.Bold)
                .fontColor('#1C1B1F')
            }
            .type(ButtonType.Circle)
            .backgroundColor('#E7E0EC')
            .width(40)
            .height(40)
          }
          .alignItems(HorizontalAlign.Start)
          .padding(8)
          .backgroundColor('#F8F7FF')
          .opacity(0.8)
          .borderRadius(12)
          .border({ width: 1, color: '#CAC4D0', radius: 12 })
          .position({ x: 16, y: 16 })
        }
        .layoutWeight(1)
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .padding(16)

      // === Top App Bar ===
      Row() {
        Text('Document.pdf')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        
        Blank().layoutWeight(1)

        // IconButton (Placeholder)
        Button() {
          Stack({ alignContent: Alignment.Center }) {
            // Empty box as per skeleton
          }
        }
        .type(ButtonType.Circle)
        .backgroundColor('#E7E0EC')
        .width(24)
        .height(24)
        .margin({ right: 8 })

        // Share Button
        Button() {
          Text('Share')
            .fontSize(12)
            .fontColor('#FFFFFF')
        }
        .backgroundColor('#6750A4')
        .borderRadius(16)
        .padding({ left: 12, right: 12, top: 4, bottom: 4 })

        Blank().width(8)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F8F7FF')
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F7FF')
  }
}