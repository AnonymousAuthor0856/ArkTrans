const BACKGROUND: string = '#F8F7FF';
const SURFACE: string = '#FFFFFF';
const SURFACE_VARIANT: string = '#F0F0F5';
const PRIMARY: string = '#A0C4FF';
const SECONDARY: string = '#B7E4C7';
const OUTLINE: string = '#D9D9E3';
const TEXT: string = '#1B1B1F';
const ON_PRIMARY: string = '#001D3D';
const ON_SECONDARY: string = '#003720';
const WHITE_OVERLAY: string = '#CCFFFFFF';
const SHADOW: string = '#14000000';

interface ToolItem {
  label: string;
  id: string;
}

@Entry
@Component
struct MainPage {
  @State private selectedPage: number = 1;
  @State private selectedTool: string = 'pen';

  private readonly pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  private readonly tools: ToolItem[] = [
    { label: 'P', id: 'pen' },
    { label: 'H', id: 'highlighter' },
    { label: 'T', id: 'text' },
    { label: 'S', id: 'shape' }
  ];

  @Builder
  private pageTile(page: number) {
    Button(page.toString())
      .fontSize(18)
      .fontColor(this.selectedPage === page ? ON_PRIMARY : TEXT)
      .fontWeight(FontWeight.Medium)
      .width('100%')
      .aspectRatio(0.7)
      .backgroundColor(this.selectedPage === page ? PRIMARY : SURFACE_VARIANT)
      .borderRadius(12)
      .border({
        width: this.selectedPage === page ? 2 : 0,
        color: PRIMARY
      })
      .onClick(() => {
        this.selectedPage = page;
      });
  }

  @Builder
  private toolButton(tool: ToolItem) {
    Button(tool.label)
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.selectedTool === tool.id ? ON_SECONDARY : TEXT)
      .width(40)
      .height(40)
      .backgroundColor(this.selectedTool === tool.id ? SECONDARY : SURFACE_VARIANT)
      .borderRadius(20)
      .onClick(() => {
        this.selectedTool = tool.id;
      });
  }

  build() {
    Column() {
      Row() {
        Button('')
          .width(24)
          .height(24)
          .backgroundColor(SURFACE_VARIANT)
          .borderRadius(12)
          .padding(0)
          .onClick(() => {
          });

        Text('Document.pdf')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(TEXT)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .margin({ left: 12, right: 12 });

        Button('Share')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_PRIMARY)
          .height(32)
          .padding({ left: 12, right: 12 })
          .backgroundColor(PRIMARY)
          .borderRadius(4)
          .onClick(() => {
          });
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(SURFACE);

      Row({ space: 12 }) {
        Column({ space: 8 }) {
          Row({ space: 16 }) {
            Column({ space: 12 }) {
              ForEach(this.pages.filter((page: number) => page % 2 === 1), (page: number) => {
                this.pageTile(page);
              }, (page: number) => page.toString());
            }
            .layoutWeight(1);

            Column({ space: 12 }) {
              ForEach(this.pages.filter((page: number) => page % 2 === 0), (page: number) => {
                this.pageTile(page);
              }, (page: number) => page.toString());
            }
            .layoutWeight(1);
          }
          .width('100%')
          .layoutWeight(1)
          .alignItems(VerticalAlign.Top);
        }
        .width(304)
        .height('100%')
        .padding({ left: 8, right: 8, top: 8, bottom: 8 });

        Stack() {
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(TEXT);
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(SURFACE)
          .borderRadius(12)
          .shadow({
            radius: 4,
            color: SHADOW,
            offsetX: 0,
            offsetY: 1
          });

          Column({ space: 8 }) {
            ForEach(this.tools, (tool: ToolItem) => {
              this.toolButton(tool);
            }, (tool: ToolItem) => tool.id);
          }
          .padding(8)
          .backgroundColor(WHITE_OVERLAY)
          .borderRadius(12)
          .border({ width: 1, color: OUTLINE })
          .position({ x: 24, y: '50%' })
          .translate({ y: -100 });
        }
        .layoutWeight(1)
        .height('100%')
        .clip(true);
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, bottom: 0 })
      .alignItems(VerticalAlign.Top);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
    .padding({ top: 0, bottom: 0 });
  }
}
