const NAME: string = "096_ParcelTracker_en";
const UI_TYPE: string = "Tools Dashboard";
const STYLE_THEME: string = "Monochrome";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#111827';
  static readonly secondary: string = '#374151';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
}

class AppSpacing {
  static readonly lg: number = 14;
  static readonly xl: number = 22;
}

class ParcelPoint {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct MainActivity {
  @State locatorX: number = 46;
  @State locatorY: number = 58;

  private points: ParcelPoint[] = [
    new ParcelPoint(11, 18), new ParcelPoint(24, 42), new ParcelPoint(38, 26), new ParcelPoint(52, 64), new ParcelPoint(69, 30),
    new ParcelPoint(83, 52), new ParcelPoint(15, 76), new ParcelPoint(32, 68), new ParcelPoint(47, 36), new ParcelPoint(61, 80),
    new ParcelPoint(74, 15), new ParcelPoint(88, 72), new ParcelPoint(20, 22), new ParcelPoint(36, 54), new ParcelPoint(58, 48),
    new ParcelPoint(80, 34), new ParcelPoint(7, 58), new ParcelPoint(27, 84), new ParcelPoint(44, 12), new ParcelPoint(66, 68),
    new ParcelPoint(91, 22), new ParcelPoint(13, 36), new ParcelPoint(55, 88), new ParcelPoint(72, 44), new ParcelPoint(39, 78)
  ];

  private advanceLocator(): void {
    this.locatorX = (this.locatorX + 17) % 90 + 5;
    this.locatorY = (this.locatorY + 23) % 84 + 8;
  }

  @Builder
  ParcelCanvas() {
    Stack() {
      ForEach(this.points, (point: ParcelPoint) => {
        Circle()
          .width(8)
          .height(8)
          .fill(AppColors.secondary)
          .position({ x: `${point.x}%`, y: `${point.y}%` })
      })

      Circle()
        .width(40)
        .height(40)
        .fill(Color.Transparent)
        .stroke(AppColors.primary)
        .strokeWidth(3)
        .position({ x: `${this.locatorX}%`, y: `${this.locatorY}%` })

      Text('Drag to locate parcel')
        .fontSize(12)
        .fontColor(AppColors.onSurface)
        .align(Alignment.Center)
    }
    .width('100%')
    .height(300)
    .padding(10)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.advanceLocator();
    })
  }

  build() {
    Column({ space: AppSpacing.xl }) {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      this.ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [[AppColors.surfaceVariant, 0.0], [AppColors.background, 1.0]]
    })
  }
}
