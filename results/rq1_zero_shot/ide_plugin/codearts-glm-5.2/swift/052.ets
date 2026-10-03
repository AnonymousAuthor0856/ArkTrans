class AppTokens {
  static readonly Colors = {
    primary: '#FF111111',
    secondary: '#FF444444',
    background: '#FFF5F5F5',
    surface: '#FFFFFFFF',
    outline: '#FFCCCCCC',
    onPrimary: '#FFFFFFFF',
    onSurface: '#FF111111',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
  }
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  }
  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
  }
}

@Component
struct CourseCard {
  @Prop courseNumber: number

  build() {
    Row() {
      Column({ space: AppTokens.Spacing.sm }) {
        Text(`Course ${this.courseNumber}`)
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.primary)

        Text(`Duration: ${4 + this.courseNumber} hrs`)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('View')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: 12, right: 12 })
        .height(24)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(12)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedTabIndex: number = 0
  private tabs: string[] = ['All', 'Enrolled', 'Completed']
  private counts: number[] = [6, 3, 4]

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.md }) {
        Text('Course Catalog')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')

        Row() {
          ForEach(this.tabs, (tab: string, index: number) => {
            Column() {
              Text(tab)
                .fontSize(this.selectedTabIndex === index ? AppTokens.Typography.headline.size : AppTokens.Typography.body.size)
                .fontWeight(this.selectedTabIndex === index ? AppTokens.Typography.headline.weight : AppTokens.Typography.body.weight)
                .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
                .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })

              if (this.selectedTabIndex === index) {
                Column()
                  .width('100%')
                  .height(2)
                  .backgroundColor(AppTokens.Colors.primary)
              } else {
                Column()
                  .width('100%')
                  .height(2)
              }
            }
            .layoutWeight(1)
            .onClick(() => {
              this.selectedTabIndex = index
            })
          })
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            Text(this.tabs[this.selectedTabIndex])
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.secondary)

            ForEach(this.counts[this.selectedTabIndex], (index: number) => {
              CourseCard({ courseNumber: index + 1 })
            }, (index: number) => `${this.selectedTabIndex}_${index}`)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}