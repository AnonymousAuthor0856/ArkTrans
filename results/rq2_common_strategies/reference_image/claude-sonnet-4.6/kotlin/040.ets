// Index.ets — ArkTS conversion of the Compose "Retro Filter Search" screen

import { window } from '@kit.ArkUI';

/* ------------------------------- Design tokens ------------------------------ */

class AppColors {
  static readonly primary: string = '#FF7B00';
  static readonly secondary: string = '#FFD166';
  static readonly background: string = '#FFF6E5';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFF0C1';
  static readonly outline: string = '#E0C080';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#3E2723';
  static readonly onBackground: string = '#3E2723';
  static readonly onSurface: string = '#3E2723';
  static readonly onSurfaceMuted: string = '#663E2723'; // onSurface @ 40%
  static readonly shadowTint: string = '#1F000000';     // black @ 12%
}

class AppType {
  static readonly displaySize: number = 28;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

class AppRadius {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppElevation {
  static readonly level2: ShadowOptions = {
    radius: 8,
    color: '#1F000000',
    offsetX: 0,
    offsetY: 4
  };
}

class ResultItem {
  readonly id: number;
  readonly title: string;

  constructor(id: number, title: string) {
    this.id = id;
    this.title = title;
  }
}

/* --------------------------------- Screen ---------------------------------- */

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State knobX: number = 160;
  @State knobY: number = 120;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private filters: string[] = ['Popular', 'New', 'Discount', 'Premium'];

  private results: ResultItem[] = [
    new ResultItem(0, 'Result 1'),
    new ResultItem(1, 'Result 2'),
    new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'),
    new ResultItem(4, 'Result 5'),
    new ResultItem(5, 'Result 6')
  ];

  aboutToAppear(): void {
    // Immersive mode — counterpart of WindowInsetsControllerCompat.hide(systemBars())
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  private drawScene(): void {
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    const cx: number = w / 2;
    const cy: number = h / 2;

    this.ctx.clearRect(0, 0, w, h);

    // drawRect(color = surfaceVariant)
    this.ctx.fillStyle = AppColors.surfaceVariant;
    this.ctx.fillRect(0, 0, w, h);

    // drawCircle(radialGradient([secondary, primary]), r = 80, center)
    const gradient: CanvasGradient = this.ctx.createRadialGradient(cx, cy, 0, cx, cy, 80);
    gradient.addColorStop(0, AppColors.secondary);
    gradient.addColorStop(1, AppColors.primary);
    this.ctx.fillStyle = gradient;
    this.ctx.beginPath();
    this.ctx.arc(cx, cy, 80, 0, Math.PI * 2);
    this.ctx.closePath();
    this.ctx.fill();

    // drawCircle(color = primary, r = 16, center = knob)
    this.ctx.fillStyle = AppColors.primary;
    this.ctx.beginPath();
    this.ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2);
    this.ctx.closePath();
    this.ctx.fill();
  }

  private moveKnob(event: GestureEvent): void {
    if (event.fingerList.length > 0) {
      this.knobX = event.fingerList[0].localX;
      this.knobY = event.fingerList[0].localY;
      this.drawScene();
    }
  }

  @Builder
  FilterChip(label: string) {
    Button(label)
      .type(ButtonType.Normal)
      .height(36)
      .borderRadius(AppRadius.small)
      .backgroundColor(AppColors.secondary)
      .fontColor(AppColors.onSecondary)
      .fontSize(AppType.labelSize)
      .fontWeight(FontWeight.Medium)
  }

  @Builder
  ResultCard(item: ResultItem) {
    Column({ space: AppSpacing.sm }) {
      Column()
        .width(96)
        .height(96)
        .borderRadius(AppRadius.medium)
        .backgroundColor(AppColors.surfaceVariant)

      Text(item.title)
        .fontSize(AppType.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Button('Add')
        .type(ButtonType.Normal)
        .width('100%')
        .height(40)
        .borderRadius(AppRadius.medium)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .fontSize(AppType.labelSize)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow(AppElevation.level2)
  }

  build() {
    Column({ space: AppSpacing.md }) {

      // Title — displayLarge
      Text('Retro Filter Search')
        .fontSize(AppType.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .width('100%')

      // Search field
      TextInput({ placeholder: 'Search products', text: this.query })
        .width('100%')
        .height(56)
        .fontSize(AppType.bodySize)
        .fontColor(AppColors.onSurface)
        .placeholderColor(AppColors.onSurfaceMuted)
        .placeholderFont({ size: AppType.bodySize })
        .caretColor(AppColors.primary)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppRadius.medium)
        .border({ width: { bottom: 1 }, color: AppColors.outline })
        .onChange((value: string) => {
          this.query = value;
        })

      // Filter chips
      Scroll() {
        Row({ space: AppSpacing.sm }) {
          ForEach(this.filters, (label: string) => {
            this.FilterChip(label)
          }, (label: string) => label)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .height(36)

      // Canvas panel
      Column() {
        Canvas(this.ctx)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawScene();
          })
          .gesture(
            PanGesture({ fingers: 1, distance: 1 })
              .onActionStart((event: GestureEvent) => {
                this.moveKnob(event);
              })
              .onActionUpdate((event: GestureEvent) => {
                this.moveKnob(event);
              })
          )
      }
      .width('100%')
      .height(180)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppRadius.large)

      // Result grid
      Grid() {
        ForEach(this.results, (item: ResultItem) => {
          GridItem() {
            this.ResultCard(item);
          }
        }, (item: ResultItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.lg)
      .rowsGap(AppSpacing.lg)
      .padding({ bottom: 24 })
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}