class MapColors {
  static primary: string = '#60A5FA';
  static secondary: string = '#93C5FD';
  static tertiary: string = '#A5B4FC';
  static background: string = '#F9FAFB';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#EFF6FF';
  static outline: string = '#D1D5DB';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#111827';
}

@Entry
@Component
struct Index {
  @State markerX: number = 200;
  @State markerY: number = 400;

  @Builder
  MapPanel() {
    Stack() {
      Circle()
        .width(340)
        .height(340)
        .fill('#3393C5FD')
      Circle()
        .width(220)
        .height(220)
        .fill('#4D93C5FD')
      Circle()
        .width(60)
        .height(60)
        .fill('#4D60A5FA')
        .stroke(MapColors.primary)
        .strokeWidth(3)
        .position({ x: this.markerX - 30, y: this.markerY - 30 })
      Circle()
        .width(28)
        .height(28)
        .fill(MapColors.primary)
        .position({ x: this.markerX - 14, y: this.markerY - 14 })
    }
    .width('100%')
    .height(400)
    .backgroundColor('#CCFFFFFF')
    .border({ width: 1, color: MapColors.outline, radius: 24 })
    .borderRadius(24)
  }

  build() {
    Column() {
      Text('Favorite Spots Map')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(MapColors.onSurface)
        .lineHeight(34)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(MapColors.background)

      Stack({ alignContent: Alignment.Center }) {
        Column() {
          this.MapPanel()
        }
        .width('100%')
        .padding(16)

        Column({ space: 12 }) {
          Text('Spot Coordinates: (' + this.markerX.toString() + ', ' + this.markerY.toString() + ')')
            .fontSize(14)
            .fontColor(MapColors.onSurface)
            .lineHeight(20)
          Button('Save Marker')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(MapColors.onPrimary)
            .backgroundColor(MapColors.primary)
            .borderRadius(16)
            .height(48)
            .width('100%')
        }
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 16 })
        .alignItems(HorizontalAlign.Center)
        .align(Alignment.Bottom)
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(MapColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(MapColors.background)
  }
}
