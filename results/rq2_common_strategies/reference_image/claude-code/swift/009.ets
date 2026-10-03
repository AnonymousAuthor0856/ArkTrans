@Entry
@Component
struct VideoPlayerPage {
  private VIDEO_SURFACE_RATIO: number = 0.50;

  @State scale: number = 1.0;

  aboutToAppear(): void {
    let sw = px2vp(display.getWidth());
    let sh = px2vp(display.getHeight());
    this.scale = Math.min(sw / 720.0, sh / 1280.0);
  }

  build() {
    Column() {
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
        .padding({ left: 20 * this.scale, right: 20 * this.scale, top: 10 * this.scale, bottom: 10 * this.scale })
        .textAlign(TextAlign.Start)

      // Progress area
      Column() {
        Row() {
          // Left capsule (played portion)
          Capsule()
            .fill('#1E3A8A')
            .width('40%')
            .height(32 * this.scale)

          // Vertical divider bar
          RoundRect()
            .fill('#1E3A8A')
            .width(6 * this.scale)
            .height(72 * this.scale)
            .radius(3 * this.scale)
            .margin({ left: 18 * this.scale, right: 18 * this.scale })

          // Right track with blue dot
          Stack({ alignContent: Alignment.End }) {
            Capsule()
              .fill('#475569')
              .width('100%')
              .height(32 * this.scale)
            Circle()
              .fill('#1E3A8A')
              .width(12 * this.scale)
              .height(12 * this.scale)
              .margin({ right: 10 * this.scale })
          }
          .width('47%')
          .layoutWeight(1)
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
        .margin({ top: 10 * this.scale })
      }
      .width('100%')
      .padding({ left: 24 * this.scale, right: 24 * this.scale, top: 8 * this.scale, bottom: 6 * this.scale })

      // Control row: -10s / Play / +30s
      Row() {
        // -10s button
        this.TonalButton('−10s')

        // Play button
        Stack() {
          Circle()
            .fill('#1E3A8A')
            .width(120 * this.scale)
            .height(120 * this.scale)
          // Play triangle icon
          Path()
            .commands('M0,0 L40,24 L0,48 Z')
            .fill('#FFFFFF')
            .width(40 * this.scale)
            .height(48 * this.scale)
        }
        .width(120 * this.scale)
        .height(120 * this.scale)
        .margin({ left: 24 * this.scale, right: 24 * this.scale })

        // +30s button
        this.TonalButton('+30s')
      }
      .margin({ top: 10 * this.scale, bottom: 10 * this.scale })

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
        .margin({ top: 12 * this.scale })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
  }

  @Builder
  TonalButton(title: string) {
    Text(title)
      .fontSize(18 * this.scale)
      .fontWeight(FontWeight.SemiBold)
      .fontColor('#1D192B')
      .width(180 * this.scale)
      .height(96 * this.scale)
      .textAlign(TextAlign.Center)
      .backgroundColor('#E8DEF8')
      .borderRadius(18 * this.scale)
  }
}

@Component
struct Capsule {
  @Prop fill: string = '#000000';

  build() {
    Row()
      .width('100%')
      .height('100%')
      .backgroundColor(this.fill)
      .borderRadius(9999)
  }
}

@Component
struct Circle {
  @Prop fill: string = '#000000';

  build() {
    Row()
      .width('100%')
      .height('100%')
      .backgroundColor(this.fill)
      .borderRadius(9999)
  }
}

@Component
struct RoundRect {
  @Prop fill: string = '#000000';
  @Prop radius: number = 0;

  build() {
    Row()
      .width('100%')
      .height('100%')
      .backgroundColor(this.fill)
      .borderRadius(this.radius)
  }
}
