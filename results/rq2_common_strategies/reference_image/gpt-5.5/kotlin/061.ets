interface ParcelPoint {
  x: number;
  y: number;
}

class AppColors {
  static readonly primary: string = '#111827';
  static readonly secondary: string = '#374151';
  static readonly tertiary: string = '#6B7280';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
}

@Entry
@Component
struct ParcelTrackerPage {
  @State private dragCenterX: number = 10;
  @State private dragCenterY: number = 10;
  private readonly canvasWidth: number = 332;
  private readonly canvasHeight: number = 300;
  private panStartX: number = 10;
  private panStartY: number = 10;

  private readonly parcelPoints: ParcelPoint[] = [
    { x: 50, y: 13 },
    { x: 50, y: 29 },
    { x: 135, y: 12 },
    { x: 210, y: 18 },
    { x: 208, y: 38 },
    { x: 181, y: 37 },
    { x: 180, y: 40 },
    { x: 44, y: 57 },
    { x: 15, y: 78 },
    { x: 54, y: 78 },
    { x: 60, y: 83 },
    { x: 75, y: 82 },
    { x: 73, y: 95 },
    { x: 103, y: 86 },
    { x: 183, y: 86 },
    { x: 185, y: 111 },
    { x: 112, y: 119 },
    { x: 180, y: 123 },
    { x: 192, y: 128 },
    { x: 201, y: 128 },
    { x: 35, y: 139 },
    { x: 24, y: 152 },
    { x: 65, y: 144 },
    { x: 71, y: 149 },
    { x: 146, y: 154 }
  ];

  private clamp(value: number, minValue: number, maxValue: number): number {
    return Math.max(minValue, Math.min(maxValue, value));
  }

  @Builder
  private ParcelCanvas() {
    Stack({ alignContent: Alignment.Center }) {
      ForEach(
        this.parcelPoints,
        (point: ParcelPoint) => {
          Circle({ width: 4, height: 4 })
            .fill(AppColors.secondary)
            .position({ x: point.x, y: point.y });
        },
        (point: ParcelPoint) => `${point.x}_${point.y}`
      )

      Circle({ width: 20, height: 20 })
        .fill(Color.Transparent)
        .stroke(AppColors.primary)
        .strokeWidth(1.5)
        .position({
          x: this.dragCenterX - 10,
          y: this.dragCenterY - 10
        });

      Text('Drag to locate parcel')
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface);
    }
    .width('100%')
    .height(300)
    .backgroundColor(AppColors.surface)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: 16
    })
    .gesture(
      PanGesture()
        .onActionStart(() => {
          this.panStartX = this.dragCenterX;
          this.panStartY = this.dragCenterY;
        })
        .onActionUpdate((event: GestureEvent) => {
          this.dragCenterX = this.clamp(this.panStartX + event.offsetX, 0, this.canvasWidth);
          this.dragCenterY = this.clamp(this.panStartY + event.offsetY, 0, this.canvasHeight);
        })
    );
  }

  build() {
    Column({ space: 22 }) {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center);

      this.ParcelCanvas();

      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center);
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.surfaceVariant, 0.0],
        [AppColors.background, 1.0]
      ]
    });
  }
}