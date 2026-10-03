// MARK: - AppColors as individual constants
const COLOR_PRIMARY: number = 0xFFFF7043;
const COLOR_SECONDARY: number = 0xFFFFB74D;
const COLOR_TERTIARY: number = 0xFFFFD54F;
const COLOR_BACKGROUND: number = 0xFFFFF8E1;
const COLOR_SURFACE: number = 0xFFFFFFFF;
const COLOR_SURFACE_VARIANT: number = 0xFFFFECB3;
const COLOR_OUTLINE: number = 0xFFE0C097;
const COLOR_SUCCESS: number = 0xFF43A047;
const COLOR_WARNING: number = 0xFFFBC02D;
const COLOR_ERROR: number = 0xFFE53935;
const COLOR_ON_PRIMARY: number = 0xFFFFFFFF;
const COLOR_ON_SECONDARY: number = 0xFF3E2723;
const COLOR_ON_TERTIARY: number = 0xFF3E2723;
const COLOR_ON_BACKGROUND: number = 0xFF3E2723;
const COLOR_ON_SURFACE: number = 0xFF3E2723;

// MARK: - Spacing constants
const SPACING_XS: number = 4;
const SPACING_SM: number = 8;
const SPACING_MD: number = 12;
const SPACING_LG: number = 16;
const SPACING_XL: number = 24;
const SPACING_XXL: number = 32;

// MARK: - Client Data Model
class Client {
  id: number = 0;
  name: string = '';
  region: string = '';
  level: string = '';
  x: number = 0;
  y: number = 0;

  constructor(id: number, name: string, region: string, level: string, x: number, y: number) {
    this.id = id;
    this.name = name;
    this.region = region;
    this.level = level;
    this.x = x;
    this.y = y;
  }
}

const clients: Client[] = [
  new Client(1, 'Sunrise Tech', 'Shanghai', 'A', 0.2, 0.3),
  new Client(2, 'Delta Logistics', 'Beijing', 'B', 0.5, 0.45),
  new Client(3, 'Oceanic Foods', 'Guangzhou', 'A', 0.72, 0.6),
  new Client(4, 'Horizon Ltd.', 'Chengdu', 'C', 0.33, 0.75),
];

function getMarkerColor(level: string): number {
  if (level === 'A') {
    return COLOR_PRIMARY;
  } else if (level === 'B') {
    return COLOR_SECONDARY;
  } else {
    return COLOR_TERTIARY;
  }
}

// MARK: - MapMarker Component
@Component
struct MapMarker {
  label: string = '';
  level: string = '';
  selected: boolean = false;
  onMarkerClick: () => void = () => {};
  xOffset: number = 0;
  yOffset: number = 0;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Marker dot
      Circle()
        .fill(getMarkerColor(this.level))
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .border({
          width: 2,
          color: this.selected ? COLOR_ON_PRIMARY : COLOR_SURFACE,
          radius: 100
        })
        .position({ x: this.xOffset, y: this.yOffset })

      // Label card
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
        .padding({ left: SPACING_SM, right: SPACING_SM, top: SPACING_XS, bottom: SPACING_XS })
        .backgroundColor(COLOR_SURFACE_VARIANT)
        .borderRadius(8)
        .border({ width: 1, color: COLOR_OUTLINE, radius: 8 })
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        .position({ x: this.xOffset + 20, y: this.yOffset - 4 })
        .onClick(() => {
          this.onMarkerClick();
        })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - MapGridCanvas Component (using Canvas for grid drawing)
@Component
struct MapGridCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Canvas(this.ctx)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawGrid();
      })
  }

  drawGrid() {
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    const pad: number = SPACING_LG;
    const availW: number = w - 2 * pad;
    const availH: number = h - 2 * pad;

    this.ctx.strokeStyle = '#FFECB3';
    this.ctx.lineWidth = 1;

    // Horizontal lines
    for (let i: number = 1; i <= 6; i++) {
      const y: number = pad + (availH / 7) * i;
      this.ctx.beginPath();
      this.ctx.moveTo(0, y);
      this.ctx.lineTo(w, y);
      this.ctx.stroke();
    }

    // Vertical lines
    for (let i: number = 1; i <= 6; i++) {
      const x: number = pad + (availW / 7) * i;
      this.ctx.beginPath();
      this.ctx.moveTo(x, 0);
      this.ctx.lineTo(x, h);
      this.ctx.stroke();
    }
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State selectedId: number = -1;
  @State mapWidth: number = 360;
  @State mapHeight: number = 400;

  build() {
    Column() {
      // Top Bar
      Stack() {
        Text('Client Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
          .padding({ top: SPACING_MD, bottom: SPACING_MD })
      }
      .width('100%')
      .height(56)
      .backgroundColor(COLOR_BACKGROUND)

      // Scrollable content
      Scroll() {
        Column({ space: SPACING_MD }) {
          // Regional Client Map header
          Text('Regional Client Map')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_PRIMARY)
            .width('100%')
            .height(200)
            .textAlign(TextAlign.Center)
            .linearGradient({
              angle: 90,
              colors: [[COLOR_SECONDARY, 0.0], [COLOR_PRIMARY, 1.0]]
            })
            .borderRadius(16)
            .margin({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD })

          // Map area
          Stack({ alignContent: Alignment.TopStart }) {
            // Background
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor(COLOR_SURFACE)
              .borderRadius(16)
              .border({ width: 1, color: COLOR_OUTLINE, radius: 16 })

            // Grid overlay
            MapGridCanvas()
              .width('100%')
              .height('100%')
              .borderRadius(16)

            // Map markers
            ForEach(clients, (client: Client) => {
              MapMarker({
                label: client.name,
                level: client.level,
                selected: this.selectedId === client.id,
                onMarkerClick: () => {
                  this.selectedId = (this.selectedId === client.id) ? -1 : client.id;
                },
                xOffset: this.mapWidth * client.x,
                yOffset: this.mapHeight * client.y,
              })
            })
          }
          .width('100%')
          .height(400)
          .margin({ left: SPACING_LG, right: SPACING_LG })
          .onAreaChange((_oldValue: Area, newValue: Area) => {
            this.mapWidth = newValue.width as number;
            this.mapHeight = newValue.height as number;
          })

          // Client List
          Column({ space: SPACING_MD }) {
            ForEach(clients, (client: Client) => {
              Stack() {
                // Card background
                Column()
                  .width('100%')
                  .height('100%')
                  .backgroundColor(COLOR_SURFACE)
                  .borderRadius(12)
                  .border({ width: 1, color: COLOR_OUTLINE, radius: 12 })
                  .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })

                // Card content
                Row() {
                  Column({ space: SPACING_XS }) {
                    Text(client.name)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(COLOR_ON_SURFACE)
                    Text(client.region)
                      .fontSize(14)
                      .fontWeight(FontWeight.Normal)
                      .fontColor(COLOR_ON_SURFACE)
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)

                  Text(`Level ${client.level}`)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(COLOR_PRIMARY)
                }
                .width('100%')
                .padding(SPACING_LG)
              }
              .width('100%')
              .height(80)
            })
          }
          .width('100%')
          .padding({ left: SPACING_LG, right: SPACING_LG, bottom: SPACING_XXL })
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .backgroundColor(COLOR_BACKGROUND)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}