class Colors {
  static readonly primary: string = '#A0C4FF';
  static readonly secondary: string = '#B7E4C7';
  static readonly tertiary: string = '#FFDDC1';
  static readonly background: string = '#F8F7FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F0F0F5';
  static readonly outline: string = '#D9D9E3';
  static readonly success: string = '#B4E4C7';
  static readonly warning: string = '#FFDDC1';
  static readonly error: string = '#FFB4AB';
  static readonly onPrimary: string = '#001D3D';
  static readonly onSecondary: string = '#003720';
  static readonly onTertiary: string = '#3E2800';
  static readonly onBackground: string = '#1B1B1F';
  static readonly onSurface: string = '#1B1B1F';
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class Elevation {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 2, 1, 0.08);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 4, 2, 0.10);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 8, 4, 0.12);
}

@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';
  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  @Builder
  AnnotationToolButton(icon: string, toolName: string) {
    Button({ type: ButtonType.Normal }) {
      Text(icon)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(toolName === this.selectedTool ? Colors.onSecondary : Colors.onSurface)
    }
    .width(40)
    .height(40)
    .borderRadius(20)
    .backgroundColor(toolName === this.selectedTool ? Colors.secondary : Colors.surfaceVariant)
    .onClick(() => {
      this.selectedTool = toolName;
    })
  }

  @Builder
  TopBar() {
    Row() {
      Row()
        .width(24)
        .height(24)
        .backgroundColor(Colors.surfaceVariant)
        .borderRadius(12)

      Text('Document.pdf')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Button({ type: ButtonType.Normal }) {
        Text('Share')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
      }
      .height(32)
      .borderRadius(8)
      .backgroundColor(Colors.primary)
    }
    .width('100%')
    .height(64)
    .padding({ left: 12, right: 12 })
    .backgroundColor(Colors.surface)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      this.TopBar()

      Row() {
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Stack() {
                Text(page.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedPage === page ? Colors.onPrimary : Colors.onSurface)
              }
              .width('100%')
              .height('100%')
              .alignContent(Alignment.Center)
              .backgroundColor(this.selectedPage === page ? Colors.primary : Colors.surfaceVariant)
              .borderRadius(8)
              .border({
                width: this.selectedPage === page ? 2 : 0,
                color: Colors.primary
              })
              .onClick(() => {
                this.selectedPage = page;
              })
            }
            .aspectRatio(0.7)
          }, (page: number) => page.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(8)
        .rowsGap(8)
        .width(150)
        .height('100%')
        .padding(8)

        Row()
          .width(12)
          .height('100%')

        Stack() {
          Stack() {
            Text('Page ' + this.selectedPage)
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
          }
          .width('100%')
          .height('100%')
          .alignContent(Alignment.Center)
          .backgroundColor(Colors.surface)
          .borderRadius(12)

          Column({ space: 8 }) {
            this.AnnotationToolButton('P', 'pen')
            this.AnnotationToolButton('H', 'highlighter')
            this.AnnotationToolButton('T', 'text')
            this.AnnotationToolButton('S', 'shape')
          }
          .padding(8)
          .backgroundColor('#CCFFFFFF')
          .borderRadius(12)
          .border({ width: 1, color: Colors.outline })
          .align(Alignment.Start)
          .margin({ left: 12 })
        }
        .layoutWeight(1)
        .height('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .padding(12)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
