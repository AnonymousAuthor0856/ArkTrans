const PRIMARY: string = '#00FFFF';
const SECONDARY: string = '#00B4FF';
const BACKGROUND: string = '#0A0A1A';
const SURFACE: string = '#141436';
const SURFACE_VARIANT: string = '#1E1E4A';
const SUCCESS: string = '#00FFAA';
const ON_PRIMARY: string = '#0A0A1A';
const ON_SURFACE: string = '#FFFFFF';

interface DepartureItem {
  time: string;
  status: string;
}

@Entry
@Component
struct MetroPlannerPage {
  private readonly stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private readonly departures: DepartureItem[] = [
    { time: '08:45 • Line 1', status: 'On Time' },
    { time: '09:10 • Line 2', status: 'On Time' },
    { time: '09:30 • Line 3', status: 'On Time' }
  ];
  private readonly chartWidth: number = 616;
  private readonly chartHeight: number = 480;
  private readonly canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private readonly canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings);

  private drawMetroLine(): void {
    const ctx = this.canvasContext;
    const width = this.chartWidth;
    const height = this.chartHeight;

    ctx.clearRect(0, 0, width, height);
    ctx.lineWidth = 6;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';

    const gradient = ctx.createLinearGradient(0, 0, width, 0);
    gradient.addColorStop(0, SECONDARY);
    gradient.addColorStop(1, PRIMARY);
    ctx.strokeStyle = gradient;

    const step = width / (this.stations.length - 1);

    ctx.beginPath();
    for (let i = 0; i < this.stations.length; i++) {
      const x = i * step;
      const y = i % 2 === 0 ? height / 4 : height * 3 / 4;
      if (i === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
    }
    ctx.stroke();

    for (let i = 0; i < this.stations.length; i++) {
      const x = i * step;
      const y = i % 2 === 0 ? height / 4 : height * 3 / 4;

      ctx.beginPath();
      ctx.fillStyle = PRIMARY;
      ctx.arc(x, y, 16, 0, Math.PI * 2);
      ctx.fill();

      ctx.beginPath();
      ctx.fillStyle = BACKGROUND;
      ctx.arc(x, y, 6, 0, Math.PI * 2);
      ctx.fill();
    }
  }

  @Builder
  private DeparturesCard(): void {
    Column() {
      Text('Next Departures')
        .fontColor(SECONDARY)
        .fontSize(36)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 10 })

      ForEach(this.departures, (item: DepartureItem) => {
        Row() {
          Text(item.time)
            .fontColor(ON_SURFACE)
            .fontSize(28)
            .fontWeight(FontWeight.Regular)

          Text(item.status)
            .fontColor(SUCCESS)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 8 })
      }, (item: DepartureItem) => item.time)
    }
    .width('100%')
    .padding({ left: 32, right: 32, top: 34, bottom: 34 })
    .backgroundColor(SURFACE)
    .borderRadius(44)
    .shadow({
      radius: 16,
      color: '#2611112A',
      offsetX: 0,
      offsetY: 8
    })
  }

  @Builder
  private BottomNavigation(): void {
    Row() {
      Text('Routes')
        .fontSize(28)
        .fontColor(SECONDARY)
        .fontWeight(FontWeight.Regular)

      Text('Planner')
        .fontSize(28)
        .fontColor(ON_SURFACE)
        .fontWeight(FontWeight.Regular)

      Text('Tickets')
        .fontSize(28)
        .fontColor(ON_SURFACE)
        .fontWeight(FontWeight.Regular)

      Text('Profile')
        .fontSize(28)
        .fontColor(ON_SURFACE)
        .fontWeight(FontWeight.Regular)
    }
    .width('100%')
    .height(160)
    .padding({ left: 40, right: 40, bottom: 12 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(SURFACE)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Column({ space: 32 }) {
          Text('Metro Planner')
            .fontSize(56)
            .fontColor(PRIMARY)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .height(66)
            .lineHeight(66)
            .margin({ top: 4 })

          Stack() {
            Canvas(this.canvasContext)
              .width(this.chartWidth)
              .height(this.chartHeight)
              .onReady(() => {
                this.drawMetroLine();
              })
              .onAreaChange(() => {
                this.drawMetroLine();
              })
          }
            .width('100%')
            .height(520)
            .backgroundColor(SURFACE_VARIANT)
            .borderRadius(44)
            .padding(20)
            .clip(true)

          this.DeparturesCard()

          Blank()
            .height(20)
        }
        .width('100%')
        .height('100%')
        .padding({ left: 32, right: 32, top: 32, bottom: 192 })
        .linearGradient({
          angle: 180,
          colors: [
            [BACKGROUND, 0.0],
            [SURFACE_VARIANT, 0.58],
            [BACKGROUND, 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BACKGROUND)

      Button('+')
        .fontSize(44)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_PRIMARY)
        .width(112)
        .height(112)
        .borderRadius(56)
        .backgroundColor(PRIMARY)
        .position({ right: 32, bottom: 192 })

      this.BottomNavigation()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}
