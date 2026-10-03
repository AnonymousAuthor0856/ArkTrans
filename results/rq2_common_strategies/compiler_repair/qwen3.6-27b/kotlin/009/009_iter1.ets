import { window } from '@kit.ArkUI'

// App Tokens and Constants
const NAME = "003VideoPlayeren"
const UI_TYPE = "Media"
const STYLE_THEME = "Modern Blue"
const LANG = "en"
const BASELINE_SIZE = "720x1280"

interface VideoState {
  title: string;
  currentTime: number;
  totalTime: number;
  playing: boolean;
  fullscreen: boolean;
}

@Entry
@Component
struct RootScreen {
  @State state: VideoState = {
    title: "Journey through the Skies",
    currentTime: 95,
    totalTime: 240,
    playing: false,
    fullscreen: false
  };

  build() {
    Column() {
      // Top Bar
      if (!this.state.fullscreen) {
        Row() {
          Text("Video Player")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#0F172A')
      }

      // Main Content Area
      Column() {
        // Video Surface Placeholder
        Column() {
          Text("Video Surface")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
        }
        .layoutWeight(1)
        .width('100%')
        .backgroundColor('#334155')
        .borderRadius(12)
        .margin({ left: 24, right: 24 })

        // Controls Section
        Column() {
          // Title
          Text(this.state.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .margin({ top: 24, bottom: 12 })

          // Slider
          Slider({ value: this.state.currentTime / this.state.totalTime, min: 0, max: 1, step: 0.01 })
            .width('100%')
            .trackColor('#475569')
            .selectedColor('#1E3A8A')
            .blockColor('#1E3A8A')
            .onChange((value: number) => {
              this.state.currentTime = Math.round(value * this.state.totalTime);
            })

          // Time Labels
          Row() {
            Text(this.formatTime(this.state.currentTime))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color('#E2E8F0').withAlpha(0.7))
            
            Blank()
            
            Text(this.formatTime(this.state.totalTime))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color('#E2E8F0').withAlpha(0.7))
          }
          .width('100%')
          .margin({ top: 8 })

          // Playback Controls
          Row() {
            Button("-10s")
              .type(ButtonType.Capsule)
              .backgroundColor('#334155')
              .fontColor('#E2E8F0')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {
                this.state.currentTime = Math.max(0, this.state.currentTime - 10);
              })

            Button(this.state.playing ? "II" : "▶")
              .type(ButtonType.Circle)
              .backgroundColor('#1E3A8A')
              .fontColor('#FFFFFF')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .width(72)
              .height(72)
              .onClick(() => {
                this.state.playing = !this.state.playing;
              })

            Button("+30s")
              .type(ButtonType.Capsule)
              .backgroundColor('#334155')
              .fontColor('#E2E8F0')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {
                this.state.currentTime = Math.min(this.state.totalTime, this.state.currentTime + 30);
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .margin({ top: 16 })

          // Fullscreen Toggle
          Row() {
            Button(this.state.fullscreen ? "Exit Fullscreen" : "Fullscreen")
              .type(ButtonType.Capsule)
              .backgroundColor(this.state.fullscreen ? Color('#3B82F6').withAlpha(0.2) : '#334155')
              .fontColor('#E2E8F0')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {
                this.state.fullscreen = !this.state.fullscreen;
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: 16, bottom: 24 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
  }

  private formatTime(sec: number): string {
    const total = Math.max(0, Math.floor(sec));
    const m = Math.floor(total / 60);
    const s = total % 60;
    return `${m}:${s < 10 ? '0' : ''}${s}`;
  }
}