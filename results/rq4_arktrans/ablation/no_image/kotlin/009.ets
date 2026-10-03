@Entry
@Component
struct Index {
  @State currentTime: number = 0
  @State totalTime: number = 100
  @State playing: boolean = false
  @State fullscreen: boolean = false
  @State title: string = 'Sample Video Title'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        // === Box (Video Surface) ===
        Stack({ alignContent: Alignment.Center }) {
          Text('Video Surface')
            .fontColor('#E2E8F0')
            .fontSize(16)
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#1E293B') // MaterialTheme.colorScheme.surfaceVariant approx

        // === Controls Column ===
        Column({ space: 12 }) {
          // Title
          Text(this.title)
            .fontColor('#E2E8F0')
            .fontSize(16)

          // Slider
          Slider({
            value: this.totalTime > 0 ? this.currentTime / this.totalTime : 0,
            min: 0,
            max: 1,
            step: 1
          })
            .width('100%')
            .trackThickness(4)
            .selectedColor('#3B82F6') // Primary
            .color('#64748B') // Outline
            .onChange((value: number) => {
              this.currentTime = Math.round(value * this.totalTime);
            })

          // Time Row
          Row({ space: 0 }) {
            Text(this.formatTime(this.currentTime))
              .fontColor('#E2E8F0')
              .fontSize(12)
            Blank()
            Text(this.formatTime(this.totalTime))
              .fontColor('#E2E8F0')
              .fontSize(12)
          }.width('100%')

          // Playback Controls Row
          Row({ space: 0 }) {
            // -10s Button
            Button('−10s')
              .type(ButtonType.Capsule)
              .backgroundColor('#1E293B')
              .fontColor('#E2E8F0')
              .onClick(() => {
                this.currentTime = Math.max(0, this.currentTime - 10);
              })

            Blank()

            // Play/Pause Button
            Button(this.playing ? 'II' : '▶')
              .type(ButtonType.Circle)
              .backgroundColor('#3B82F6')
              .fontColor('#FFFFFF')
              .width(72)
              .height(72)
              .fontSize(24)
              .onClick(() => {
                this.playing = !this.playing;
              })

            Blank()

            // +30s Button
            Button('+30s')
              .type(ButtonType.Capsule)
              .backgroundColor('#1E293B')
              .fontColor('#E2E8F0')
              .onClick(() => {
                this.currentTime = Math.min(this.totalTime, this.currentTime + 30);
              })
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceEvenly)
          .width('100%')

          // Fullscreen Chip Row
          Row({ space: 0 }) {
            Button(
              this.fullscreen ? 'Exit Fullscreen' : 'Fullscreen',
              {
                type: ButtonType.Capsule,
                stateEffect: true
              }
            )
            .backgroundColor(this.fullscreen ? '#60A5FA' : '#1E293B')
            .fontColor('#E2E8F0')
            .onClick(() => {
              this.fullscreen = !this.fullscreen;
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }
        .width('100%')
        .padding(24)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#0F172A') // MaterialTheme.colorScheme.background

      // Top App Bar
      Row() {
        Text('Video Player')
          .fontColor('#E2E8F0')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#0F172A')
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
  }

  private formatTime(seconds: number): string {
    const mins = Math.floor(seconds / 60);
    const secs = Math.floor(seconds % 60);
    return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
  }
}