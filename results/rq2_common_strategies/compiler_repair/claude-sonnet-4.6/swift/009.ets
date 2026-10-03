function hexToColor(hex: number): string {
  const r = (hex >> 16) & 0xFF;
  const g = (hex >> 8) & 0xFF;
  const b = hex & 0xFF;
  return `rgb(${r},${g},${b})`;
}

@Entry
@Component
struct VideoPlayerRoot {
  build() {
    Stack() {
      Column({ space: 10 }) {
        // Title
        Text('Video Player')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(hexToColor(0xe2e8f0))
          .height(56)
          .padding({ top: 12, bottom: 12 })

        // Video Surface
        Stack() {
          Column()
            .width('100%')
            .height(300)
            .backgroundColor(hexToColor(0x334155))
            .borderRadius(24)

          Text('Video Surface')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(226,232,240,0.9)')
        }
        .width('100%')
        .height(300)
        .borderRadius(24)
        .clip(true)
        .padding({ right: 10 })

        // Title text
        Text('Journey through the Skies')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(hexToColor(0xe0e8f0))
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })

        // Progress area
        Column({ space: 10 }) {
          Row({ space: 18 }) {
            Blank()
            // Left capsule (progress filled)
            Column()
              .width('38%')
              .height(32)
              .backgroundColor(hexToColor(0x1E3A8A))
              .borderRadius(16)

            // Vertical bar
            Column()
              .width(6)
              .height(72)
              .backgroundColor(hexToColor(0x1E3A8A))
              .borderRadius(3)

            // Right track with dot
            Stack({ alignContent: Alignment.End }) {
              Column()
                .width('100%')
                .height(32)
                .backgroundColor(hexToColor(0x475569))
                .borderRadius(16)

              Row() {
                Circle()
                  .width(12)
                  .height(12)
                  .fill(hexToColor(0x1E3A8A))
              }
              .margin({ right: 10 })
            }
            .width('45%')
            .height(32)

            Blank()
          }
          .width('100%')

          // Time labels
          Row() {
            Text('1:35')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(hexToColor(0xa3aab5))
              .margin({ left: 10 })
            Blank()
            Text('4:00')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(hexToColor(0xa3aab5))
              .margin({ right: 10 })
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 8, bottom: 6 })
        .alignItems(HorizontalAlign.Start)

        // Controls: -10s / Play / +30s
        Row({ space: 24 }) {
          // -10s button
          Text('−10s')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(hexToColor(0x1d192b))
            .width(80)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor(hexToColor(0xE8DEF8))
            .borderRadius(18)

          // Play button
          Stack() {
            Circle()
              .width(72)
              .height(72)
              .fill(hexToColor(0x1E3A8A))

            Text('▶')
              .fontSize(28)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
          }
          .width(72)
          .height(72)

          // +30s button
          Text('+30s')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(hexToColor(0x1d192b))
            .width(80)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor(hexToColor(0xE8DEF8))
            .borderRadius(18)
        }
        .padding({ top: 10, bottom: 10 })
        .justifyContent(FlexAlign.Center)
        .width('100%')

        // Fullscreen ghost button
        Stack() {
          Text('Fullscreen')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(hexToColor(0x47434e))
            .width(220)
            .height(56)
            .textAlign(TextAlign.Center)
            .border({
              width: 1,
              color: hexToColor(0x475569),
              radius: 12,
              style: BorderStyle.Solid
            })
        }
        .margin({ top: 12 })
        .height(56)

        Blank()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(hexToColor(0x0F172A))
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(hexToColor(0x0F172A))
  }
}