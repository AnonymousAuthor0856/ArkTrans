class ParcelPoint {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

class ParcelColors {
  static readonly primary: string = '#111827';
  static readonly secondary: string = '#374151';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
}

@Entry
@Component
struct Index {
  @State trackerX: number = 150;
  @State trackerY: number = 120;
  private points: ParcelPoint[] = [
    new ParcelPoint(22, 34), new ParcelPoint(64, 92), new ParcelPoint(104, 54), new ParcelPoint(142, 160), new ParcelPoint(184, 86),
    new ParcelPoint(228, 204), new ParcelPoint(266, 66), new ParcelPoint(304, 128), new ParcelPoint(42, 214), new ParcelPoint(88, 246),
    new ParcelPoint(126, 118), new ParcelPoint(166, 236), new ParcelPoint(208, 32), new ParcelPoint(248, 164), new ParcelPoint(292, 224),
    new ParcelPoint(18, 152), new ParcelPoint(58, 268), new ParcelPoint(112, 202), new ParcelPoint(154, 42), new ParcelPoint(196, 146),
    new ParcelPoint(236, 254), new ParcelPoint(274, 98), new ParcelPoint(316, 186), new ParcelPoint(334, 44), new ParcelPoint(344, 246)
  ];

  private clamp(value: number, minValue: number, maxValue: number): number {
    if (value < minValue) {
      return minValue;
    }
    if (value > maxValue) {
      return maxValue;
    }
    return value;
  }

  @Builder
  ParcelCanvas() {
    Stack({ alignContent: Alignment.Center }) {
      ForEach(this.points, (point: ParcelPoint, index: number) => {
        Circle()
          .width(8)
          .height(8)
          .fill(ParcelColors.secondary)
          .position({ x: point.x, y: point.y })
      }, (point: ParcelPoint, index: number) => index.toString())

      Circle()
        .width(40)
        .height(40)
        .fill('#00FFFFFF')
        .stroke(ParcelColors.primary)
        .strokeWidth(3)
        .position({ x: this.trackerX, y: this.trackerY })

      Text('Drag to locate parcel')
        .fontSize(12)
        .fontColor(ParcelColors.onSurface)
        .backgroundColor('#CCFFFFFF')
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .borderRadius(6)
    }
    .width('100%')
    .height(300)
    .backgroundColor(ParcelColors.surface)
    .borderRadius(16)
    .border({ width: 1, color: ParcelColors.outline })
    .gesture(
      PanGesture()
        .onActionUpdate((event: GestureEvent) => {
          this.trackerX = this.clamp(this.trackerX + event.offsetX, 0, 320);
          this.trackerY = this.clamp(this.trackerY + event.offsetY, 0, 260);
        })
    )
  }

  build() {
    Column() {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(ParcelColors.onBackground)
        .margin({ bottom: 22 })

      this.ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontColor(ParcelColors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 22 })
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[ParcelColors.surfaceVariant, 0.0], [ParcelColors.background, 1.0]]
    })
  }
}
