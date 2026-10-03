import { router } from '@kit.ArkUI';

// Color tokens
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
  onSurface: '#1B1B1F',
};

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
};

@Component
struct AnnotationToolButton {
  icon: string = '';
  toolName: string = '';
  @Prop selectedTool: string = '';
  onClick: () => void = () => {};

  build() {
    Button({ type: ButtonType.Circle }) {
      Text(this.icon)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.toolName === this.selectedTool ? Colors.onSecondary : Colors.onSurface)
    }
    .width(40)
    .height(40)
    .backgroundColor(this.toolName === this.selectedTool ? Colors.secondary : Colors.surfaceVariant)
    .onClick(() => {
      this.onClick();
    })
  }
}

@Component
struct PageThumbnailCard {
  page: number = 1;
  @Prop selectedPage: number = 1;
  onSelect: (page: number) => void = () => {};

  build() {
    Column() {
      Box() {
        Text(this.page.toString())
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor(this.selectedPage === this.page ? Colors.onPrimary : Colors.onSurface)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .aspectRatio(0.7)
    .backgroundColor(this.selectedPage === this.page ? Colors.primary : Colors.surfaceVariant)
    .borderRadius(8)
    .border({
      width: this.selectedPage === this.page ? 2 : 0,
      color: Colors.primary,
      style: BorderStyle.Solid
    })
    .onClick(() => {
      this.onSelect(this.page);
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';
  private pages: number[] = Array.from({ length: 12 }, (_, i) => i + 1);

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button({ type: ButtonType.Circle }) {
          Box()
            .width(24)
            .height(24)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(12)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)

        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Share')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(20)
          .height(36)
          .padding({ left: Spacing.lg, right: Spacing.lg })

        Blank().width(Spacing.sm)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.sm, right: Spacing.sm })
      .backgroundColor(Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Row() {
        // Page Thumbnail Grid
        Scroll() {
          Grid() {
            ForEach(this.pages, (page: number) => {
              GridItem() {
                PageThumbnailCard({
                  page: page,
                  selectedPage: this.selectedPage,
                  onSelect: (p: number) => {
                    this.selectedPage = p;
                  }
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

        Blank().width(Spacing.md)

        // Main Document View
        Stack({ alignContent: Alignment.Start }) {
          // Document Card
          Column() {
            Box() {
              Text(`Page ${this.selectedPage}`)
                .fontSize(24)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(Colors.onSurface)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .height('100%')
          .backgroundColor(Colors.surface)
          .borderRadius(12)
          .shadow({
            radius: 2,
            color: '#14000000',
            offsetX: 0,
            offsetY: 1
          })

          // Annotation Tools Panel
          Column({ space: Spacing.sm }) {
            AnnotationToolButton({
              icon: 'P',
              toolName: 'pen',
              selectedTool: this.selectedTool,
              onClick: () => {
                this.selectedTool = 'pen';
              }
            })
            AnnotationToolButton({
              icon: 'H',
              toolName: 'highlighter',
              selectedTool: this.selectedTool,
              onClick: () => {
                this.selectedTool = 'highlighter';
              }
            })
            AnnotationToolButton({
              icon: 'T',
              toolName: 'text',
              selectedTool: this.selectedTool,
              onClick: () => {
                this.selectedTool = 'text';
              }
            })
            AnnotationToolButton({
              icon: 'S',
              toolName: 'shape',
              selectedTool: this.selectedTool,
              onClick: () => {
                this.selectedTool = 'shape';
              }
            })
          }
          .padding(Spacing.sm)
          .backgroundColor('#CCffffff')
          .borderRadius(12)
          .border({
            width: 1,
            color: Colors.outline,
            style: BorderStyle.Solid
          })
          .margin({ left: Spacing.md, top: 0 })
          .justifyContent(FlexAlign.Center)
          .alignSelf(ItemAlign.Center)
          .offset({ x: 0, y: 0 })
        }
        .layoutWeight(1)
        .height('100%')
        .alignContent(Alignment.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.md)
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}