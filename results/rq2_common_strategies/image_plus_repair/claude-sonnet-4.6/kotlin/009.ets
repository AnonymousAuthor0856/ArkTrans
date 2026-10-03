// Index.ets
import { router } from '@kit.ArkUI'

interface VideoState {
  title: string
  currentTime: number
  totalTime: number
  playing: boolean
  fullscreen: boolean
}

function formatTime(sec: number): string {
  const total = Math.max(0, Math.floor(sec))
  const m = Math.floor(total / 60)
  const s = total % 60
  return `${m}:${s.toString().padStart(2, '0')}`
}

@Entry
@Component
struct RootScreen {
  @State state: VideoState = {
    title: 'Journey through the Skies',
    currentTime: 95,
    totalTime: 240,
    playing: false,
    fullscreen: false
  }

  build() {
    Column() {
      if (!this.state.fullscreen) {
        Row() {
          Text('Video Player')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F8FAFC')
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#0F172A')
      }

      Column() {
        // Video surface area
        Stack() {
          Text('Video Surface')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#334155')
        .borderRadius(12)
        .alignContent(Alignment.Center)

        // Controls area
        Column({ space: 12 }) {
          Text(this.state.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .width('100%')

          // Slider
          Slider({
            value: this.state.currentTime / this.state.totalTime * 100,
            min: 0,
            max: 100,
            step: 0.1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .trackColor('#475569')
            .selectedColor('#1E3A8A')
            .blockColor('#1E3A8A')
            .onChange((value: number) => {
              this.state = {
                title: this.state.title,
                currentTime: value / 100 * this.state.totalTime,
                totalTime: this.state.totalTime,
                playing: this.state.playing,
                fullscreen: this.state.fullscreen
              }
            })

          // Time labels
          Row() {
            Text(formatTime(this.state.currentTime))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#9BB3C8')
            Text(formatTime(this.state.totalTime))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#9BB3C8')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          // Playback controls
          Row({ space: 0 }) {
            Button('-10s')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#E2E8F0')
              .backgroundColor('#1E293B')
              .borderRadius(12)
              .height(48)
              .padding({ left: 20, right: 20 })
              .onClick(() => {
                this.state = {
                  title: this.state.title,
                  currentTime: Math.max(0, this.state.currentTime - 10),
                  totalTime: this.state.totalTime,
                  playing: this.state.playing,
                  fullscreen: this.state.fullscreen
                }
              })

            Button(this.state.playing ? 'II' : '▶')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .backgroundColor('#1E3A8A')
              .borderRadius(36)
              .width(72)
              .height(72)
              .onClick(() => {
                this.state = {
                  title: this.state.title,
                  currentTime: this.state.currentTime,
                  totalTime: this.state.totalTime,
                  playing: !this.state.playing,
                  fullscreen: this.state.fullscreen
                }
              })

            Button('+30s')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#E2E8F0')
              .backgroundColor('#1E293B')
              .borderRadius(12)
              .height(48)
              .padding({ left: 20, right: 20 })
              .onClick(() => {
                this.state = {
                  title: this.state.title,
                  currentTime: Math.min(this.state.totalTime, this.state.currentTime + 30),
                  totalTime: this.state.totalTime,
                  playing: this.state.playing,
                  fullscreen: this.state.fullscreen
                }
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center)

          // Fullscreen toggle
          Row() {
            Button(this.state.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#E2E8F0')
              .backgroundColor(this.state.fullscreen ? '#1E3A8A33' : 'transparent')
              .borderRadius(20)
              .height(40)
              .padding({ left: 16, right: 16 })
              .border({ width: 1, color: '#475569' })
              .onClick(() => {
                this.state = {
                  title: this.state.title,
                  currentTime: this.state.currentTime,
                  totalTime: this.state.totalTime,
                  playing: this.state.playing,
                  fullscreen: !this.state.fullscreen
                }
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }
        .width('100%')
        .padding(24)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#0F172A')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
  }
}