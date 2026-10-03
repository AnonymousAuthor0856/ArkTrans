import { display } from '@kit.ArkUI';

// Color tokens
const COLOR_PRIMARY: string = '#FFFF7B00';
const COLOR_SECONDARY: string = '#FFFFD166';
const COLOR_BACKGROUND: string = '#FFFFF6E5';
const COLOR_SURFACE: string = '#FFFFFFFF';
const COLOR_SURFACE_VARIANT: string = '#FFFFF0C1';
const COLOR_OUTLINE: string = '#FFE0C080';
const COLOR_ON_PRIMARY: string = '#FFFFFFFF';
const COLOR_ON_SECONDARY: string = '#FF3E2723';
const COLOR_ON_BACKGROUND: string = '#FF3E2723';
const COLOR_ON_SURFACE: string = '#FF3E2723';

class ResultItem {
  id: number = 0;
  title: string = '';

  constructor(id: number, title: string) {
    this.id = id;
    this.title = title;
  }
}

class KnobPosition {
  x: number = 160;
  y: number = 120;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State knob: KnobPosition = new KnobPosition(160, 120);
  @State results: ResultItem[] = [
    new ResultItem(0, 'Result 1'),
    new ResultItem(1, 'Result 2'),
    new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'),
    new ResultItem(4, 'Result 5'),
    new ResultItem(5, 'Result 6'),
  ];
  private filterTags: string[] = ['Popular', 'New', 'Discount', 'Premium'];
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const ctx = this.canvasContext;
    const w = this.canvasWidth;
    const h = this.canvasHeight;
    if (w === 0 || h === 0) return;

    ctx.clearRect(0, 0, w, h);

    // Draw background rect
    ctx.fillStyle = COLOR_SURFACE_VARIANT;
    ctx.fillRect(0, 0, w, h);

    // Draw radial gradient circle
    const cx = w / 2;
    const cy = h / 2;
    const gradient = ctx.createRadialGradient(cx, cy, 0, cx, cy, 80);
    gradient.addColorStop(0, COLOR_SECONDARY);
    gradient.addColorStop(1, COLOR_PRIMARY);
    ctx.fillStyle = gradient;
    ctx.beginPath();
    ctx.arc(cx, cy, 80, 0, Math.PI * 2);
    ctx.fill();

    // Draw knob circle
    ctx.fillStyle = COLOR_PRIMARY;
    ctx.beginPath();
    ctx.arc(this.knob.x, this.knob.y, 16, 0, Math.PI * 2);
    ctx.fill();
  }

  build() {
    Scroll() {
      Column({ space: 12 }) {
        // Title
        Text('Retro Filter Search')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_BACKGROUND)
          .width('100%')

        // Search TextField
        TextInput({ placeholder: 'Search products', text: this.query })
          .placeholderColor('#663E2723')
          .placeholderFont({ size: 14 })
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(10)
          .borderWidth(1)
          .borderColor(COLOR_OUTLINE)
          .fontColor(COLOR_ON_SURFACE)
          .fontSize(14)
          .width('100%')
          .height(48)
          .onChange((value: string) => {
            this.query = value;
          })

        // Filter buttons row
        Row({ space: 8 }) {
          ForEach(this.filterTags, (tag: string) => {
            Button(tag)
              .backgroundColor(COLOR_SECONDARY)
              .fontColor(COLOR_ON_SECONDARY)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .borderRadius(6)
              .height(36)
              .padding({ left: 12, right: 12 })
          })
        }
        .width('100%')

        // Canvas area
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height(180)
            .borderRadius(14)
            .backgroundColor(COLOR_SURFACE)
            .onReady(() => {
              this.canvasWidth = this.canvasContext.width;
              this.canvasHeight = this.canvasContext.height;
              this.drawCanvas();
            })
            .gesture(
              PanGesture()
                .onActionUpdate((event: GestureEvent) => {
                  const x = event.offsetX;
                  const y = event.offsetY;
                  this.knob = new KnobPosition(
                    Math.max(0, Math.min(x, this.canvasWidth)),
                    Math.max(0, Math.min(y, this.canvasHeight))
                  );
                  this.drawCanvas();
                })
            )
        }
        .width('100%')
        .height(180)
        .borderRadius(14)
        .backgroundColor(COLOR_SURFACE)

        // Results grid
        Grid() {
          ForEach(this.results, (item: ResultItem) => {
            GridItem() {
              Column({ space: 8 }) {
                // Image placeholder
                Row()
                  .width(96)
                  .height(96)
                  .backgroundColor(COLOR_SURFACE_VARIANT)
                  .borderRadius(10)

                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_ON_SURFACE)

                Button('Add')
                  .backgroundColor(COLOR_PRIMARY)
                  .fontColor(COLOR_ON_PRIMARY)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .borderRadius(10)
                  .width('100%')
                  .height(36)
              }
              .width('100%')
              .padding(16)
              .alignItems(HorizontalAlign.Center)
              .backgroundColor(COLOR_SURFACE)
              .borderRadius(14)
              .shadow({
                radius: 8,
                color: '#1F000000',
                offsetX: 0,
                offsetY: 4
              })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .width('100%')
        .height(400)
        .padding({ bottom: 24 })
      }
      .padding(16)
      .width('100%')
    }
    .backgroundColor(COLOR_BACKGROUND)
    .width('100%')
    .height('100%')
  }
}