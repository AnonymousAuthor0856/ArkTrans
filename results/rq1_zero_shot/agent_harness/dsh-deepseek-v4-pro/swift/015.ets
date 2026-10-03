// Translated from SwiftUI to ArkTS (ArkUI declarative syntax)
// VideoLibraryApp - full screen - Grid card layout

// MARK: - Tokens
class VL {
  static readonly C = {
    primary: "#38BDF8",
    secondary: "#0EA5E9",
    tertiary: "#0369A1",
    background: "#F0F9FF",
    surface: "#FFFFFF",
    surfaceVariant: "#E0F2FE",
    outline: "#BFE0F4",
    success: "#16A34A",
    warning: "#F59E0B",
    error: "#DC2626",
    onPrimary: "#001F2F",
    onSecondary: "#FFFFFF",
    onTertiary: "#FFFFFF",
    onBackground: "#082F49",
    onSurface: "#082F49",
  };
}

class VideoItem {
  id: number;
  title: string;
  duration: string;
  constructor(id: number, title: string, duration: string) {
    this.id = id;
    this.title = title;
    this.duration = duration;
  }
}

@Component
struct VideoLibraryRoot {
  @State showDialog: boolean = false;
  @State selectedVideo: string = "";

  private videos: VideoItem[] = [
    new VideoItem(1, "Nature Documentary", "24:18"),
    new VideoItem(2, "AI Explained", "18:52"),
    new VideoItem(3, "Space Travel", "31:09"),
    new VideoItem(4, "Modern Art Review", "15:45"),
    new VideoItem(5, "Retro Music Visuals", "22:10"),
    new VideoItem(6, "Daily News Recap", "12:34"),
  ];

  build() {
    Stack() {
      Column({ space: 0 }) {
        // ===== Top Spacer =====
        Blank()
          .height(30)

        // ===== Top App Bar =====
        Stack() {
          Stack() {
          }
          .width("100%")
          .height(70)
          .linearGradient({
            angle: 180,
            colors: [[VL.C.surfaceVariant, 0.0], [VL.C.background, 1.0]]
          })

          Text("Video Library")
            .fontSize(26)
            .fontWeight(FontWeight.Semibold)
            .fontColor(VL.C.onSurface)
        }
        .width("100%")
        .height(70)

        // ===== Main Content Area =====
        Column({ space: 0 }) {
          // ===== Subtitle =====
          Text("Explore the latest videos")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(VL.C.onSurface)
            .width("100%")
            .textAlign(TextAlign.Start)
            .padding({ left: 16, right: 16 })
            .padding({ top: 12, bottom: 12 })

          // ===== Video Grid =====
          Scroll() {
            Grid() {
              ForEach(this.videos, (video: VideoItem) => {
                GridItem() {
                  Column({ space: 8 }) {
                    // Thumbnail
                    Stack() {
                      Rect()
                        .width("100%")
                        .height(120)
                        .fill(VL.C.surfaceVariant)
                        .radius(8)
                      Text("Thumbnail")
                        .fontSize(11)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(VL.C.onSurface)
                        .opacity(0.6)
                    }
                    .width("100%")
                    .height(120)

                    // Video Title
                    Text(video.title)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(VL.C.onSurface)
                      .width("100%")
                      .textAlign(TextAlign.Start)
                      .maxLines(2)

                    // Duration
                    Text(video.duration)
                      .fontSize(13)
                      .fontColor(VL.C.onSurface)
                      .opacity(0.7)

                    // Play Button
                    Button() {
                      Text("Play")
                        .fontSize(11)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(VL.C.onPrimary)
                        .width("100%")
                        .height(32)
                    }
                    .width("100%")
                    .height(32)
                    .backgroundColor(VL.C.primary)
                    .borderRadius(8)
                    .onClick(() => {
                      this.selectedVideo = video.title;
                      this.showDialog = true;
                    })
                  }
                  .width("100%")
                  .alignItems(HorizontalAlign.Start)
                  .padding(12)
                  .backgroundColor(VL.C.surface)
                  .borderRadius(12)
                  .shadow({ radius: 2, color: "#0000001A", offsetX: 0, offsetY: 1 })
                }
              }, (video: VideoItem) => video.id.toString())
            }
            .columnsTemplate("1fr 1fr")
            .columnsGap(12)
            .rowsGap(12)
            .padding({ left: 16, right: 16 })
            .padding({ top: 12, bottom: 12 })
          }
          .layoutWeight(1)
        }
        .width("100%")
        .linearGradient({
          angle: 180,
          colors: [[VL.C.surfaceVariant, 0.0], [VL.C.background, 1.0]]
        })
      }
      .width("100%")
      .height("100%")
      .linearGradient({
        angle: 180,
        colors: [[VL.C.surfaceVariant, 0.0], [VL.C.background, 1.0]]
      })

      // Alert dialog equivalent
      if (this.showDialog) {
        Stack() {
          Column({ space: 16 }) {
            Text("Playing Video")
              .fontSize(18)
              .fontWeight(FontWeight.Semibold)
              .fontColor("#000000")
            Text("Now playing: " + this.selectedVideo)
              .fontSize(14)
              .fontColor("#000000")
            Button() {
              Text("OK")
                .fontSize(14)
                .fontColor(VL.C.primary)
            }
            .onClick(() => {
              this.showDialog = false;
            })
          }
          .padding(24)
          .backgroundColor("#FFFFFF")
          .borderRadius(12)
        }
        .width("100%")
        .height("100%")
        .backgroundColor("#00000066")
      }
    }
  }
}

@Entry
@Component
struct Index {
  build() {
    VideoLibraryRoot()
  }
}
