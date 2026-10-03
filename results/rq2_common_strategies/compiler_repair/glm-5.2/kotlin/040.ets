// Index.ets
import { Length, ResourceStr } from '@ohos.arkui.theme';
import { FrameNode } from '@ohos.arkui.node';

class AppColors {
  static primary: ResourceColor = 0xFFFF7B00;
  static secondary: ResourceColor = 0xFFFFD166;
  static background: ResourceColor = 0xFFFFF6E5;
  static surface: ResourceColor = 0xFFFFFFFF;
  static surfaceVariant: ResourceColor = 0xFFFFF0C1;
  static outline: ResourceColor = 0xFFE0C080;
  static onPrimary: ResourceColor = 0xFFFFFFFF;
  static onSecondary: ResourceColor = 0xFF3E2723;
  static onBackground: ResourceColor = 0xFF3E2723;
  static onSurface: ResourceColor = 0xFF3E2723;
}

class AppShapes {
  static small: number = 6;
  static medium: number = 10;
  static large: number = 14;
}

class AppSpacing {
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
}

class ResultItem {
  id: number;
  title: string;

  constructor(id: number, title: string) {
    this.id = id;
    this.title = title;
  }
}

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State knobX: number = 160;
  @State knobY: number = 120;
  private results: ResultItem[] = [
    new ResultItem(0, 'Result 1'),
    new ResultItem(1, 'Result 2'),
    new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'),
    new ResultItem(4, 'Result 5'),
    new ResultItem(5, 'Result 6')
  ];
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Column() {
      // Title
      Text('Retro Filter Search')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .margin({ bottom: AppSpacing.md })

      // Search Field
      TextInput({ text: this.query, placeholder: 'Search products' })
        .onChange((value: string) => {
          this.query = value;
        })
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .height(48)
        .margin({ bottom: AppSpacing.md })

      // Filter Buttons
      Row({ space: AppSpacing.sm }) {
        ForEach(['Popular', 'New', 'Discount', 'Premium'], (item: string) => {
          Button(item)
            .height(36)
            .backgroundColor(AppColors.secondary)
            .fontColor(AppColors.onSecondary)
            .fontSize(12)
            .borderRadius(AppShapes.small)
        })
      }
      .margin({ bottom: AppSpacing.md })

      // Canvas Box
      Stack() {
        Canvas(this.context)
          .width('100%')
          .height(180)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .onReady(() => {
            this.drawCanvas();
          })
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                this.knobX = event.fingerList[0].localX;
                this.knobY = event.fingerList[0].localY;
                this.drawCanvas();
              })
          )
      }
      .margin({ bottom: AppSpacing.md })

      // Grid
      Grid() {
        ForEach(this.results, (item: ResultItem) => {
          GridItem() {
            Column() {
              // Image Placeholder
              Column()
                .width(96)
                .height(96)
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.medium)
                .margin({ bottom: AppSpacing.sm })

              Text(item.title)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
                .margin({ bottom: AppSpacing.sm })

              Button('Add')
                .width('100%')
                .backgroundColor(AppColors.primary)
                .fontColor(AppColors.onPrimary)
                .fontSize(12)
                .borderRadius(AppShapes.medium)
            }
            .padding(AppSpacing.lg)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.large)
            .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.lg)
      .rowsGap(AppSpacing.lg)
      .padding({ bottom: 24 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background)
  }

  private drawCanvas() {
    const ctx = this.context;
    const w = 300;
    const h = 180;
    ctx.clearRect(0, 0, w, h);

    // Background
    ctx.fillStyle = AppColors.surfaceVariant as string;
    ctx.fillRect(0, 0, w, h);

    // Radial Gradient Circle
    const gradient = ctx.createRadialGradient(w / 2, h / 2, 10, w / 2, h / 2, 80);
    gradient.addColorStop(0, AppColors.secondary as string);
    gradient.addColorStop(1, AppColors.primary as string);
    ctx.fillStyle = gradient;
    ctx.beginPath();
    ctx.arc(w / 2, h / 2, 80, 0, Math.PI * 2);
    ctx.fill();

    // Knob
    ctx.fillStyle = AppColors.primary as string;
    ctx.beginPath();
    ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2);
    ctx.fill();
  }
}