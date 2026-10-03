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
  onPrimary: '#001D3D',
  onSecondary: '#003720',
  onTertiary: '#3E2800',
  onBackground: '#1B1B1F',
  onSurface: '#1B1B1F',
}

@Component
struct AnnotationToolButton {
  icon: string = '';
  toolName: string = '';
  selectedTool: string = '';
  onToolClick: () => void = () => {};

  build() {
    Button(this.icon)
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(this.toolName === this.selectedTool ? Colors.secondary : Colors.surfaceVariant)
      .fontColor(this.toolName === this.selectedTool ? Colors.onSecondary : Colors.onSurface)
      .fontWeight(FontWeight.Bold)
      .fontSize(14)
      .onClick(() => {
        this.onToolClick();
      })
  }
}

@Entry
@Component
struct Index {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';
  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Stack() {
          Circle()
            .width(24)
            .height(24)
            .fill(Colors.surfaceVariant)
        }
        .width(40)
        .height(40)
        .margin({ left: 8 })

        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Share')
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(12)
          .height(36)
          .margin({ right: 8 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Row() {
        // Page Thumbnails Grid
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
              .border(this.selectedPage === page ? { width: 2, color: Colors.primary } : { width: 0, color: Colors.primary })
              .onClick(() => {
                this.selectedPage = page;
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
        Blank().width(12)

        // Main Document View
        Stack() {
          // Document Card
          Column() {
            Text(`Page ${this.selectedPage}`)
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
          .shadow({ radius: 2, color: '#14000000', offsetX: 0, offsetY: 1 })

          // Annotation Tools
          Column({ space: 8 }) {
            AnnotationToolButton({
              icon: 'P',
              toolName: 'pen',
              selectedTool: this.selectedTool,
              onToolClick: () => {
                this.selectedTool = 'pen';
              }
            })
            AnnotationToolButton({
              icon: 'H',
              toolName: 'highlighter',
              selectedTool: this.selectedTool,
              onToolClick: () => {
                this.selectedTool = 'highlighter';
              }
            })
            AnnotationToolButton({
              icon: 'T',
              toolName: 'text',
              selectedTool: this.selectedTool,
              onToolClick: () => {
                this.selectedTool = 'text';
              }
            })
            AnnotationToolButton({
              icon: 'S',
              toolName: 'shape',
              selectedTool: this.selectedTool,
              onToolClick: () => {
                this.selectedTool = 'shape';
              }
            })
          }
          .padding(8)
          .backgroundColor('#CCffffff')
          .borderRadius(12)
          .border({ width: 1, color: Colors.outline })
          .alignItems(HorizontalAlign.Center)
          .position({ x: 12, y: '35%' })
        }
        .layoutWeight(1)
        .height('100%')
        .alignContent(Alignment.TopStart)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(12)
      .backgroundColor(Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}