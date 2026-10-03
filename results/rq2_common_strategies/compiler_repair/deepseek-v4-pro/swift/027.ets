@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1
  @State selectedTool: string = "pen"
  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

  build() {
    Column() {
      // Top AppBar
      Row({ space: 8 }) {
        Button() {
          Text('').width(24).height(24).backgroundColor('#FFF0F0F5').borderRadius(12)
        }.width(24).height(24)

        Blank()

        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#FF1B1B1F')

        Blank()

        Button() {
          Text('Share')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF001D3D')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .backgroundColor('#FFA0C4FF')
            .borderRadius(4)
        }
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 12, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFFFF')

      // Main content area
      Row({ space: 12 }) {
        // Left side: page grid
        Grid()
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .width(150)
          .padding({ left: 8, right: 8, top: 8, bottom: 8 })
          .height('100%')
        {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Button() {
                Text(page.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor(this.selectedPage === page ? '#FF001D3D' : '#FF1B1B1F')
              }
              .width('100%')
              .aspectRatio(0.7)
              .backgroundColor(this.selectedPage === page ? '#FFA0C4FF' : '#FFF0F0F5')
              .borderRadius(8)
              .border({
                width: this.selectedPage === page ? 2 : 0,
                color: '#FFA0C4FF'
              })
              .onClick(() => {
                this.selectedPage = page
              })
            }
          })
        }

        // Right side: document view with overlay
        Stack({ alignContent: Alignment.Start }) {
          // Document card
          Column() {
            Text('Page ' + this.selectedPage.toString())
              .fontSize(24)
              .fontWeight(FontWeight.Bold) // Semibold not available, use Bold
              .foregroundColor('#FF1B1B1F')
          }
          .width('100%')
          .height('100%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .backgroundColor('#FFFFFFFF')
          .borderRadius(12)
          .shadow({
            radius: 2,
            color: 'rgba(0,0,0,0.08)',
            offsetX: 0,
            offsetY: 1
          })

          // Annotation tools overlay
          Column({ space: 8 }) {
            Button() {
              Text('P')
                .fontSize(17)
                .fontWeight(FontWeight.Bold)
                .foregroundColor(this.selectedTool === 'pen' ? '#FF003720' : '#FF1B1B1F')
            }
            .width(40)
            .height(40)
            .borderRadius(20)
            .backgroundColor(this.selectedTool === 'pen' ? '#FFB7E4C7' : '#FFF0F0F5')
            .onClick(() => {
              this.selectedTool = 'pen'
            })

            Button() {
              Text('H')
                .fontSize(17)
                .fontWeight(FontWeight.Bold)
                .foregroundColor(this.selectedTool === 'highlighter' ? '#FF003720' : '#FF1B1B1F')
            }
            .width(40)
            .height(40)
            .borderRadius(20)
            .backgroundColor(this.selectedTool === 'highlighter' ? '#FFB7E4C7' : '#FFF0F0F5')
            .onClick(() => {
              this.selectedTool = 'highlighter'
            })

            Button() {
              Text('T')
                .fontSize(17)
                .fontWeight(FontWeight.Bold)
                .foregroundColor(this.selectedTool === 'text' ? '#FF003720' : '#FF1B1B1F')
            }
            .width(40)
            .height(40)
            .borderRadius(20)
            .backgroundColor(this.selectedTool === 'text' ? '#FFB7E4C7' : '#FFF0F0F5')
            .onClick(() => {
              this.selectedTool = 'text'
            })

            Button() {
              Text('S')
                .fontSize(17)
                .fontWeight(FontWeight.Bold)
                .foregroundColor(this.selectedTool === 'shape' ? '#FF003720' : '#FF1B1B1F')
            }
            .width(40)
            .height(40)
            .borderRadius(20)
            .backgroundColor(this.selectedTool === 'shape' ? '#FFB7E4C7' : '#FFF0F0F5')
            .onClick(() => {
              this.selectedTool = 'shape'
            })
          }
          .padding({ left: 8, right: 8, top: 8, bottom: 8 })
          .backgroundColor('rgba(255,255,255,0.8)')
          .borderRadius(12)
          .border({ width: 1, color: '#FFD9D9E3' })
          .margin({ left: 12 })
        }
        .layoutWeight(1)
        .height('100%')
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding({ left: 12, right: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8F7FF')
  }
}