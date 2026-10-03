// Index.ets

interface TextStyleSpec {
  fontSize: number;
  fontWeight: number;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#111111',
    secondary: '#444444',
    background: '#F5F5F5',
    surface: '#FFFFFF',
    outline: '#CCCCCC',
    onPrimary: '#FFFFFF',
    onSurface: '#111111'
  };

  static readonly TypographyTokens: Record<string, TextStyleSpec> = {
    display: { fontSize: 28, fontWeight: 700 },
    headline: { fontSize: 18, fontWeight: 600 },
    body: { fontSize: 14, fontWeight: 400 }
  };

  static readonly Spacing: Record<string, number> = {
    sm: 8,
    md: 12,
    lg: 16
  };

  static readonly ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 }
  };
}

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0;
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];

  build() {
    Column() {
      Text('Course Catalog')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.primary)
        .margin({ bottom: AppTokens.Spacing.md })
        .width('100%')

      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
        ForEach(this.tabs, (title: string, index: number) => {
          TabContent() {
            if (index === 0) {
              CourseList({ title: 'All Courses', count: 6 })
            } else if (index === 1) {
              CourseList({ title: 'Enrolled', count: 3 })
            } else {
              CourseList({ title: 'Completed', count: 4 })
            }
          }
          .tabBar(this.TabBuilder(title, index))
        }, (title: string) => title)
      }
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .barMode(BarMode.Fixed)
      .barWidth('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  TabBuilder(title: string, index: number) {
    Column() {
      Text(title)
        .fontSize(this.currentIndex === index ? AppTokens.TypographyTokens.headline.fontSize : AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(this.currentIndex === index ? AppTokens.TypographyTokens.headline.fontWeight : AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(this.currentIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
        .margin({ top: 8, bottom: 8 })
      Divider()
        .strokeWidth(2)
        .color(AppTokens.Colors.primary)
        .opacity(this.currentIndex === index ? 1 : 0)
        .width('100%')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct CourseList {
  @Prop title: string;
  @Prop count: number;

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text(this.title)
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.secondary)
        .width('100%')

      ForEach(Array.from({ length: this.count }, (_, i: number) => i), (it: number) => {
        Row() {
          Column({ space: AppTokens.Spacing.sm }) {
            Text(`Course ${it + 1}`)
              .fontSize(AppTokens.TypographyTokens.headline.fontSize)
              .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
              .fontColor(AppTokens.Colors.primary)
            Text(`Duration: ${5 + it} hrs`)
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
              .fontColor(AppTokens.Colors.secondary)
          }
          .alignItems(HorizontalAlign.Start)

          Text('View')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(12)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: 6, bottom: 6 })
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(10)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }, (it: number) => it.toString())
    }
    .width('100%')
    .height('100%')
  }
}