const NAME = '108ApprovalFlowen'
const UI_TYPE = 'Map'
const STYLE_THEME = 'Monochrome'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#111111',
    secondary: '#2A2A2A',
    tertiary: '#444444',
    background: '#F7F7F7',
    surface: '#FFFFFF',
    surfaceVariant: '#EDEDED',
    outline: '#D6D6D6',
    success: '#1E7D4C',
    warning: '#B98400',
    error: '#B3261E',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0A0A0A',
    onSurface: '#0A0A0A',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Medium },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
  }

  static ElevationMapping = {
    level1: { elevation: 1, radius: 4, dy: 2, opacity: 0.10 },
    level2: { elevation: 3, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 6, radius: 12, dy: 6, opacity: 0.16 },
  }
}

interface ApprovalPin {
  id: number
  title: string
  status: string
  x: number
  y: number
}

@Entry
@Component
struct RootScreen {
  @State activeFilters: string[] = ['Pending']
  @State selectedId: number | null = null
  private filters: string[] = ['Pending', 'Approved']
  private pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 },
  ]

  private getPinColor(status: string): string {
    if (status === 'Approved') return AppTokens.Colors.success
    if (status === 'Pending') return AppTokens.Colors.warning
    return AppTokens.Colors.error
  }

  private isPinVisible(p: ApprovalPin): boolean {
    if (p.status === 'Pending') return this.activeFilters.includes('Pending')
    if (p.status === 'Approved') return this.activeFilters.includes('Approved')
    return true
  }

  private toggleFilter(f: string) {
    if (this.activeFilters.includes(f)) {
      this.activeFilters = this.activeFilters.filter(item => item !== f)
    } else {
      this.activeFilters.push(f)
    }
  }

  build() {
    Column() {
      Row() {
        Text('Approval Flow')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Column() {
        Scroll() {
          Row() {
            ForEach(this.filters, (f: string) => {
              Text(f)
                .fontSize(this.activeFilters.includes(f) ? AppTokens.TypographyTokens.title.fontSize : AppTokens.TypographyTokens.body.fontSize)
                .fontWeight(this.activeFilters.includes(f) ? AppTokens.TypographyTokens.title.fontWeight : AppTokens.TypographyTokens.body.fontWeight)
                .fontColor(this.activeFilters.includes(f) ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(this.activeFilters.includes(f) ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .borderRadius(AppTokens.Shapes.small)
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .margin({ right: AppTokens.Spacing.sm })
                .onClick(() => {
                  this.toggleFilter(f)
                })
            }, (f: string) => f)
          }
        }
        .scrollDirection(ScrollDirection.Horizontal)
        .width('100%')

        Stack() {
          ForEach([0, 1, 2, 3, 4, 5], (i: number) => {
            Column()
              .width('100%')
              .height(1)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .position({ x: 0, y: 40 + i * 50 })
          }, (i: number) => `h${i}`)

          ForEach([0, 1, 2, 3, 4, 5], (i: number) => {
            Column()
              .width(1)
              .height('100%')
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .position({ x: 30 + i * 50, y: 0 })
          }, (i: number) => `v${i}`)

          ForEach(this.pins, (p: ApprovalPin) => {
            if (this.isPinVisible(p)) {
              Column()
                .width(this.selectedId === p.id ? 28 : 22)
                .height(this.selectedId === p.id ? 28 : 22)
                .backgroundColor(this.getPinColor(p.status))
                .borderRadius(this.selectedId === p.id ? 14 : 11)
                .border({ width: 2, color: this.selectedId === p.id ? AppTokens.Colors.primary : AppTokens.Colors.surface })
                .position({ x: `${p.x * 100}%`, y: `${p.y * 100}%` })
                .markAnchor({ x: '50%', y: '50%' })
                .onClick(() => {
                  this.selectedId = this.selectedId === p.id ? null : p.id
                })
            }
          }, (p: ApprovalPin) => p.id.toString())

          if (this.selectedId !== null) {
            ForEach(this.pins, (p: ApprovalPin) => {
              if (p.id === this.selectedId) {
                Row() {
                  Column() {
                    Text(p.title)
                      .fontSize(AppTokens.TypographyTokens.title.fontSize)
                      .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                      .fontColor(AppTokens.Colors.onSurface)

                    Text(p.status)
                      .fontSize(AppTokens.TypographyTokens.label.fontSize)
                      .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                      .fontColor(AppTokens.Colors.onSurface)
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  Button('Details')
                    .type(ButtonType.Normal)
                    .height(40)
                    .borderRadius(AppTokens.Shapes.medium)
                    .backgroundColor(AppTokens.Colors.surfaceVariant)
                    .fontColor(AppTokens.Colors.onSurface)
                    .fontSize(AppTokens.TypographyTokens.label.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                }
                .width('90%')
                .padding(AppTokens.Spacing.lg)
                .backgroundColor(AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.large)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .alignItems(VerticalAlign.Center)
                .shadow({ radius: AppTokens.ElevationMapping.level3.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level3.opacity})`, offsetY: AppTokens.ElevationMapping.level3.dy })
                .position({ x: '50%', y: '100%' })
                .markAnchor({ x: '50%', y: '100%' })
              }
            }, (p: ApprovalPin) => `sel${p.id}`)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .margin({ top: AppTokens.Spacing.md })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })

      Stack() {
        Row() {
          Button('Reject')
            .type(ButtonType.Normal)
            .layoutWeight(1)
            .height(48)
            .borderRadius(AppTokens.Shapes.medium)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .enabled(this.selectedId !== null)

          Button('Approve')
            .type(ButtonType.Normal)
            .layoutWeight(1)
            .height(48)
            .borderRadius(AppTokens.Shapes.medium)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .margin({ left: AppTokens.Spacing.md })
            .enabled(this.selectedId !== null)
        }
        .width('100%')
        .height(64)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)
        .alignItems(VerticalAlign.Center)
        .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: -AppTokens.ElevationMapping.level2.dy })

        Button('+')
          .type(ButtonType.Normal)
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .position({ x: '50%', y: -28 })
          .markAnchor({ x: '50%', y: 0 })
      }
      .width('100%')
      .height(64)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}