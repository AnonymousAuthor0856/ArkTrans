interface Homework {
  id: number
  title: string
  status: string
}

interface ChartData {
  id: number
  label: string
  progress: number
}

class AppColors {
  static readonly primary: ResourceColor = '#0EA5E9'
  static readonly secondary: ResourceColor = '#6366F1'
  static readonly tertiary: ResourceColor = '#06B6D4'
  static readonly background: ResourceColor = '#F1F5F9'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#E2E8F0'
  static readonly outline: ResourceColor = '#D1D5DB'
  static readonly success: ResourceColor = '#10B981'
  static readonly warning: ResourceColor = '#F59E0B'
  static readonly error: ResourceColor = '#EF4444'
  static readonly onPrimary: ResourceColor = '#FFFFFF'
  static readonly onSecondary: ResourceColor = '#FFFFFF'
  static readonly onTertiary: ResourceColor = '#0F172A'
  static readonly onBackground: ResourceColor = '#1E293B'
  static readonly onSurface: ResourceColor = '#1E293B'
}

class AppTypography {
  static readonly displaySize: number = 26
  static readonly headlineSize: number = 18
  static readonly titleSize: number = 14
  static readonly bodySize: number = 12
  static readonly labelSize: number = 11
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 20
  static readonly xxl: number = 28
}

@Entry
@Component
struct RootScreen {
  private works: Homework[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' }
  ]

  @State charts: ChartData[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 }
  ]

  build() {
    Column() {
      Row() {
        Text('Homework Submit')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Assignments')
            .fontSize(AppTypography.headlineSize)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .width('100%')

          Grid() {
            ForEach(this.works, (w: Homework) => {
              GridItem() {
                Column() {
                  Blank()

                  Stack()
                    .width(40)
                    .height(40)
                    .backgroundColor(AppColors.tertiary)
                    .borderRadius(AppShapes.small)

                  Blank()
                    .height(AppSpacing.sm)

                  Text(w.title)
                    .fontSize(AppTypography.titleSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)
                    .textAlign(TextAlign.Center)
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  Text(w.status)
                    .fontSize(AppTypography.labelSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)
                    .textAlign(TextAlign.Center)

                  Blank()
                }
                .width('100%')
                .aspectRatio(1)
                .padding(AppSpacing.md)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .backgroundColor(AppColors.surface)
                .border({
                  width: 1,
                  color: AppColors.outline,
                  radius: AppShapes.medium
                })
                .borderRadius(AppShapes.medium)
              }
            }, (w: Homework) => w.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.md)
          .rowsGap(AppSpacing.md)
          .width('100%')
          .height(314)
          .padding({ bottom: AppSpacing.lg })

          Text('Progress Chart')
            .fontSize(AppTypography.headlineSize)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .width('100%')

          Column({ space: AppSpacing.sm }) {
            ForEach(this.charts, (c: ChartData) => {
              Column({ space: AppSpacing.xs }) {
                Row() {
                  Row()
                    .height(24)
                    .width(`${Math.floor(c.progress * 100)}%`)
                    .backgroundColor(AppColors.primary)
                    .borderRadius(AppShapes.small)
                }
                .width('100%')
                .height(24)
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.small)

                Text(`${c.label}: ${Math.floor(c.progress * 100)}%`)
                  .fontSize(AppTypography.bodySize)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(AppColors.onSurface)
              }
              .width('100%')
            }, (c: ChartData) => c.id.toString())
          }
          .width('100%')

          Button('Submit New HW')
            .height(40)
            .width('60%')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.large)
            .alignSelf(ItemAlign.Center)
            .onClick(() => {
            })
        }
        .width('100%')
        .minHeight('100%')
        .padding(AppSpacing.lg)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['rgba(14, 165, 233, 0.15)', 0.0],
            ['rgba(99, 102, 241, 0.10)', 1.0]
          ]
        })
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}