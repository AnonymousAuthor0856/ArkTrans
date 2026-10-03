interface Client {
  id: number
  name: string
  region: string
  level: string
  x: number
  y: number
}

class AppColors {
  static readonly primary: ResourceColor = '#FF7043'
  static readonly secondary: ResourceColor = '#FFB74D'
  static readonly tertiary: ResourceColor = '#FFD54F'
  static readonly background: ResourceColor = '#FFF8E1'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#FFECB3'
  static readonly outline: ResourceColor = '#E0C097'
  static readonly success: ResourceColor = '#43A047'
  static readonly warning: ResourceColor = '#FBC02D'
  static readonly error: ResourceColor = '#E53935'
  static readonly onPrimary: ResourceColor = '#FFFFFF'
  static readonly onSecondary: ResourceColor = '#3E2723'
  static readonly onTertiary: ResourceColor = '#3E2723'
  static readonly onBackground: ResourceColor = '#3E2723'
  static readonly onSurface: ResourceColor = '#3E2723'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class AppShape {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

class AppShadow {
  static readonly level1Radius: number = 4
  static readonly level1Dy: number = 2
  static readonly level1Color: ResourceColor = '#1A000000'
}

@Component
struct MapGridOverlay {
  private lines: number[] = [1, 2, 3, 4, 5, 6]

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      ForEach(this.lines, (line: number) => {
        Blank()
          .width('100%')
          .height(1)
          .backgroundColor(AppColors.surfaceVariant)
          .position({ x: 0, y: `${line * 100 / 7}%` })
      }, (line: number) => `h-${line}`)

      ForEach(this.lines, (line: number) => {
        Blank()
          .width(1)
          .height('100%')
          .backgroundColor(AppColors.surfaceVariant)
          .position({ x: `${line * 100 / 7}%`, y: 0 })
      }, (line: number) => `v-${line}`)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MapMarker {
  label: string = ''
  level: string = ''
  selected: boolean = false
  onClick: () => void = () => {
  }

  private markerColor(): ResourceColor {
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
      Blank()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .backgroundColor(this.markerColor())
        .borderRadius(this.selected ? 14 : 11)
        .border({
          width: 2,
          color: this.selected ? AppColors.onPrimary : AppColors.surface
        })
        .position({ x: 0, y: 4 })

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .maxLines(1)
        .padding({
          left: AppSpacing.sm,
          right: AppSpacing.sm,
          top: AppSpacing.xs,
          bottom: AppSpacing.xs
        })
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShape.small)
        .border({
          width: 1,
          color: AppColors.outline
        })
        .shadow({
          radius: AppShadow.level1Radius,
          color: AppShadow.level1Color,
          offsetX: 0,
          offsetY: AppShadow.level1Dy
        })
        .position({ x: 20, y: 0 })
        .onClick(() => {
          this.onClick()
        })
    }
    .width(240)
    .height(52)
  }
}

@Component
struct ClientCard {
  client: Client = {
    id: 0,
    name: '',
    region: '',
    level: '',
    x: 0,
    y: 0
  }

  build() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text(this.client.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text(this.client.region)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Text(`Level ${this.client.level}`)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShape.medium)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .shadow({
      radius: AppShadow.level1Radius,
      color: AppShadow.level1Color,
      offsetX: 0,
      offsetY: AppShadow.level1Dy
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State private selectedId: number = -1

  private clients: Client[] = [
    {
      id: 1,
      name: 'Sunrise Tech',
      region: 'Shanghai',
      level: 'A',
      x: 0.2,
      y: 0.3
    },
    {
      id: 2,
      name: 'Delta Logistics',
      region: 'Beijing',
      level: 'B',
      x: 0.5,
      y: 0.45
    },
    {
      id: 3,
      name: 'Oceanic Foods',
      region: 'Guangzhou',
      level: 'A',
      x: 0.72,
      y: 0.6
    },
    {
      id: 4,
      name: 'Horizon Ltd.',
      region: 'Chengdu',
      level: 'C',
      x: 0.33,
      y: 0.75
    }
  ]

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('Client Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.md }) {
          Stack({ alignContent: Alignment.Center }) {
            Text('Regional Client Map')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
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
          .borderRadius(AppShape.large)
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
                onClick: () => {
                  this.selectedId = this.selectedId === client.id ? -1 : client.id
                }
              })
                .position({
                  x: `${client.x * 100}%`,
                  y: `${client.y * 100}%`
                })
            }, (client: Client) => `${client.id}`)
          }
          .width('100%')
          .aspectRatio(0.9)
          .constraintSize({
            minHeight: 360
          })
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShape.large)
          .border({
            width: 1,
            color: AppColors.outline
          })
          .clip(true)
          .margin({
            left: AppSpacing.lg,
            right: AppSpacing.lg
          })

          Column({ space: AppSpacing.md }) {
            ForEach(this.clients, (client: Client) => {
              ClientCard({
                client: client
              })
            }, (client: Client) => `card-${client.id}`)
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
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}