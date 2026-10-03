@Entry
@Component
struct RootScreen {
  @State private selectedPage: number = 1;
  @State private selectedTool: string = 'pen';

  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  @Builder
  AnnotationToolButton(icon: string, toolName: string) {
    Button(icon)
      .fontSize(17)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.selectedTool === toolName ? '#003720' : '#1B1B1F')
      .backgroundColor(this.selectedTool === toolName ? '#B7E4C7' : '#F0F0F5')
      .width(40)
      .height(40)
      .borderRadius(20)
      .onClick(() => {
        this.selectedTool = toolName;
      })
  }

  @Builder
  PageThumb(page: number) {
    Button() {
      Stack() {
        Rect()
          .width('100%')
          .height('100%')
          .fill(this.selectedPage === page ? '#A0C4FF' : '#F0F0F5')
          .stroke(this.selectedPage === page ? '#A0C4FF' : Color.Transparent)
          .strokeWidth(2)
          .radius(8)
        Text(page.toString())
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedPage === page ? '#001D3D' : '#1B1B1F')
      }
      .aspectRatio(0.7)
    }
    .backgroundColor(Color.Transparent)
    .onClick(() => {
      this.selectedPage = page;
    })
  }

  @Builder
  TopBar() {
    Row() {
      Button() {
        Circle()
          .width(24)
          .height(24)
          .fill('#F0F0F5')
      }
      .backgroundColor(Color.Transparent)
      Blank()
      Text('Document.pdf')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1B1B1F')
      Blank()
      Button('Share')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#001D3D')
        .backgroundColor('#A0C4FF')
        .height(30)
        .padding({ left: 8, right: 8 })
        .borderRadius(4)
    }
    .width('100%')
    .height(56)
    .padding(12)
    .backgroundColor('#FFFFFF')
  }

  build() {
    Column() {
      this.TopBar()
      Row() {
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              this.PageThumb(page)
            }
          }, (page: number) => page.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(8)
        .rowsGap(8)
        .width(150)
        .height('100%')
        .padding(8)

        Stack({ alignContent: Alignment.Center }) {
          Rect()
            .width('100%')
            .height('100%')
            .fill('#FFFFFF')
            .radius(12)
          Text('Page ' + this.selectedPage.toString())
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#1B1B1F')
          Row() {
            Column() {
              this.AnnotationToolButton('P', 'pen')
              this.AnnotationToolButton('H', 'highlighter')
                .margin({ top: 8 })
              this.AnnotationToolButton('T', 'text')
                .margin({ top: 8 })
              this.AnnotationToolButton('S', 'shape')
                .margin({ top: 8 })
            }
            .padding(8)
            .backgroundColor('#CCFFFFFF')
            .border({ width: 1, color: '#D9D9E3', radius: 12 })
            .borderRadius(12)
            .margin(12)
            Blank()
          }
          .width('100%')
          .height('100%')
        }
        .layoutWeight(1)
        .height('100%')
        .shadow({ radius: 2, color: '#14000000', offsetX: 0, offsetY: 1 })
        .margin({ left: 12 })
      }
      .layoutWeight(1)
      .padding({ left: 12, right: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F7FF')
  }
}
