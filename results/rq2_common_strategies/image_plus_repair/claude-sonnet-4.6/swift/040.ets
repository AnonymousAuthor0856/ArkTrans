// AppTokens
const ColorPrimary: string = '#FF7B00';
const ColorSecondary: string = '#FFD166';
const ColorBackground: string = '#FFF6E5';
const ColorSurface: string = '#FFFFFF';
const ColorSurfaceVariant: string = '#FFF0C1';
const ColorOutline: string = '#E0C080';
const ColorOnPrimary: string = '#FFFFFF';
const ColorOnSecondary: string = '#3E2723';
const ColorOnBackground: string = '#3E2723';
const ColorOnSurface: string = '#3E2723';

const ShapeSmall: number = 6;
const ShapeMedium: number = 10;
const ShapeLarge: number = 14;

const SpacingSm: number = 8;
const SpacingMd: number = 12;
const SpacingLg: number = 16;

class ResultItem {
  id: number = 0;
  title: string = '';
}

@Component
struct CardView {
  item: ResultItem = new ResultItem();

  build() {
    Column({ space: SpacingSm }) {
      Column()
        .width(96)
        .height(96)
        .backgroundColor(ColorSurfaceVariant)
        .borderRadius(ShapeMedium)

      Text(this.item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColorOnSurface)

      Button('Add')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColorOnPrimary)
        .width('100%')
        .height(48)
        .backgroundColor(ColorPrimary)
        .borderRadius(ShapeMedium)
    }
    .padding(SpacingLg)
    .width('100%')
    .backgroundColor(ColorSurface)
    .borderRadius(ShapeLarge)
    .shadow({
      radius: 8,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 4,
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State isFocused: boolean = false;
  @State knobX: number = 144;
  @State knobY: number = 104;

  private results: ResultItem[] = [0, 1, 2, 3, 4, 5].map((i: number) => {
    let item = new ResultItem();
    item.id = i;
    item.title = `Result ${i + 1}`;
    return item;
  });

  private filterLabels: string[] = ['Popular', 'New', 'Discount', 'Premium'];

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  private drawCanvas(): void {
    const ctx = this.canvasContext;
    const width = ctx.width;
    const height = ctx.height;

    ctx.clearRect(0, 0, width, height);

    ctx.fillStyle = ColorSurfaceVariant;
    ctx.fillRect(0, 0, width, height);

    const centerX = width / 2;
    const centerY = height / 2;
    const gradient = ctx.createRadialGradient(centerX, centerY, 0, centerX, centerY, 60);
    gradient.addColorStop(0, ColorSecondary);
    gradient.addColorStop(1, ColorPrimary);
    ctx.fillStyle = gradient;
    ctx.beginPath();
    ctx.arc(centerX, centerY, 60, 0, Math.PI * 2);
    ctx.fill();

    ctx.fillStyle = ColorPrimary;
    ctx.beginPath();
    ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2);
    ctx.fill();
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(ColorBackground)

      Scroll() {
        Column({ space: SpacingMd }) {
          Text('Retro Filter Search')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(ColorOnBackground)
            .width('100%')
            .textAlign(TextAlign.Start)

          Stack({ alignContent: Alignment.Start }) {
            if (this.query.length === 0) {
              Text('Search products')
                .fontSize(14)
                .fontColor('#663E2723')
                .padding({ left: SpacingLg })
                .width('100%')
                .hitTestBehavior(HitTestMode.None)
            }
            TextInput({ text: this.query, placeholder: '' })
              .fontSize(14)
              .fontColor(ColorOnSurface)
              .backgroundColor(ColorSurface)
              .height(56)
              .width('100%')
              .borderRadius(ShapeMedium)
              .border({
                width: 1,
                color: this.isFocused ? ColorPrimary : ColorOutline,
                radius: ShapeMedium,
              })
              .padding({ left: SpacingLg, right: SpacingLg })
              .onChange((value: string) => {
                this.query = value;
              })
              .onFocus(() => {
                this.isFocused = true;
              })
              .onBlur(() => {
                this.isFocused = false;
              })
          }
          .width('100%')
          .height(56)

          Row({ space: SpacingSm }) {
            ForEach(this.filterLabels, (label: string) => {
              Button(label)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(ColorOnSecondary)
                .height(36)
                .padding({ left: SpacingMd, right: SpacingMd })
                .backgroundColor(ColorSecondary)
                .borderRadius(ShapeSmall)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)

          Stack() {
            Canvas(this.canvasContext)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawCanvas();
              })
              .gesture(
                PanGesture()
                  .onActionUpdate((event: GestureEvent) => {
                    this.knobX = Math.max(16, Math.min(event.offsetX + 144, 300));
                    this.knobY = Math.max(16, Math.min(event.offsetY + 104, 164));
                    this.drawCanvas();
                  })
              )
          }
          .width('100%')
          .height(180)
          .backgroundColor(ColorSurface)
          .borderRadius(ShapeLarge)
          .clip(true)

          Grid() {
            ForEach(this.results, (item: ResultItem) => {
              GridItem() {
                CardView({ item: item })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(SpacingLg)
          .rowsGap(SpacingLg)
          .width('100%')
          .padding({ bottom: 24 })
        }
        .padding(SpacingLg)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ColorBackground)
  }
}