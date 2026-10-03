import display from '@ohos.display';

@Entry
@Component
struct VideoPlayerPage {
  @State scale: number = 1.0;

  aboutToAppear(): void {
    let displayInfo = display.getDefaultDisplaySync();
    let sw = px2vp(displayInfo.width);
    let sh = px2vp(displayInfo.height);
    this.scale = Math.min(sw / 720.0, sh / 1280.0);
  }

  build() {
    Column({ space: 10 }) {
      // Top title
      Text('Video Player')
        .fontSize(18 * this.scale)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#E2E8F0')
        .height(56 * this.scale)
        .padding({ top: 12 * this.scale, bottom: 12 * this.scale })

      // Video Surface
      Stack() {
        Text('Video Surface')
          .fontSize(16 * this.scale)
          .fontWeight(FontWeight.Medium)
          .fontColor('rgba(226,232,240,0.9)')
      }
      .width('100%')
      .height(300 * this.scale)
      .backgroundColor('#334155')
      .borderRadius(24 * this.scale)
      .padding({ right: 10 * this.scale })

      // Video title
      Text('Journey through the Skies')
        .fontSize(18 * this.scale)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#E0E8F0')
        .width('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .textAlign(TextAlign.Start)

      // Progress area
      Column({ space: 10 * this.scale }) {
        Row({ space: 18 * this.scale }) {
          Blank()

          // Left capsule (played portion)
          Row()
            .width('40%')
            .height(32 * this.scale)
            .backgroundColor('#1E3A8A')
            .borderRadius(9999)

          // Vertical divider bar
          Row()
            .width(6 * this.scale)
            .height(72 * this.scale)
            .backgroundColor('#1E3A8A')
            .borderRadius(3 * this.scale)

          // Right track with blue dot
          Stack({ alignContent: Alignment.End }) {
            Row()
              .width('100%')
              .height(32 * this.scale)
              .backgroundColor('#475569')
              .borderRadius(9999)
            Row()
              .width(12 * this.scale)
              .height(12 * this.scale)
              .backgroundColor('#1E3A8A')
              .borderRadius(9999)
              .margin({ right: 10 * this.scale })
          }
          .width('47%')

          Blank()
        }
        .width('100%')

        // Time labels
        Row() {
          Text('1:35')
            .fontSize(12 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor('#A3AAB5')
            .padding({ left: 10 * this.scale })
          Blank()
          Text('4:00')
            .fontSize(12 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor('#A3AAB5')
            .padding({ right: 10 * this.scale })
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: 24 * this.scale, right: 24 * this.scale, top: 8 * this.scale, bottom: 6 * this.scale })

      // Control row: -10s / Play / +30s
      Row({ space: 24 * this.scale }) {
        // -10s button
        Text('−10s')
          .fontSize(18 * this.scale)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#1D192B')
          .width(180 * this.scale)
          .height(96 * this.scale)
          .textAlign(TextAlign.Center)
          .backgroundColor('#E8DEF8')
          .borderRadius(18 * this.scale)

        // Play button (circle with play triangle)
        Stack() {
          Row()
            .width(120 * this.scale)
            .height(120 * this.scale)
            .backgroundColor('#1E3A8A')
            .borderRadius(9999)
          // Play triangle
          Polygon()
            .points([[0, 0], [40, 24], [0, 48]])
            .fill('#FFFFFF')
            .width(40 * this.scale)
            .height(48 * this.scale)
        }
        .width(120 * this.scale)
        .height(120 * this.scale)

        // +30s button
        Text('+30s')
          .fontSize(18 * this.scale)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#1D192B')
          .width(180 * this.scale)
          .height(96 * this.scale)
          .textAlign(TextAlign.Center)
          .backgroundColor('#E8DEF8')
          .borderRadius(18 * this.scale)
      }
      .padding({ top: 10 * this.scale, bottom: 10 * this.scale })

      // Fullscreen button (outlined)
      Button('Fullscreen')
        .fontSize(18 * this.scale)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#47434E')
        .width(220 * this.scale)
        .height(64 * this.scale)
        .backgroundColor(Color.Transparent)
        .borderRadius(12 * this.scale)
        .border({ width: 1, color: '#475569' })
        .padding({ top: 12 * this.scale })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
  }
}
