class AppTokens {
  static readonly Colors = {
    primary: '#FFFF7043',
    secondary: '#FFFFB74D',
    tertiary: '#FFFFD54F',
    background: '#FFFFF8E1',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFFFECB3',
    outline: '#FFE0C097',
    success: '#FF43A047',
    warning: '#FFFBC02D',
    error: '#FFE53935',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF3E2723',
    onTertiary: '#FF3E2723',
    onBackground: '#FF3E2723',
    onSurface: '#FF3E2723',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  }
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  }
}

class Client {
  id: number
  name: string
  region: string
  level: string
  x: number
  y: number

  constructor(id: number, name: string, region: string, level: string, x: number, y: number) {
    this.id = id
    this.name = name
    this.region = region
    this.level = level
    this.x = x
    this.y = y
  }
}

@Component
struct ClientCard {
  @Prop name: string
  @Prop region: string
  @Prop level: string

  build() {
    Row() {
      Column({ space: AppTokens.Spacing.xs }) {
        Text(this.name)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.region)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text(`Level ${this.level}`)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.primary)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedId: number = -1
  private clients: Client[] = [
    new Client(1, 'Sunrise Tech', 'Shanghai', 'A', 0.2, 0.3),
    new Client(2, 'Delta Logistics', 'Beijing', 'B', 0.5, 0.45),
    new Client(3, 'Oceanic Foods', 'Guangzhou', 'A', 0.72, 0.6),
    new Client(4, 'Horizon Ltd.', 'Chengdu', 'C', 0.33, 0.75),
  ]

  private getMarkerColor(level: string): string {
    if (level === 'A') return AppTokens.Colors.primary
    if (level === 'B') return AppTokens.Colors.secondary
    return AppTokens.Colors.tertiary
  }

  build() {
    Column() {
      Row() {
        Text('Client Detail')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)

      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          Text('Regional Client Map')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(200)
            .textAlign(TextAlign.Center)
            .linearGradient({
              direction: GradientDirection.Right,
              colors: [[AppTokens.Colors.secondary, 0.0], [AppTokens.Colors.primary, 1.0]]
            })
            .borderRadius(AppTokens.Shapes.large)
            .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

          Stack() {
            ForEach([0, 1, 2, 3, 4], () => {
              Column()
                .width('100%')
                .height(1)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
            })

            ForEach(this.clients, (client: Client) => {
              Stack() {
                Circle({ width: this.selectedId === client.id ? 28 : 22, height: this.selectedId === client.id ? 28 : 22 })
                  .fill(this.getMarkerColor(client.level))
                  .border({ width: 2, color: this.selectedId === client.id ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface })
                  .onClick(() => {
                    this.selectedId = this.selectedId === client.id ? -1 : client.id
                  })

                Text(client.name)
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .borderRadius(AppTokens.Shapes.small)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
                  .position({ x: 20, y: -4 })
              }
              .position({ x: `${client.x * 100}%`, y: `${client.y * 100}%` })
            })
          }
          .width('100%')
          .height(360)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.clients, (client: Client) => {
              ClientCard({ name: client.name, region: client.region, level: client.level })
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.xxl })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}