const NAME = '065FlightCheckinen'
const UI_TYPE = 'Travel'
const STYLE_THEME = 'Modern Blue'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#1E3A8A',
    secondary: '#2563EB',
    tertiary: '#60A5FA',
    background: '#F5F8FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E8EEFA',
    outline: '#CBD5E1',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0B1220',
    onBackground: '#0B1220',
    onSurface: '#0B1220',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 8,
    medium: 12,
    large: 18,
  }

  static Spacing = {
    xs: 6,
    sm: 10,
    md: 14,
    lg: 18,
    xl: 26,
    xxl: 36,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.16 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 },
  }
}

@Entry
@Component
struct RootScreen {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false
  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  private getSeatLabel(): string {
    if (this.selectedSeat === 0) return '23C'
    if (this.selectedSeat === 1) return '11A'
    return '2F'
  }

  build() {
    Column() {
      Row() {
        Column()
          .width(22)
          .height(22)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(11)

        Text('Flight Check-in')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Column()
          .width(22)
          .height(22)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(11)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .alignItems(VerticalAlign.Center)

      Column() {
        Column() {
          Text('Passenger')
            .fontSize(AppTokens.TypographyTokens.headline.fontSize)
            .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          TextInput({ text: this.name, placeholder: 'Full name' })
            .width('100%')
            .height(48)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .placeholderColor('#800B1220')
            .margin({ top: AppTokens.Spacing.md })
            .onChange((value: string) => {
              this.name = value
            })

          Text('Booking Code')
            .fontSize(AppTokens.TypographyTokens.headline.fontSize)
            .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.md })

          TextInput({ text: this.code, placeholder: 'e.g. XY7ZK2' })
            .width('100%')
            .height(48)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .placeholderColor('#800B1220')
            .margin({ top: AppTokens.Spacing.md })
            .onChange((value: string) => {
              this.code = value
            })

          Text('Seat Class')
            .fontSize(AppTokens.TypographyTokens.headline.fontSize)
            .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.md })

          Row() {
            ForEach(this.seatTabs, (label: string, index: number) => {
              Text(label)
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .fontColor(this.selectedSeat === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(this.selectedSeat === index ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .borderRadius(AppTokens.Shapes.small)
                .layoutWeight(1)
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  this.selectedSeat = index
                })
            }, (label: string, index: number) => index.toString())
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.md })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })

        Column() {
          Row() {
            Column() {
              Text('Flight')
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)

              Text('BL 213 • HND → CTS')
                .fontSize(AppTokens.TypographyTokens.body.fontSize)
                .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ top: AppTokens.Spacing.xs })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Column()
              .width(36)
              .height(36)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(18)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          Row() {
            Column() {
              Text('Boarding')
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
              Text('12:35')
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                .fontColor(AppTokens.Colors.primary)
                .margin({ top: AppTokens.Spacing.xs })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Column() {
              Text('Gate')
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
              Text('A12')
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                .fontColor(AppTokens.Colors.primary)
                .margin({ top: AppTokens.Spacing.xs })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Column() {
              Text('Seat')
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
              Text(this.getSeatLabel())
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                .fontColor(AppTokens.Colors.primary)
                .margin({ top: AppTokens.Spacing.xs })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.md })

          Button('Confirm Check-in')
            .type(ButtonType.Normal)
            .width('100%')
            .height(52)
            .borderRadius(AppTokens.Shapes.large)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .margin({ top: AppTokens.Spacing.md })
            .onClick(() => {
              this.showDialog = true
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
        .margin({ top: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .linearGradient({
        angle: 180,
        colors: [['#4060A5FA', 0.0], [AppTokens.Colors.background, 0.5], ['#332563EB', 1.0]]
      })

      if (this.showDialog) {
        Column() {
          Text('Check-in Successful')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Text('Boarding pass is ready. Have a nice flight.')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.sm })

          Button('Done')
            .type(ButtonType.Normal)
            .borderRadius(AppTokens.Shapes.medium)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .margin({ top: AppTokens.Spacing.lg })
            .onClick(() => {
              this.showDialog = false
            })
        }
        .width('80%')
        .padding(AppTokens.Spacing.xl)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .alignItems(HorizontalAlign.Center)
        .position({ x: '50%', y: '50%' })
        .markAnchor({ x: '50%', y: '50%' })
        .shadow({ radius: AppTokens.ElevationMapping.level3.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level3.opacity})`, offsetY: AppTokens.ElevationMapping.level3.dy })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}