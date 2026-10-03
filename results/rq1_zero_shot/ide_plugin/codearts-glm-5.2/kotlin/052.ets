const NAME = '076*CourseCatalog*en'
const UI_TYPE = 'Education'
const STYLE_THEME = 'Monochrome'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#111111',
    secondary: '#444444',
    background: '#F5F5F5',
    surface: '#FFFFFF',
    outline: '#CCCCCC',
    onPrimary: '#FFFFFF',
    onSurface: '#111111',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
  }

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  }

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
  }
}

@Entry
@Component
struct RootScreen {
  @State currentTab: number = 0
  private tabs: string[] = ['All', 'Enrolled', 'Completed']

  build() {
    Column() {
      Text('Course Catalog')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.primary)

      Tabs({ barPosition: BarPosition.Start, index: this.currentTab }) {
        ForEach(this.tabs, (title: string, index: number) => {
          TabContent() {
            CourseList({ title: index === 0 ? 'All Courses' : title, count: index === 0 ? 6 : index === 1 ? 3 : 4 })
          }
          .tabBar(this.TabBuilder(index, title))
        }, (title: string, index: number) => index.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.currentTab = index
      })
    }
    .width('100%')
    .height('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  TabBuilder(index: number, title: string) {
    Column() {
      Text(title)
        .fontSize(this.currentTab === index ? AppTokens.TypographyTokens.headline.fontSize : AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(this.currentTab === index ? AppTokens.TypographyTokens.headline.fontWeight : AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(this.currentTab === index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
    }
    .width('100%')
    .height(48)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct CourseList {
  private title: string = ''
  private count: number = 0

  build() {
    Column() {
      Text(this.title)
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.secondary)

      List() {
        ForEach(Array.from({ length: this.count }, (_, i) => i), (i: number) => {
          ListItem() {
            CourseCard({ index: i })
          }
        }, (i: number) => i.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct CourseCard {
  private index: number = 0

  build() {
    Row() {
      Column() {
        Text(`Course ${this.index + 1}`)
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.primary)

        Text(`Duration: ${5 + this.index} hrs`)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ top: AppTokens.Spacing.sm })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('View')
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .height(24)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(12)
        .padding({ left: 12, right: 12 })
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetY: AppTokens.ElevationMapping.level1.dy })
    .margin({ bottom: AppTokens.Spacing.md })
  }
}