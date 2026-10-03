// AppTokens: Design tokens for Monochrome Education UI
class AppTokens {
  static readonly Colors = {
    primary: '#111111',
    secondary: '#444444',
    background: '#F5F5F5',
    surface: '#FFFFFF',
    outline: '#CCCCCC',
    onPrimary: '#FFFFFF',
    onSurface: '#111111'
  };
  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal }
  };
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };
  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16
  };
  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 }
  };
}

@Component
export struct CourseList {
  @Prop title: string;
  @Prop count: number;

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text(this.title)
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.secondary)
        .margin({ bottom: 4 })

      ForEach(Array.from({ length: this.count }, (_, i) => i + 1), (item: number) => {
        Row() {
          Column({ space: AppTokens.Spacing.sm }) {
            Text(`Course ${item}`)
              .fontSize(AppTokens.TypographyTokens.headline.fontSize)
              .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
              .fontColor(AppTokens.Colors.primary)
            Text(`Duration: ${4 + item} hrs`)
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
            .borderRadius(AppTokens.Shapes.small)
            .padding({ left: 12, right: 12, top: 4, bottom: 4 })
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        })
      }, (item: number) => item.toString())
    }
    .width('100%')
  }
}

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0;
  private tabs: string[] = ['All', 'Enrolled', 'Completed'];
  private swiperController: SwiperController = new SwiperController();

  build() {
    Column() {
      Column() {
        Text('Course Catalog')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: 16 })

        // TabRow equivalent
        Row() {
          ForEach(this.tabs, (title: string, index: number) => {
            Text(title)
              .fontSize(this.currentIndex === index ? AppTokens.TypographyTokens.headline.fontSize : AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(this.currentIndex === index ? AppTokens.TypographyTokens.headline.fontWeight : AppTokens.TypographyTokens.body.fontWeight)
              .fontColor(this.currentIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
              .padding({ top: 8, bottom: 8, left: 16, right: 16 })
              .borderBottomWidth(this.currentIndex === index ? 2 : 0)
              .borderColor(AppTokens.Colors.primary)
              .onClick(() => {
                this.swiperController.changeIndex(index);
              })
          }, (title: string) => title)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .borderBottomWidth(1)
        .borderColor(AppTokens.Colors.outline)
        .margin({ bottom: 16 })

        // HorizontalPager equivalent
        Swiper(this.swiperController) {
          CourseList({ title: 'All Courses', count: 6 })
          CourseList({ title: 'Enrolled', count: 3 })
          CourseList({ title: 'Completed', count: 4 })
        }
        .index(this.currentIndex)
        .indicator(false)
        .loop(false)
        .onChange((index: number) => {
          this.currentIndex = index;
        })
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}