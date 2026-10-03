// entry/src/main/ets/pages/MetroPlanner.ets
// Metro Planner — Dark Neon theme (Kotlin Compose -> ArkTS / ArkUI)

const COLOR_PRIMARY: string = '#00FFFF';
const COLOR_SECONDARY: string = '#00B4FF';
const COLOR_BACKGROUND: string = '#0A0A1A';
const COLOR_SURFACE: string = '#141436';
const COLOR_SURFACE_VARIANT: string = '#1E1E4A';
const COLOR_SUCCESS: string = '#00FFAA';
const COLOR_ON_PRIMARY: string = '#0A0A1A';
const COLOR_ON_SURFACE: string = '#FFFFFF';

const SHAPE_LARGE: number = 22;
const SPACING_LG: number = 16;
const FAB_SIZE: number = 56;

@Entry
@Component
struct MetroPlanner {
  @State stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'];
  private tabItems: string[] = ['Routes', 'Planner', 'Tickets', 'Profile'];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  // Zig-zag metro line: even index -> top track, odd index -> bottom track
  private stationY(index: number, height: number): number {
    return index % 2 === 0 ? height / 4 : height * 3 / 4;
  }

  private drawMetroMap(): void {
    const width: number = this.ctx.width;
    const height: number = this.ctx.height;
    const step: number = width / (this.stations.length - 1);

    // Horizontal gradient stroke: secondary -> primary
    const lineGradient: CanvasGradient = this.ctx.createLinearGradient(0, 0, width, 0);
    lineGradient.addColorStop(0, COLOR_SECONDARY);
    lineGradient.addColorStop(1, COLOR_PRIMARY);

    // Polyline path
    this.ctx.beginPath();
    for (let i = 0; i < this.stations.length; i++) {
      const x: number = i * step;
      const y: number = this.stationY(i, height);
      if (i === 0) {
        this.ctx.moveTo(x, y);
      } else {
        this.ctx.lineTo(x, y);
      }
    }
    this.ctx.lineWidth = 6;
    this.ctx.lineJoin = 'round';
    this.ctx.lineCap = 'round';
    this.ctx.strokeStyle = lineGradient;
    this.ctx.stroke();

    // Station markers: outer cyan dot + inner background dot (ring)
    for (let i = 0; i < this.stations.length; i++) {
      const x: number = i * step;
      const y: number = this.stationY(i, height);

      this.ctx.beginPath();
      this.ctx.arc(x, y, 16, 0, Math.PI * 2);
      this.ctx.fillStyle = COLOR_PRIMARY;
      this.ctx.fill();

      this.ctx.beginPath();
      this.ctx.arc(x, y, 6, 0, Math.PI * 2);
      this.ctx.fillStyle = COLOR_BACKGROUND;
      this.ctx.fill();
    }
  }

  @Builder
  DepartureRow(label: string) {
    Row() {
      Text(label)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(COLOR_ON_SURFACE)
      Text('On Time')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_SUCCESS)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({ top: 6 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // ---- Scrollable-ish content area ----
        Column() {
          Text('Metro Planner')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_PRIMARY)
            .width('100%')

          // Chart card
          Column() {
            Canvas(this.ctx)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawMetroMap();
              })
          }
          .width('100%')
          .height(260)
          .padding(10)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(SHAPE_LARGE)
          .margin({ top: SPACING_LG })

          // Next departures card
          Column() {
            Text('Next Departures')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_SECONDARY)
              .width('100%')

            ForEach(this.departures, (item: string) => {
              this.DepartureRow(item);
            }, (item: string) => item)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(SPACING_LG)
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(SHAPE_LARGE)
          .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.35)', offsetX: 0, offsetY: 4 })
          .margin({ top: SPACING_LG })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(SPACING_LG)
        .alignItems(HorizontalAlign.Start)

        // ---- Bottom navigation bar ----
        Row() {
          Text(this.tabItems[0])
            .fontSize(16)
            .fontColor(COLOR_SECONDARY)
          Text(this.tabItems[1])
            .fontSize(16)
            .fontColor(COLOR_ON_SURFACE)
          Text(this.tabItems[2])
            .fontSize(16)
            .fontColor(COLOR_ON_SURFACE)
          Text(this.tabItems[3])
            .fontSize(16)
            .fontColor(COLOR_ON_SURFACE)
        }
        .width('100%')
        .height(78)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: SPACING_LG, right: SPACING_LG })
        .backgroundColor(COLOR_SURFACE)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [
          [COLOR_BACKGROUND, 0.0],
          [COLOR_SURFACE_VARIANT, 0.5],
          [COLOR_BACKGROUND, 1.0]
        ]
      })

      // ---- Floating action button ----
      Text('+')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_PRIMARY)
        .textAlign(TextAlign.Center)
        .width(FAB_SIZE)
        .height(FAB_SIZE)
        .borderRadius(FAB_SIZE / 2)
        .backgroundColor(COLOR_PRIMARY)
        .shadow({ radius: 12, color: 'rgba(0, 255, 255, 0.35)', offsetX: 0, offsetY: 6 })
        .margin({ right: 24, bottom: 98 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}