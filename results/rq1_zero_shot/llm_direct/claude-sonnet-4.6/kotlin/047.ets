import { router } from '@kit.ArkUI';

// Design tokens
const AppColors = {
  primary: '#FF8C00',
  secondary: '#FFC107',
  tertiary: '#FFE082',
  background: '#FFF8E1',
  surface: '#FFFFFF',
  surfaceVariant: '#FFECB3',
  outline: '#D7CCC8',
  success: '#4CAF50',
  warning: '#FFB300',
  error: '#E53935',
  onPrimary: '#3E2723',
  onSecondary: '#3E2723',
  onBackground: '#3E2723',
  onSurface: '#3E2723',
};

const AppSpacing = {
  sm: 6,
  md: 10,
  lg: 16,
  xl: 24,
};

interface Pin {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    { x: 150, y: 250, label: 'Group A' },
    { x: 350, y: 420, label: 'Group B' },
    { x: 520, y: 310, label: 'Group C' },
  ];

  addRandomPin() {
    const x = Math.floor(Math.random() * (550 - 100 + 1)) + 100;
    const y = Math.floor(Math.random() * (450 - 150 + 1)) + 150;
    this.pins = [...this.pins, { x, y, label: 'New' }];
  }

  clearPins() {
    this.pins = [];
  }

  build() {
    Scroll() {
      Column({ space: AppSpacing.lg }) {
        // Title
        Text('Retro Group Buy')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .width('100%')

        // Map Card
        Column({ space: AppSpacing.md }) {
          Text('Live Deals Map')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .width('100%')

          // Canvas Map Area
          Stack() {
            Canvas(this.mapRenderingContext)
              .width('100%')
              .height(220)
              .borderRadius(10)
              .backgroundColor(AppColors.surfaceVariant)
              .onReady(() => {
                this.drawMap();
              })
          }
          .width('100%')
          .height(220)
          .borderRadius(10)
          .backgroundColor(AppColors.surfaceVariant)
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(16)
        .shadow({
          radius: 8,
          color: '#26000000',
          offsetX: 0,
          offsetY: 4,
        })

        // Buttons Row
        Row({ space: AppSpacing.md }) {
          Button('Add Group')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(10)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.addRandomPin();
            })

          Button('Clear')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(10)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.clearPins();
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        // Active Groups Card
        Column({ space: AppSpacing.sm }) {
          Text('Active Groups')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .width('100%')

          ForEach(this.pins, (pin: Pin, index: number) => {
            Row() {
              Text(pin.label)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(AppColors.onSurface)

              Circle({ width: 14, height: 14 })
                .fill(AppColors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }, (pin: Pin, index: number) => index.toString())
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(16)
        .shadow({
          radius: 4,
          color: '#1A000000',
          offsetX: 0,
          offsetY: 2,
        })
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .scrollBar(BarState.Off)
  }

  private mapRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  drawMap() {
    const ctx = this.mapRenderingContext;
    if (!ctx) return;

    ctx.clearRect(0, 0, ctx.width, ctx.height);

    // Background
    ctx.fillStyle = AppColors.surfaceVariant;
    ctx.fillRect(0, 0, ctx.width, ctx.height);

    // Draw pins
    this.pins.forEach((pin: Pin) => {
      ctx.beginPath();
      ctx.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = AppColors.primary;
      ctx.fill();
      ctx.closePath();
    });
  }
}