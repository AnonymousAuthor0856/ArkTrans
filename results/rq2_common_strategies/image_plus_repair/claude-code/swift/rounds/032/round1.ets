@Entry
@Component
struct TransferWizardPage {
  @State progress: number = 0.4;
  private markerX: number = 200;
  private markerY: number = 400;

  build() {
    Stack() {
      // Background vertical gradient: secondary(20%) -> background -> primary(20%)
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          colors: [
            ['#33FFC300', 0.0],
            ['#FFFBF2', 0.5],
            ['#33FFA500', 1.0]
          ],
          direction: GradientDirection.Bottom
        })

      Column({ space: 0 }) {
        // Top App Bar
        Stack() {
          Column()
            .width('100%')
            .height(56)
            .backgroundColor('#FFFBF2')

          Text('Transfer Wizard')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E1E1E')
        }
        .width('100%')

        // Main content area
        Stack() {
          // Canvas area with large circle + marker circle
          Stack() {
            // Large background circle (radius 260, centered)
            Circle()
              .width(520)
              .height(520)
              .fill('#FFEED6')

            // Marker circle (radius 20, at position 200, 400)
            Circle()
              .width(40)
              .height(40)
              .fill('#FFA500')
              .position({ x: this.markerX - 20, y: this.markerY - 20 })
          }
          .width('100%')
          .height('100%')
          .padding(24)

          // Bottom overlay: title, progress bar, buttons
          Column({ space: 16 }) {
            Text('Transfer Progress')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1E1E1E')

            // Custom linear progress bar
            Stack({ alignContent: Alignment.Start }) {
              // Track
              Row()
                .width('100%')
                .height(8)
                .backgroundColor('#FFEED6')
                .borderRadius(4)

              // Progress fill
              Row()
                .width(`${this.progress * 100}%`)
                .height(8)
                .backgroundColor('#FFA500')
                .borderRadius(4)
            }
            .width('80%')

            // Button row
            Row({ space: 12 }) {
              // "+" button - primary color
              Button('+')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .width(64)
                .height(64)
                .backgroundColor('#FFA500')
                .borderRadius(32)
                .onClick(() => {
                  this.progress = Math.min(this.progress + 0.1, 1.0);
                })

              // "-" button - secondary color
              Button('-')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1E1E1E')
                .width(64)
                .height(64)
                .backgroundColor('#FFC300')
                .borderRadius(32)
                .onClick(() => {
                  this.progress = Math.max(this.progress - 0.1, 0.0);
                })
            }
          }
          .width('100%')
          .height('100%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.End)
          .padding({ bottom: 32 })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFBF2')
  }
}
