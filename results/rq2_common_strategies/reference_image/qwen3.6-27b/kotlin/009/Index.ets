// App.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct VideoPlayerApp {
  @State videoState: VideoState = new VideoState(
    "Journey through the Skies",
    95,
    240,
    false,
    false
  );

  build() {
    Column() {
      // Top Bar
      if (!this.videoState.fullscreen) {
        Text("Video Player")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 20, bottom: 20 })
      }

      // Main Content
      Column() {
        // Video Surface
        Row() {
          Text("Video Surface")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .width('100%')
        .height('50%')
        .backgroundColor('#334155')
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        // Controls Section
        Column() {
          // Title
          Text(this.videoState.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .margin({ top: 24, bottom: 12 })

          // Progress Slider
          Slider({
            value: this.videoState.currentTime / this.videoState.totalTime,
            min: 0,
            max: 1,
            step: 0.01
          })
            .width('100%')
            .trackColor('#475569')
            .selectedColor('#1E3A8A')
            .blockColor('#1E3A8A')
            .onChange((value: number) => {
              this.videoState.currentTime = Math.round(value * this.videoState.totalTime);
            })

          // Time Display
          Row() {
            Text(this.formatTime(this.videoState.currentTime))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#E2E8F0')
              .opacity(0.7)
            
            Blank()
            
            Text(this.formatTime(this.videoState.totalTime))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#E2E8F0')
              .opacity(0.7)
          }
          .width('100%')
          .margin({ top: 8, bottom: 16 })

          // Control Buttons
          Row() {
            // -10s Button
            Button("-10s")
              .type(ButtonType.Capsule)
              .backgroundColor('#E2E8F0')
              .fontColor('#1E293B')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .width(100)
              .height(48)
              .onClick(() => {
                this.videoState.currentTime = Math.max(0, this.videoState.currentTime - 10);
              })

            // Play/Pause Button
            Button(this.videoState.playing ? "II" : "▶")
              .type(ButtonType.Circle)
              .backgroundColor('#1E3A8A')
              .fontColor(Color.White)
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .width(72)
              .height(72)
              .margin({ left: 16, right: 16 })
              .onClick(() => {
                this.videoState.playing = !this.videoState.playing;
              })

            // +30s Button
            Button("+30s")
              .type(ButtonType.Capsule)
              .backgroundColor('#E2E8F0')
              .fontColor('#1E293B')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .width(100)
              .height(48)
              .onClick(() => {
                this.videoState.currentTime = Math.min(this.videoState.totalTime, this.videoState.currentTime + 30);
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .margin({ top: 16, bottom: 16 })

          // Fullscreen Button
          Button(this.videoState.fullscreen ? "Exit Fullscreen" : "Fullscreen")
            .type(ButtonType.Capsule)
            .backgroundColor('transparent')
            .borderWidth(1)
            .borderColor('#475569')
            .fontColor('#E2E8F0')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .width(120)
            .height(40)
            .onClick(() => {
              this.videoState.fullscreen = !this.videoState.fullscreen;
            })
        }
        .width('100%')
        .padding(24)
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
  }

  private formatTime(seconds: number): string {
    const total = Math.max(0, Math.floor(seconds));
    const minutes = Math.floor(total / 60);
    const secs = total % 60;
    return `${minutes}:${secs.toString().padStart(2, '0')}`;
  }
}

class VideoState {
  title: string;
  currentTime: number;
  totalTime: number;
  playing: boolean;
  fullscreen: boolean;

  constructor(title: string, currentTime: number, totalTime: number, playing: boolean, fullscreen: boolean) {
    this.title = title;
    this.currentTime = currentTime;
    this.totalTime = totalTime;
    this.playing = playing;
    this.fullscreen = fullscreen;
  }
}