interface ColorTokens {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  onPrimary: string
  onSecondary: string
  onSurface: string
  onBackground: string
  error: string
}

@Entry
@Component
struct Index {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'
  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

  private Colors: ColorTokens = {
    primary: '#A0C4FF',
    secondary: '#B7E4C7',
    tertiary: '#FFDDC1',
    background: '#F8F7FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F0F0F5',
    outline: '#D9D9E3',
    onPrimary: '#001D3D',
    onSecondary: '#003720',
    onSurface: '#1B1B1F',
    onBackground: '#1B1B1F',
    error: '#FFB4AB'
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation icon placeholder
        Circle({ width: 48, height: 48 })
          .fill(this.Colors.surfaceVariant)

        // Title
        Text('Document.pdf')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Share button
        Button('Share')
          .fontSize(14)
          .fontColor(this.Colors.onPrimary)
          .backgroundColor(this.Colors.primary)
          .borderRadius(32)
          .height(48)
          .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .height(64)
      .padding({ left: 16, right: 16 })
      .backgroundColor(this.Colors.surface)

      // Main content row
      Row() {
        // Page thumbnails grid (2 columns)
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Column() {
                Text(page.toString())
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedPage === page ? this.Colors.onPrimary : this.Colors.onSurface)
              }
              .width('100%')
              .height('100%')
              .justifyContent(FlexAlign.Center)
              .backgroundColor(this.selectedPage === page ? this.Colors.primary : this.Colors.surfaceVariant)
              .borderRadius(12)
              .border({
                width: this.selectedPage === page ? 2 : 0,
                color: this.Colors.primary
              })
              .onClick(() => {
                this.selectedPage = page
              })
            }
            .aspectRatio(0.7)
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(8)
        .rowsGap(8)
        .width(150)
        .height('100%')
        .padding(8)

        // Spacer
        Blank().width(16)

        // Main page display area
        Stack() {
          // Page card
          Column() {
            Text('Page ' + this.selectedPage.toString())
              .fontSize(36)
              .fontColor(this.Colors.onSurface)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .backgroundColor(this.Colors.surface)
          .borderRadius(24)
          .shadow({ radius: 2, color: 'rgba(0,0,0,0.08)', offsetY: 1 })

          // Annotation toolbar (floating on left side)
          Column() {
            this.AnnotationToolButton('P', 'pen')
            this.AnnotationToolButton('H', 'highlighter')
            this.AnnotationToolButton('T', 'text')
            this.AnnotationToolButton('S', 'shape')
          }
          .width(56)
          .align(Alignment.Start)
          .margin({ left: 16 })
          .padding(8)
          .backgroundColor('rgba(255,255,255,0.8)')
          .borderRadius(24)
          .border({ width: 1, color: this.Colors.outline })
        }
        .layoutWeight(1)
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.Colors.background)
  }

  @Builder
  AnnotationToolButton(icon: string, toolName: string) {
    Button(icon)
      .width(40)
      .height(40)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.selectedTool === toolName ? this.Colors.onSecondary : this.Colors.onSurface)
      .backgroundColor(this.selectedTool === toolName ? this.Colors.secondary : this.Colors.surfaceVariant)
      .borderRadius(20)
      .margin({ bottom: toolName !== 'shape' ? 8 : 0 })
      .onClick(() => {
        this.selectedTool = toolName
      })
  }
}
