const NAME = '079_HomeworkSubmit_en'
const UI_TYPE = 'Education Chart'
const STYLE_THEME = 'Cold Gradient'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#0EA5E9',
    secondary: '#6366F1',
    tertiary: '#06B6D4',
    background: '#F1F5F9',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#D1D5DB',
    success: '#10B981',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0F172A',
    onBackground: '#1E293B',
    onSurface: '#1E293B',
  }

  static TypographyTokens = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Normal },
    label: { fontSize: 11, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  }

  static Spacing = {
    xs: 2,
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28,
  }

  static ElevationMapping = {
    level1: { elevation: 1, radius: 2, dy: 1, opacity: 0.1 },
    level2: { elevation: 3, radius: 4, dy: 2, opacity: 0.14 },
    level3: { elevation: 6, radius: 6, dy: 3, opacity: 0.16 },
  }
}

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

@Entry
@Component
struct RootScreen {
  private works: Homework[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' },
  ]

  private charts: ChartData[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 },
  ]

  build() {
    Column() {
      Row() {
        Text('Homework Submit')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Column() {
        Text('Assignments')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)

        Grid() {
          ForEach(this.works, (w: Homework) => {
            GridItem() {
              HomeworkCard({ homework: w })
            }
          }, (w: Homework) => w.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .width('100%')
        .height(280)
        .columnsGap(AppTokens.Spacing.md)
        .rowsGap(AppTokens.Spacing.md)
        .margin({ top: AppTokens.Spacing.lg })

        Text('Progress Chart')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ top: AppTokens.Spacing.lg })

        List() {
          ForEach(this.charts, (c: ChartData) => {
            ListItem() {
              Column() {
                Row() {
                  Column()
                    .width(`${c.progress * 100}%`)
                    .height(24)
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(AppTokens.Shapes.small)
                }
                .width('100%')
                .height(24)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)

                Text(`${c.label}: ${Math.floor(c.progress * 100)}%`)
                  .fontSize(AppTokens.TypographyTokens.body.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ top: AppTokens.Spacing.xs })
              }
              .width('100%')
              .margin({ bottom: AppTokens.Spacing.sm })
            }
          }, (c: ChartData) => c.id.toString())
        }
        .width('100%')
        .layoutWeight(1)

        Button('Submit New HW')
          .type(ButtonType.Normal)
          .width('60%')
          .height(40)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .margin({ top: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['#260EA5E9', 0.0], ['#1A6366F1', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct HomeworkCard {
  private homework: Homework = { id: 0, title: '', status: '' }

  build() {
    Column() {
      Column()
        .width(40)
        .height(40)
        .backgroundColor(AppTokens.Colors.tertiary)
        .borderRadius(AppTokens.Shapes.small)

      Text(this.homework.title)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Text(this.homework.status)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}