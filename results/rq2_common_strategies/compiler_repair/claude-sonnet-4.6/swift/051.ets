// AppColors
const PRIMARY: string = '#FF00FFFF';
const SECONDARY: string = '#FF00B4FF';
const BACKGROUND: string = '#FF0A0A1A';
const SURFACE: string = '#FF141436';
const SURFACE_VARIANT: string = '#FF1E1E4A';
const SUCCESS: string = '#FF00FFAA';
const ON_PRIMARY: string = '#FF0A0A1A';
const ON_SURFACE: string = '#FFFFFFFF';

// AppSpacing
const SPACING_SM: number = 6;
const SPACING_LG: number = 16;

// AppShapes
const CORNER_LARGE: number = 22;

// AppTypography sizes
const FONT_DISPLAY: number = 28;
const FONT_TITLE: number = 18;
const FONT_BODY: number = 14;
const FONT_LABEL: number = 12;

// Elevation
const SHADOW_RADIUS: number = 8;
const SHADOW_DY: number = 4;
const SHADOW_COLOR: string = '#262E2E5C';

const BOTTOM_BAR_HEIGHT: number = 56;
const FAB_SIZE: number = 56;

const STATIONS: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
const DEPARTURES: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'];

@Entry
@Component
struct RootScreen {
  private canvasContext: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(new RenderingContextSettings(true));

  drawMetro(): void {
    const ctx: CanvasRenderingContext2D = this.canvasContext;
    const width: number = ctx.width;
    const height: number = ctx.height;
    const count: number = STATIONS.length;
    const step: number = width / (count - 1);

    // Draw gradient line
    const gradient: CanvasGradient = ctx.createLinearGradient(0, 0, width, 0);
    gradient.addColorStop(0, SECONDARY);
    gradient.addColorStop(1, PRIMARY);
    ctx.strokeStyle = gradient;
    ctx.lineWidth = 6;
    ctx.beginPath();
    for (let i: number = 0; i < count; i++) {
      const x: number = i * step;
      const y: number = i % 2 === 0 ? height / 4 : (height * 3) / 4;
      if (i === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
    }
    ctx.stroke();

    // Draw station circles
    for (let i: number = 0; i < count; i++) {
      const x: number = i * step;
      const y: number = i % 2 === 0 ? height / 4 : (height * 3) / 4;

      // Outer circle
      ctx.fillStyle = PRIMARY;
      ctx.beginPath();
      ctx.arc(x, y, 16, 0, Math.PI * 2);
      ctx.fill();

      // Inner circle
      ctx.fillStyle = BACKGROUND;
      ctx.beginPath();
      ctx.arc(x, y, 6, 0, Math.PI * 2);
      ctx.fill();
    }
  }

  @Builder
  MetroCanvas() {
    Canvas(this.canvasContext)
      .width('100%')
      .height(260)
      .backgroundColor(SURFACE_VARIANT)
      .borderRadius(CORNER_LARGE)
      .margin({ left: SPACING_LG, right: SPACING_LG })
      .onReady(() => {
        this.drawMetro();
      })
  }

  @Builder
  DepartureRow(departure: string) {
    Row() {
      Text(departure)
        .fontSize(FONT_BODY)
        .fontWeight(FontWeight.Normal)
        .fontColor(ON_SURFACE)
      Blank()
        .layoutWeight(1)
      Text('On Time')
        .fontSize(FONT_LABEL)
        .fontWeight(FontWeight.Medium)
        .fontColor(SUCCESS)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  DeparturesCard() {
    Column({ space: SPACING_SM }) {
      Text('Next Departures')
        .fontSize(FONT_TITLE)
        .fontWeight(FontWeight.Medium)
        .fontColor(SECONDARY)
        .width('100%')
        .textAlign(TextAlign.Start)

      ForEach(DEPARTURES, (departure: string) => {
        this.DepartureRow(departure)
      })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(SPACING_LG)
    .width('100%')
    .backgroundColor(SURFACE)
    .borderRadius(CORNER_LARGE)
    .shadow({
      radius: SHADOW_RADIUS,
      color: SHADOW_COLOR,
      offsetX: 0,
      offsetY: SHADOW_DY,
    })
    .margin({ left: SPACING_LG, right: SPACING_LG })
  }

  @Builder
  FAB() {
    Button('+')
      .fontSize(FONT_TITLE)
      .fontWeight(FontWeight.Medium)
      .fontColor(ON_PRIMARY)
      .width(FAB_SIZE)
      .height(FAB_SIZE)
      .backgroundColor(PRIMARY)
      .borderRadius(FAB_SIZE / 2)
      .onClick(() => {
      })
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Routes')
        .fontSize(FONT_BODY)
        .fontWeight(FontWeight.Normal)
        .fontColor(SECONDARY)
      Blank().layoutWeight(1)
      Text('Planner')
        .fontSize(FONT_BODY)
        .fontWeight(FontWeight.Normal)
        .fontColor(ON_SURFACE)
      Blank().layoutWeight(1)
      Text('Tickets')
        .fontSize(FONT_BODY)
        .fontWeight(FontWeight.Normal)
        .fontColor(ON_SURFACE)
      Blank().layoutWeight(1)
      Text('Profile')
        .fontSize(FONT_BODY)
        .fontWeight(FontWeight.Normal)
        .fontColor(ON_SURFACE)
    }
    .width('100%')
    .height(BOTTOM_BAR_HEIGHT)
    .padding({ left: SPACING_LG, right: SPACING_LG })
    .backgroundColor(SURFACE)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main content with gradient background
      Column({ space: SPACING_LG }) {
        Text('Metro Planner')
          .fontSize(FONT_DISPLAY)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY)
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ left: SPACING_LG, right: SPACING_LG })

        this.MetroCanvas()

        this.DeparturesCard()

        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({
        top: SPACING_LG,
        bottom: BOTTOM_BAR_HEIGHT,
      })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [BACKGROUND, 0.0],
          [SURFACE_VARIANT, 0.5],
          [BACKGROUND, 1.0],
        ],
      })

      // FAB positioned above bottom bar
      Row() {
        Blank().layoutWeight(1)
        this.FAB()
      }
      .width('100%')
      .padding({
        right: SPACING_LG,
        bottom: BOTTOM_BAR_HEIGHT + SPACING_LG,
      })

      // Bottom Bar
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}