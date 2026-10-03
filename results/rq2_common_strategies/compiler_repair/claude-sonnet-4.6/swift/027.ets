// Design Tokens
class ColorsClass {
  primary: string = '#A0C4FF'
  secondary: string = '#B7E4C7'
  tertiary: string = '#FFDDC1'
  background: string = '#F8F7FF'
  surface: string = '#FFFFFF'
  surfaceVariant: string = '#F0F0F5'
  outline: string = '#D9D9E3'
  success: string = '#B4E4C7'
  warning: string = '#FFDDC1'
  error: string = '#FFB4AB'
  onPrimary: string = '#001D3D'
  onSecondary: string = '#003720'
  onTertiary: string = '#3E2800'
  onBackground: string = '#1B1B1F'
  onSurface: string = '#1B1B1F'
}

class SpacingClass {
  xs: number = 4
  sm: number = 8
  md: number = 12
  lg: number = 16
  xl: number = 24
}

const Colors = new ColorsClass()
const Spacing = new SpacingClass()

@Component
struct AnnotationToolButton {
  icon: string = ''
  toolName: string = ''
  @Link selectedTool: string
  onToolClick: () => void = () => {}

  build() {
    Button() {
      Text(this.icon)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.toolName === this.selectedTool ? Colors.onSecondary : Colors.onSurface)
    }
    .width(40)
    .height(40)
    .backgroundColor(this.toolName === this.selectedTool ? Colors.secondary : Colors.surfaceVariant)
    .borderRadius(20)
    .onClick(() => this.onToolClick())
    .type(ButtonType.Normal)
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'
  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Row({ space: Spacing.sm }) {
        Button() {
          Circle()
            .fill(Colors.surfaceVariant)
            .width(24)
            .height(24)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width(24)
        .height(24)

        Blank()

        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onBackground)

        Blank()

        Button('Share')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(4)
          .padding({
            top: Spacing.xs,
            bottom: Spacing.xs,
            left: Spacing.sm,
            right: Spacing.sm
          })
          .type(ButtonType.Normal)
      }
      .padding(Spacing.md)
      .backgroundColor(Colors.surface)
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Row({ space: Spacing.md }) {
        // Left: Page Grid
        Scroll() {
          Grid() {
            ForEach(this.pages, (page: number) => {
              GridItem() {
                Button() {
                  Stack({ alignContent: Alignment.Center }) {
                    Column()
                      .width('100%')
                      .aspectRatio(0.7)
                      .backgroundColor(this.selectedPage === page ? Colors.primary : Colors.surfaceVariant)
                      .borderRadius(8)
                      .border({
                        width: this.selectedPage === page ? 2 : 0,
                        color: this.selectedPage === page ? Colors.primary : Color.Transparent,
                        radius: 8
                      })

                    Text(page.toString())
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.selectedPage === page ? Colors.onPrimary : Colors.onSurface)
                  }
                  .width('100%')
                  .aspectRatio(0.7)
                }
                .type(ButtonType.Normal)
                .backgroundColor(Color.Transparent)
                .width('100%')
                .onClick(() => {
                  this.selectedPage = page
                })
              }
            }, (page: number) => page.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(Spacing.sm)
          .rowsGap(Spacing.sm)
          .padding(Spacing.sm)
          .width('100%')
        }
        .width(150)
        .height('100%')
        .scrollBar(BarState.Off)

        // Right: Document View
        Stack({ alignContent: Alignment.Center }) {
          // Document Card
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
          }
          .width('100%')
          .height('100%')
          .backgroundColor(Colors.surface)
          .borderRadius(12)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .shadow({
            radius: 4,
            color: '#14000000',
            offsetX: 0,
            offsetY: 1
          })

          // Annotation Tools
          Column({ space: Spacing.sm }) {
            AnnotationToolButton({
              icon: 'P',
              toolName: 'pen',
              selectedTool: $selectedTool,
              onToolClick: () => {
                this.selectedTool = 'pen'
              }
            })
            AnnotationToolButton({
              icon: 'H',
              toolName: 'highlighter',
              selectedTool: $selectedTool,
              onToolClick: () => {
                this.selectedTool = 'highlighter'
              }
            })
            AnnotationToolButton({
              icon: 'T',
              toolName: 'text',
              selectedTool: $selectedTool,
              onToolClick: () => {
                this.selectedTool = 'text'
              }
            })
            AnnotationToolButton({
              icon: 'S',
              toolName: 'shape',
              selectedTool: $selectedTool,
              onToolClick: () => {
                this.selectedTool = 'shape'
              }
            })
          }
          .padding(Spacing.sm)
          .backgroundColor('#CCffffff')
          .borderRadius(12)
          .border({
            width: 1,
            color: Colors.outline,
            radius: 12
          })
          .alignSelf(ItemAlign.Start)
          .margin({
            left: Spacing.md,
            top: Spacing.md,
            bottom: Spacing.md
          })
        }
        .layoutWeight(1)
        .height('100%')
      }
      .padding({ left: Spacing.md, right: Spacing.md })
      .width('100%')
      .layoutWeight(1)
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}