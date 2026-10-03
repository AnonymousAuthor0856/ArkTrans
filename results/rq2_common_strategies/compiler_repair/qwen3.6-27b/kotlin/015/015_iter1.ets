import { BusinessError } from '@kit.BasicServicesKit'

// Token Definitions matching Kotlin AppTokens
const AppTokens: {
  Colors: Record<string, string>;
  Spacing: Record<string, number>;
  Shapes: Record<string, number>;
} = {
  Colors: {
    primary: '#38BDF8',
    secondary: '#0EA5E9',
    tertiary: '#0369A1',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BFE0F4',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626',
    onPrimary: '#001F2F',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#082F49',
    onSurface: '#082F49'
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 20
  }
}

interface VideoItem {
  title: string;
  duration: string;
}

@Entry
@Component
struct RootScreen {
  @State videos: VideoItem[] = [
    { title: "Nature Documentary", duration: "24:18" },
    { title: "AI Explained", duration: "18:52" },
    { title: "Space Travel", duration: "31:09" },
    { title: "Modern Art Review", duration: "15:45" },
    { title: "Retro Music Visuals", duration: "22:10" },
    { title: "Daily News Recap", duration: "12:34" }
  ];

  build() {
    Column() {
      // Top Bar Area
      Row() {
        Text("Video Library")
          .fontSize(26)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)

      // Main Content Area
      Column() {
        Text("Explore the latest videos")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: AppTokens.Spacing.md })

        VideoGrid({ items: this.videos })
          .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      // Vertical Gradient Background
      .linearGradient({
        angle: 90,
        colors: [['#E0F2FE', 0], ['#F0F9FF', 1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct VideoGrid {
  @Link items: VideoItem[]

  build() {
    Grid() {
      ForEach(this.items, (item: VideoItem) => {
        GridItem() {
          VideoCard({ item: item })
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(AppTokens.Spacing.md)
    .columnsGap(AppTokens.Spacing.md)
    .width('100%')
    .height('100%')
  }
}

@Component
struct VideoCard {
  @Prop item: VideoItem

  build() {
    Column() {
      // Thumbnail Placeholder
      Row() {
        Text("Thumbnail")
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .height(120)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text(this.item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.item.duration)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .fontColor('#B3082F49') // Approximate alpha 0.7 of onSurface
        .margin({ top: 2 })

      Button("Play")
        .type(ButtonType.Capsule)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .height(40)
        .width('100%')
        .margin({ top: AppTokens.Spacing.sm })
        .onClick(() => {
          // Play action
        })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    // Shadow simulation for elevation level 1
    .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.12)', offsetY: 2 })
  }
}

@Entry
@Component
struct MainEntry {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}