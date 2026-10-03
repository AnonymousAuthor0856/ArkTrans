// AppTokens
const PRIMARY_COLOR: string = '#FF7B00';
const SECONDARY_COLOR: string = '#FFD166';
const BACKGROUND_COLOR: string = '#FFF6E5';
const SURFACE_COLOR: string = '#FFFFFF';
const SURFACE_VARIANT_COLOR: string = '#FFF0C1';
const OUTLINE_COLOR: string = '#E0C080';
const ON_PRIMARY_COLOR: string = '#FFFFFF';
const ON_SECONDARY_COLOR: string = '#3E2723';
const ON_BACKGROUND_COLOR: string = '#3E2723';
const ON_SURFACE_COLOR: string = '#3E2723';

const SPACING_SM: number = 8;
const SPACING_MD: number = 12;
const SPACING_LG: number = 16;

const SHAPE_SMALL: number = 6;
const SHAPE_MEDIUM: number = 10;
const SHAPE_LARGE: number = 14;

class ResultItem {
  id: number = 0;
  title: string = '';
}

function buildResults(): ResultItem[] {
  const arr: ResultItem[] = [];
  for (let i = 0; i < 6; i++) {
    const item = new ResultItem();
    item.id = i;
    item.title = `Result ${i + 1}`;
    arr.push(item);
  }
  return arr;
}

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State isFocused: boolean = false;
  @State knobX: number = 144;
  @State knobY: number = 104;

  private results: ResultItem[] = buildResults();
  private filterTags: string[] = ['Popular', 'New', 'Discount', 'Premium'];
  private canvasContext: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(new RenderingContextSettings(true));

  private drawCanvas(): void {
    const ctx = this.canvasContext;
    const w = ctx.width;
    const h = ctx.height;

    ctx.fillStyle = SURFACE_VARIANT_COLOR;
    ctx.fillRect(0, 0, w, h);

    const cx = w / 2;
    const cy = h / 2;
    const gradient = ctx.createRadialGradient(cx, cy, 0, cx, cy, 60);
    gradient.addColorStop(0, SECONDARY_COLOR);
    gradient.addColorStop(1, PRIMARY_COLOR);
    ctx.fillStyle = gradient;
    ctx.beginPath();
    ctx.arc(cx, cy, 60, 0, Math.PI * 2);
    ctx.fill();

    ctx.fillStyle = PRIMARY_COLOR;
    ctx.beginPath();
    ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2);
    ctx.fill();
  }

  build() {
    Stack() {
      Column() {
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BACKGROUND_COLOR)

      Scroll() {
        Column({ space: SPACING_MD }) {
          Text('Retro Filter Search')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_BACKGROUND_COLOR)
            .width('100%')
            .textAlign(TextAlign.Start)

          Stack({ alignContent: Alignment.Start }) {
            if (this.query === '') {
              Text('Search products')
                .fontSize(14)
                .fontColor('#663E2723')
                .padding({ left: SPACING_LG })
                .width('100%')
                .zIndex(0)
            }
            TextInput({ text: this.query, placeholder: '' })
              .fontSize(14)
              .fontColor(ON_SURFACE_COLOR)
              .backgroundColor(SURFACE_COLOR)
              .borderRadius(SHAPE_MEDIUM)
              .height(56)
              .width('100%')
              .padding({ left: SPACING_LG, right: SPACING_LG })
              .border({
                width: 1,
                color: this.isFocused ? PRIMARY_COLOR : OUTLINE_COLOR,
                radius: SHAPE_MEDIUM,
              })
              .onChange((value: string) => {
                this.query = value;
              })
              .onFocus(() => {
                this.isFocused = true;
              })
              .onBlur(() => {
                this.isFocused = false;
              })
              .zIndex(1)
          }
          .width('100%')
          .height(56)

          Row({ space: SPACING_SM }) {
            ForEach(this.filterTags, (tag: string) => {
              Button(tag)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(ON_SECONDARY_COLOR)
                .backgroundColor(SECONDARY_COLOR)
                .borderRadius(SHAPE_SMALL)
                .height(36)
                .padding({ left: SPACING_MD, right: SPACING_MD })
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
          }
          .width('100%')
          .height(180)
          .borderRadius(SHAPE_LARGE)
          .clip(true)
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                this.knobX = Math.max(8, Math.min(event.offsetX + 144, 300));
                this.knobY = Math.max(8, Math.min(event.offsetY + 104, 160));
                this.drawCanvas();
              })
          )

          Grid() {
            ForEach(this.results, (item: ResultItem) => {
              GridItem() {
                CardView({ item: item })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(SPACING_LG)
          .rowsGap(SPACING_LG)
          .width('100%')
          .padding({ bottom: 24 })
        }
        .padding(SPACING_LG)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct CardView {
  item: ResultItem = new ResultItem();

  build() {
    Column({ space: SPACING_SM }) {
      Column() {
      }
      .width(96)
      .height(96)
      .backgroundColor(SURFACE_VARIANT_COLOR)
      .borderRadius(SHAPE_MEDIUM)

      Text(this.item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SURFACE_COLOR)
        .textAlign(TextAlign.Center)

      Button('Add')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_PRIMARY_COLOR)
        .backgroundColor(PRIMARY_COLOR)
        .borderRadius(SHAPE_MEDIUM)
        .width('100%')
        .height(40)
    }
    .padding(SPACING_LG)
    .backgroundColor(SURFACE_COLOR)
    .borderRadius(SHAPE_LARGE)
    .width('100%')
    .shadow({
      radius: 8,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 4,
    })
  }
}