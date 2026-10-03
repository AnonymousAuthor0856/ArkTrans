const Colors = {
  primary: '#A0C4FF',
  secondary: '#B7E4C7',
  tertiary: '#FFDDC1',
  background: '#F8F7FF',
  surface: '#FFFFFF',
  surfaceVariant: '#F0F0F5',
  outline: '#D9D9E3',
  success: '#B4E4C7',
  warning: '#FFDDC1',
  error: '#FFB4AB',
  onPrimary: '#001D3D',
  onSecondary: '#003720',
  onTertiary: '#3E2800',
  onBackground: '#1B1B1F',
  onSurface: '#1B1B1F'
};

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
};

@Component
struct AnnotationToolButton {
  @Prop icon: string = '';
  @Prop toolName: string = '';
  @Prop selectedTool: string = '';
  onSelect: () => void = () => {};

  build() {
    Button(this.icon)
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(this.toolName === this.selectedTool ? Colors.secondary : Colors.surfaceVariant)
      .fontColor(this.toolName === this.selectedTool ? Colors.onSecondary : Colors.onSurface)
      .fontWeight(FontWeight.Bold)
      .onClick(() => {
        this.onSelect();
      })
  }
}

@Entry
@Component
struct Index {
  @State pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';

  build() {
    Column() {
      Row() {
        Column()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(Colors.surfaceVariant)
        Blank().layoutWeight(1)
        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Blank().layoutWeight(1)
        Button('Share')
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(12)
          .letterSpacing(0.5)
          .onClick(() => {})
        Blank().width(Spacing.sm)
      }
      .width('100%')
      .height(64)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.background)

      Row() {
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Column() {
                Text(page.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .letterSpacing(0.5)
                  .fontColor(this.selectedPage === page ? Colors.onPrimary : Colors.onSurface)
              }
              .width('100%')
              .height('100%')
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
            .backgroundColor(this.selectedPage === page ? Colors.primary : Colors.surfaceVariant)
            .borderRadius(8)
            .border({ width: this.selectedPage === page ? 2 : 0, color: Colors.primary })
            .aspectRatio(0.7)
            .onClick(() => {
              this.selectedPage = page;
            })
          }, (page: number) => page.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(Spacing.sm)
        .rowsGap(Spacing.sm)
        .width(150)
        .height('100%')

        Blank().width(Spacing.md)

        Stack() {
          Column() {
            Text('Page ' + this.selectedPage)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(Colors.surface)
          .borderRadius(12)
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.08)', offsetY: 1 })

          Column() {
            AnnotationToolButton({ icon: 'P', toolName: 'pen', selectedTool: this.selectedTool, onSelect: () => { this.selectedTool = 'pen'; } })
            AnnotationToolButton({ icon: 'H', toolName: 'highlighter', selectedTool: this.selectedTool, onSelect: () => { this.selectedTool = 'highlighter'; } })
            AnnotationToolButton({ icon: 'T', toolName: 'text', selectedTool: this.selectedTool, onSelect: () => { this.selectedTool = 'text'; } })
            AnnotationToolButton({ icon: 'S', toolName: 'shape', selectedTool: this.selectedTool, onSelect: () => { this.selectedTool = 'shape'; } })
          }
          .alignItems(HorizontalAlign.Center)
          .space(Spacing.sm)
          .padding(Spacing.sm)
          .backgroundColor('#CCFFFFFF')
          .borderRadius(12)
          .border({ width: 1, color: Colors.outline })
          .margin({ left: Spacing.md })
        }
        .layoutWeight(1)
        .height('100%')
        .alignContent(Alignment.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.md)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
