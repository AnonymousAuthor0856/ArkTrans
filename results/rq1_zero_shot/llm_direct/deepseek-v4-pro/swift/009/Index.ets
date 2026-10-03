@Entry
@Component
struct VideoPlayerApp {
  build() {
    Stack() {
      VideoPlayerRoot()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
  }
}

@Component
struct VideoPlayerRoot {
  private readonly VIDEO_SURFACE_RATIO: number = 0.50

  private readonly COLORS = {
    primary: '#1E3A8A',
    background: '#0F172A',
    surface: '#1E293B',
    surfaceVariant: '#334155',
    outline: '#475569',
    onSurface: '#E2E8F0',
    chip: '#E8DEF8'
  }

  build() {
    Stack() {
      Column({ space: 10 }) {
        // Top title
        Text('Video Player')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
          .height(56)
          .padding({ top: 12, bottom: 12 })

        // Video Surface
        Row() {
          Stack() {
            RoundedRectangle({ width: '100%', height: 300 })
              .fill(this.COLORS.surfaceVariant)
              .radius(24)
            Text('Video Surface')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#E2E8F0')
              .opacity(0.9)
          }
          .width('100%')
          .height(300)
        }
        .width('100%')
        .padding({ right: 10 })

        // Movie title
        Text('Journey through the Skies')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E8F0')
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })

        // Progress area
        Column({ space: 10 }) {
          Row({ space: 18 }) {
            Blank()
            // Left capsule
            Row() {
              Blank()
            }
            .width('40%')
            .height(32)
            .backgroundColor(this.COLORS.primary)
            .borderRadius(16)

            // Vertical bar
            Row() {
              Blank()
            }
            .width(6)
            .height(72)
            .backgroundColor(this.COLORS.primary)
            .borderRadius(3)

            // Right track with dot
            Stack({ alignContent: Alignment.End }) {
              Row() {
                Blank()
              }
              .width('47%')
              .height(32)
              .backgroundColor('#475569')
              .borderRadius(16)

              Circle()
                .width(12)
                .height(12)
                .fill(this.COLORS.primary)
                .margin({ right: 10 })
            }
            .width('47%')
            .height(32)

            Blank()
          }
          .width('100%')

          // Time labels
          Row() {
            Text('1:35')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#A3AAB5')
              .margin({ left: 10 })
            Blank()
            Text('4:00')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#A3AAB5')
              .margin({ right: 10 })
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 8, bottom: 6 })

        // Control area
        Row({ space: 24 }) {
          // -10s button
          Text('-10s')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1D192B')
            .width(180)
            .height(96)
            .backgroundColor(this.COLORS.chip)
            .borderRadius(18)
            .textAlign(TextAlign.Center)

          // Play button
          Stack() {
            Circle()
              .width(120)
              .height(120)
              .fill(this.COLORS.primary)
            Text('▶')
              .fontSize(40)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
          .width(120)
          .height(120)

          // +30s button
          Text('+30s')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1D192B')
            .width(180)
            .height(96)
            .backgroundColor(this.COLORS.chip)
            .borderRadius(18)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 10, bottom: 10 })

        // Fullscreen button
        Button() {
          Text('Fullscreen')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#47434E')
            .width(220)
            .height(64)
            .textAlign(TextAlign.Center)
        }
        .width(220)
        .height(64)
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: this.COLORS.outline, radius: 12 })
        .margin({ top: 12 })

        Blank()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.COLORS.background)
    }
    .width('100%')
    .height('100%')
  }
}