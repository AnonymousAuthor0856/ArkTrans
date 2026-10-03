// Index.ets

class VideoState {
  title: string = ''
  currentTime: number = 0
  totalTime: number = 0
  playing: boolean = false
  fullscreen: boolean = false
}

function formatTime(sec: number): string {
  const total = Math.max(Math.floor(sec), 0)
  const m = Math.floor(total / 60)
  const s = total % 60
  const ss = s < 10 ? '0' + s.toString() : s.toString()
  return m.toString() + ':' + ss
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
      // Top Bar
      if (!this.state.fullscreen) {
        Row() {
          Text('Video Player')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFE2E8F0')
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FF0F172A')
      }

      // Video Surface
      Stack() {
        Text('Video Surface')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFE2E8F0')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#FF334155')
      .borderRadius(12)
      .alignContent(Alignment.Center)

      // Controls
      Column() {
        // Title
        Text(this.state.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFE2E8F0')
          .width('100%')

        // Slider
        Slider({
          value: this.state.totalTime > 0 ? (this.state.currentTime / this.state.totalTime) * 100 : 0,
          min: 0,
          max: 100,
          step: 0.1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor('#FF475569')
          .selectedColor('#FF1E3A8A')
          .onChange((value: number) => {
            const newState = new VideoState()
            newState.title = this.state.title
            newState.currentTime = (value / 100) * this.state.totalTime
            newState.totalTime = this.state.totalTime
            newState.playing = this.state.playing
            newState.fullscreen = this.state.fullscreen
            this.state = newState
          })

        // Time Row
        Row() {
          Text(formatTime(this.state.currentTime))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(226,232,240,0.7)')
          Text(formatTime(this.state.totalTime))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(226,232,240,0.7)')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        // Playback Controls
        Row() {
          Button('−10s')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFE2E8F0')
            .backgroundColor('#FF1E293B')
            .borderRadius(12)
            .height(40)
            .onClick(() => {
              const newState = new VideoState()
              newState.title = this.state.title
              newState.currentTime = Math.max(this.state.currentTime - 10, 0)
              newState.totalTime = this.state.totalTime
              newState.playing = this.state.playing
              newState.fullscreen = this.state.fullscreen
              this.state = newState
            })

          Button(this.state.playing ? 'II' : '▶')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFFFF')
            .backgroundColor('#FF1E3A8A')
            .borderRadius(36)
            .width(72)
            .height(72)
            .onClick(() => {
              const newState = new VideoState()
              newState.title = this.state.title
              newState.currentTime = this.state.currentTime
              newState.totalTime = this.state.totalTime
              newState.playing = !this.state.playing
              newState.fullscreen = this.state.fullscreen
              this.state = newState
            })

          Button('+30s')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFE2E8F0')
            .backgroundColor('#FF1E293B')
            .borderRadius(12)
            .height(40)
            .onClick(() => {
              const newState = new VideoState()
              newState.title = this.state.title
              newState.currentTime = Math.min(this.state.currentTime + 30, this.state.totalTime)
              newState.totalTime = this.state.totalTime
              newState.playing = this.state.playing
              newState.fullscreen = this.state.fullscreen
              this.state = newState
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)

        // Fullscreen Chip
        Row() {
          Button(this.state.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFE2E8F0')
            .backgroundColor(this.state.fullscreen ? 'rgba(59,130,246,0.2)' : '#FF334155')
            .borderRadius(16)
            .height(32)
            .onClick(() => {
              const newState = new VideoState()
              newState.title = this.state.title
              newState.currentTime = this.state.currentTime
              newState.totalTime = this.state.totalTime
              newState.playing = this.state.playing
              newState.fullscreen = !this.state.fullscreen
              this.state = newState
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FF0F172A')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}