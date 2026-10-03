import { LengthMetrics } from '@kit.ArkUI'

interface VideoItem {
  title: string;
  duration: string;
}

const videos: VideoItem[] = [
  { title: "Nature Documentary", duration: "24:18" },
  { title: "AI Explained", duration: "18:52" },
  { title: "Space Travel", duration: "31:09" },
  { title: "Modern Art Review", duration: "15:45" },
  { title: "Retro Music Visuals", duration: "22:10" },
  { title: "Daily News Recap", duration: "12:34" }
];

// Color tokens
const colorPrimary = '#FF38BDF8';
const colorSecondary = '#FF0EA5E9';
const colorTertiary = '#FF0369A1';
const colorBackground = '#FFF0F9FF';
const colorSurface = '#FFFFFFFF';
const colorSurfaceVariant = '#FFE0F2FE';
const colorOutline = '#FFBFE0F4';
const colorOnPrimary = '#FF001F2F';
const colorOnSurface = '#FF082F49';

@Entry
@Component
struct Index {
  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Video Library")
          .fontSize(26)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(56)
      .backgroundColor(colorBackground)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 16, right: 16 })

      // Main content
      Column() {
        Text("Explore the latest videos")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnSurface)
          .margin({ bottom: 12 })

        // Grid of videos
        Grid() {
          ForEach(videos, (item: VideoItem) => {
            GridItem() {
              VideoCard({ item: item })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[0xFFE0F2FE, 0.0], [0xFFF0F9FF, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorBackground)
  }
}

@Component
struct VideoCard {
  item: VideoItem = { title: '', duration: '' };

  build() {
    Column({ space: 8 }) {
      // Thumbnail placeholder
      Stack() {
        Text("Thumbnail")
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99082F49')
      }
      .width('100%')
      .height(120)
      .backgroundColor(colorSurfaceVariant)
      .borderRadius(8)
      .alignContent(Alignment.Center)

      // Title
      Text(this.item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(colorOnSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')

      // Duration
      Text(this.item.duration)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .fontColor('#B3082F49')
        .width('100%')

      // Play button
      Button("Play")
        .width('100%')
        .height(40)
        .backgroundColor(colorPrimary)
        .fontColor(colorOnPrimary)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .borderRadius(8)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(colorSurface)
    .borderRadius(12)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
    .alignItems(HorizontalAlign.Start)
  }
}