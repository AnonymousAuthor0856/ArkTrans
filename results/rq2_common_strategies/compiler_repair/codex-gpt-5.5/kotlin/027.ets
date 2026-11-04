class PdfColors {
  static primary: string = '#A0C4FF';
  static secondary: string = '#B7E4C7';
  static tertiary: string = '#FFDDC1';
  static background: string = '#F8F7FF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#F0F0F5';
  static outline: string = '#D9D9E3';
  static onPrimary: string = '#001D3D';
  static onSecondary: string = '#003720';
  static onSurface: string = '#1B1B1F';
}

@Entry
@Component
struct Index {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';

  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  @Builder
  PageThumb(page: number) {
    Column() {
      Text(page.toString())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedPage === page ? PdfColors.onPrimary : PdfColors.onSurface)
    }
    .width('100%')
    .aspectRatio(0.7)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.selectedPage === page ? PdfColors.primary : PdfColors.surfaceVariant)
    .border({ width: this.selectedPage === page ? 2 : 0, color: PdfColors.primary, radius: 8 })
    .borderRadius(8)
    .onClick(() => {
      this.selectedPage = page;
    })
  }

  @Builder
  ToolButton(icon: string, toolName: string) {
    Button(icon)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.selectedTool === toolName ? PdfColors.onSecondary : PdfColors.onSurface)
      .width(40)
      .height(40)
      .backgroundColor(this.selectedTool === toolName ? PdfColors.secondary : PdfColors.surfaceVariant)
      .borderRadius(20)
      .onClick(() => {
        this.selectedTool = toolName;
      })
  }

  @Builder
  Toolbar() {
    Column() {
      this.ToolButton('P', 'pen')
      this.ToolButton('H', 'highlighter')
      this.ToolButton('T', 'text')
      this.ToolButton('S', 'shape')
    }
    .padding(8)
    .backgroundColor('#CCFFFFFF')
    .border({ width: 1, color: PdfColors.outline, radius: 12 })
    .borderRadius(12)
    .position({ x: 12, y: 220 })
  }

  build() {
    Column() {
      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill(PdfColors.surfaceVariant)
        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(PdfColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Button('Share')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(PdfColors.onPrimary)
          .height(36)
          .backgroundColor(PdfColors.primary)
          .borderRadius(18)
      }
      .width('100%')
      .padding(12)
      .alignItems(VerticalAlign.Center)

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

        Stack() {
          Column() {
            Text('Page ' + this.selectedPage.toString())
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(PdfColors.onSurface)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(PdfColors.surface)
          .borderRadius(12)
          .shadow({ radius: 2, color: '#14000000', offsetX: 0, offsetY: 1 })

          this.Toolbar()
        }
        .layoutWeight(1)
        .height('100%')
        .margin({ left: 12 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(12)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PdfColors.background)
  }
}
