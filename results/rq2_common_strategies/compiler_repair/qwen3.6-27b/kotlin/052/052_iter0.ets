import { Tabs, TabContent, TabRow } from '@kit.ArkUI'
import { Color, FontSize, FontWeight, LengthUnit } from '@kit.ArkUI'

// AppTokens equivalent constants
const COLORS = {
  primary: '#111111',
  secondary: '#444444',
  background: '#F5F5F5',
  surface: '#FFFFFF',
  outline: '#CCCCCC',
  onPrimary: '#FFFFFF',
  onSurface: '#111111'
}

const TYPOGRAPHY = {
  display: { fontSize: 28, fontWeight: FontWeight.Bold },
  headline: { fontSize: 18, fontWeight: FontWeight.SemiBold },
  body: { fontSize: 14, fontWeight: FontWeight.Normal }
}

const SHAPES = {
  small: 6,
  medium: 10,
  large: 14
}

const SPACING = {
  sm: 8,
  md: 12,
  lg: 16
}

@Entry
@Component
struct CourseCatalog {
  @State currentIndex: number = 0
  private tabs: string[] = ['All', 'Enrolled', 'Completed']

  build() {
    Column() {
      // Header
      Text('Course Catalog')
        .font-size(TYPOGRAPHY.display.fontSize)
        .fontWeight(TYPOGRAPHY.display.fontWeight)
        .fontColor(COLORS.primary)
        .margin({ top: SPACING.md })

      // Tabs
      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          TabContent() {
            CourseList(
              tab === 'All' ? 'All Courses' : tab,
              tab === 'All' ? 6 : tab === 'Enrolled' ? 3 : 4
            )
          }
          .tabBar(
            Text(tab)
              .font-size(index === this.currentIndex ? TYPOGRAPHY.headline.fontSize : TYPOGRAPHY.body.fontSize)
              .fontWeight(index === this.currentIndex ? TYPOGRAPHY.headline.fontWeight : TYPOGRAPHY.body.fontWeight)
              .fontColor(index === this.currentIndex ? COLORS.primary : COLORS.secondary)
              .textAlign(TextAlign.Center)
          )
        })
      }
      .barMode(BarMode.Fixed)
      .barBackground(Color.WHITE)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
    .padding({ left: SPACING.lg, right: SPACING.lg, top: SPACING.md, bottom: SPACING.md })
  }
}

@Component
struct CourseList {
  @Prop title: string
  @Prop count: number

  build() {
    Column() {
      Text(this.title)
        .font-size(TYPOGRAPHY.headline.fontSize)
        .fontWeight(TYPOGRAPHY.headline.fontWeight)
        .fontColor(COLORS.secondary)
        .margin({ top: SPACING.md, bottom: SPACING.sm })

      List({ space: SPACING.md }) {
        ForEach(Array.from({ length: this.count }), (_: any, index: number) => {
          ListItem() {
            Row() {
              Column() {
                Text(`Course ${index + 1}`)
                  .font-size(TYPOGRAPHY.headline.fontSize)
                  .fontWeight(TYPOGRAPHY.headline.fontWeight)
                  .fontColor(COLORS.primary)
                
                Text(`Duration: ${5 + index} hrs`)
                  .font-size(TYPOGRAPHY.body.fontSize)
                  .fontWeight(TYPOGRAPHY.body.fontWeight)
                  .fontColor(COLORS.secondary)
                  .margin({ top: SPACING.sm })
              }
              .layoutWeight(1)

              Button('View')
                .backgroundColor(COLORS.primary)
                .fontColor(COLORS.onPrimary)
                .borderRadius(12)
                .height(24)
                .width(60)
                .fontSize(TYPOGRAPHY.body.fontSize)
            }
            .width('100%')
            .padding(SPACING.md)
            .backgroundColor(COLORS.surface)
            .borderRadius(SHAPES.medium)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
  }
}