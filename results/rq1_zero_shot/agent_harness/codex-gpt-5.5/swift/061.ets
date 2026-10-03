class AppColors {
  static primary: string = '#111827';
  static secondary: string = '#374151';
  static tertiary: string = '#6B7280';
  static background: string = '#F9FAFB';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E5E7EB';
  static outline: string = '#D1D5DB';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onBackground: string = '#111827';
  static onSurface: string = '#1F2937';
}

class AppSpacing {
  static sm: number = 6;
  static md: number = 10;
  static lg: number = 14;
  static xl: number = 22;
}

class ParcelPoint {
  x: string;
  y: string;

  constructor(x: string, y: string) {
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct RootScreen {
  @State private dragX: string = '54%';
  @State private dragY: string = '48%';
  private parcelPoints: ParcelPoint[] = [
    new ParcelPoint('8%', '18%'), new ParcelPoint('16%', '62%'), new ParcelPoint('24%', '35%'),
    new ParcelPoint('31%', '78%'), new ParcelPoint('39%', '22%'), new ParcelPoint('46%', '58%'),
    new ParcelPoint('53%', '12%'), new ParcelPoint('61%', '72%'), new ParcelPoint('68%', '30%'),
    new ParcelPoint('75%', '51%'), new ParcelPoint('83%', '20%'), new ParcelPoint('90%', '70%'),
    new ParcelPoint('12%', '42%'), new ParcelPoint('28%', '13%'), new ParcelPoint('35%', '50%'),
    new ParcelPoint('44%', '86%'), new ParcelPoint('57%', '41%'), new ParcelPoint('66%', '83%'),
    new ParcelPoint('72%', '10%'), new ParcelPoint('87%', '38%'), new ParcelPoint('6%', '82%'),
    new ParcelPoint('19%', '24%'), new ParcelPoint('49%', '68%'), new ParcelPoint('79%', '60%'),
    new ParcelPoint('94%', '15%')
  ];

  @Builder
  private ParcelCanvas() {
    Stack() {
      ForEach(this.parcelPoints, (point: ParcelPoint) => {
        Circle()
          .width(8)
          .height(8)
          .fill(AppColors.secondary)
          .position({ x: point.x, y: point.y })
      })

      Circle()
        .width(40)
        .height(40)
        .fill(Color.Transparent)
        .stroke(AppColors.primary)
        .strokeWidth(3)
        .position({ x: this.dragX, y: this.dragY })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.dragX = `${Math.max(10, Math.min(90, 50 + event.offsetX / 3))}%`;
              this.dragY = `${Math.max(10, Math.min(90, 50 + event.offsetY / 3))}%`;
            })
        )

      Text('Drag to locate parcel')
        .fontSize(12)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(300)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .border({ width: 1, color: AppColors.outline })
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
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
