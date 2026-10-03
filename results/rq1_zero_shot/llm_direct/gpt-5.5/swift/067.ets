class AppColors {
  static readonly primary: string = '#FF7043'
  static readonly secondary: string = '#FFB74D'
  static readonly tertiary: string = '#FFD54F'
  static readonly background: string = '#FFF8E1'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#FFECB3'
  static readonly outline: string = '#E0C097'
  static readonly success: string = '#43A047'
  static readonly warning: string = '#FBC02D'
  static readonly error: string = '#E53935'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#3E2723'
  static readonly onTertiary: string = '#3E2723'
  static readonly onBackground: string = '#3E2723'
  static readonly onSurface: string = '#3E2723'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly headlineSize: number = 20
  static readonly titleSize: number = 16
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12

  static readonly displayWeight: FontWeight = FontWeight.Bold
  static readonly headlineWeight: FontWeight = FontWeight.SemiBold
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodyWeight: FontWeight = FontWeight.Regular
  static readonly labelWeight: FontWeight = FontWeight.Medium
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number
  color: string

  constructor(elevation: number, radius: number, dy: number, opacity: number, color: string) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
    this.color = color
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 4, 2, 0.1, '#1A000000')
  static readonly level2: ShadowSpec = new ShadowSpec(3, 8, 4, 0.14, '#24000000')
  static readonly level3: ShadowSpec = new ShadowSpec(6, 12, 6, 0.16, '#29000000')
}

interface Client {
  id: number
  name: string
  region: string
  level: string
  x: number
  y: number
}

@Component
struct MapMarker {
  label: string = ''
  level: string = ''
  selected: boolean = false
  xOffset: string = '0%'
  yOffset: string = '0%'
  onClick: () => void = () => {}

  markerColor(): string {
    if (this.level === 'A') {
      return AppColors.primary
    }
    if (this.level === 'B') {
      return AppColors.secondary
    }
    return AppColors.tertiary
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.markerColor())
        .stroke(this.selected ? AppColors.onPrimary : AppColors.surface)
        .strokeWidth(2)

      Text(this.label)
        .fontSize(AppTypography.labelSize)
        .fontWeight(AppTypography.labelWeight)
        .fontColor(AppColors.onSurface)
        .padding({
          left: AppSpacing.sm,
          right: AppSpacing.sm,
          top: AppSpacing.xs,
          bottom: AppSpacing.xs
        })
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)
        .border({
          width: 1,
          color: AppColors.outline
        })
        .shadow({
          radius: AppElevation.level1.radius,
          color: AppElevation.level1.color,
          offsetX: 0,
          offsetY: AppElevation.level1.dy
        })
        .position({ x: 20, y: -4 })
        .onClick(() => {
          this.onClick()
        })
    }
    .width(180)
    .height(44)
    .position({ x: this.xOffset, y: this.yOffset })
  }
}

@Component
struct MapGridOverlay {
  private readonly lines: number[] = [0, 1, 2, 3, 4, 5]

  build() {
    Stack() {
      Column() {
        ForEach(this.lines, (_: number) => {
          Divider()
            .strokeWidth(1)
            .color(AppColors.surfaceVariant)
            .width('100%')
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.SpaceEvenly)

      Row() {
        ForEach(this.lines, (_: number) => {
          Divider()
            .vertical(true)
            .strokeWidth(1)
            .color(AppColors.surfaceVariant)
            .height('100%')
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedId: number = -1

  private readonly clients: Client[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ]

  build() {
    Column() {
      Stack() {
        Text('Client Detail')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.onSurface)
          .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.md }) {
          Stack() {
            Text('Regional Client Map')
              .fontSize(AppTypography.headlineSize)
              .fontWeight(AppTypography.headlineWeight)
              .fontColor(AppColors.onPrimary)
          }
          .width('100%')
          .height(200)
          .linearGradient({
            direction: GradientDirection.Right,
            colors: [
              [AppColors.secondary, 0.0],
              [AppColors.primary, 1.0]
            ]
          })
          .borderRadius(AppShapes.large)
          .margin({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md
          })

          Stack({ alignContent: Alignment.TopStart }) {
            MapGridOverlay()

            ForEach(this.clients, (client: Client) => {
              MapMarker({
                label: client.name,
                level: client.level,
                selected: this.selectedId === client.id,
                xOffset: `${client.x * 100}%`,
                yOffset: `${client.y * 100}%`,
                onClick: () => {
                  this.selectedId = this.selectedId === client.id ? -1 : client.id
                }
              })
            }, (client: Client) => client.id.toString())
          }
          .width('100%')
          .aspectRatio(0.9)
          .constraintSize({ minHeight: 360 })
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .border({
            width: 1,
            color: AppColors.outline
          })
          .margin({
            left: AppSpacing.lg,
            right: AppSpacing.lg
          })

          Column({ space: AppSpacing.md }) {
            ForEach(this.clients, (client: Client) => {
              Row() {
                Column({ space: AppSpacing.xs }) {
                  Text(client.name)
                    .fontSize(AppTypography.titleSize)
                    .fontWeight(AppTypography.titleWeight)
                    .fontColor(AppColors.onSurface)

                  Text(client.region)
                    .fontSize(AppTypography.bodySize)
                    .fontWeight(AppTypography.bodyWeight)
                    .fontColor(AppColors.onSurface)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Text(`Level ${client.level}`)
                  .fontSize(AppTypography.labelSize)
                  .fontWeight(AppTypography.labelWeight)
                  .fontColor(AppColors.primary)
              }
              .width('100%')
              .padding(AppSpacing.lg)
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.medium)
              .border({
                width: 1,
                color: AppColors.outline
              })
              .shadow({
                radius: AppElevation.level1.radius,
                color: AppElevation.level1.color,
                offsetX: 0,
                offsetY: AppElevation.level1.dy
              })
            }, (client: Client) => client.id.toString())
          }
          .width('100%')
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: AppSpacing.xxl
          })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .scrollable(ScrollDirection.Vertical)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}