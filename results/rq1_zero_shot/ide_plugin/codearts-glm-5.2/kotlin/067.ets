const AppColors = {
  primary: '#FF7043',
  secondary: '#FFB74D',
  tertiary: '#FFD54F',
  background: '#FFF8E1',
  surface: '#FFFFFF',
  surfaceVariant: '#FFECB3',
  outline: '#E0C097',
  success: '#43A047',
  warning: '#FBC02D',
  error: '#E53935',
  onPrimary: '#FFFFFF',
  onSecondary: '#3E2723',
  onTertiary: '#3E2723',
  onBackground: '#3E2723',
  onSurface: '#3E2723',
}

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
}

const AppShapes = {
  small: 8,
  medium: 12,
  large: 16,
}

class Client {
  id: number = 0
  name: string = ''
  region: string = ''
  level: string = ''
  x: number = 0
  y: number = 0
  constructor(id: number, name: string, region: string, level: string, x: number, y: number) {
    this.id = id
    this.name = name
    this.region = region
    this.level = level
    this.x = x
    this.y = y
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

  getMarkerColor(level: string): string {
    if (level === 'A') return AppColors.primary
    if (level === 'B') return AppColors.secondary
    return AppColors.tertiary
  }

  @Builder
  MapMarkerCircle(c: Client) {
    Column() {}
      .width(this.selectedId === c.id ? 28 : 22)
      .height(this.selectedId === c.id ? 28 : 22)
      .backgroundColor(this.getMarkerColor(c.level))
      .borderRadius(50)
      .borderWidth(2)
      .borderColor(this.selectedId === c.id ? AppColors.onPrimary : AppColors.surface)
      .position({ x: `${c.x * 100}%`, y: `${c.y * 100}%` })
      .onClick(() => {
        this.selectedId = this.selectedId === c.id ? -1 : c.id
      })
  }

  @Builder
  MapMarkerLabel(c: Client) {
    Text(c.name)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .borderWidth(1)
      .borderColor(AppColors.outline)
      .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
      .position({ x: `${(c.x * 100 + 6)}%`, y: `${Math.max(c.y * 100 - 2, 0)}%` })
      .onClick(() => {
        this.selectedId = this.selectedId === c.id ? -1 : c.id
      })
  }

  @Builder
  ClientCardBuilder(c: Client) {
    Row() {
      Column() {
        Text(c.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(c.region)
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .margin({ top: AppSpacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Text(`Level ${c.level}`)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .borderWidth(1)
    .borderColor(AppColors.outline)
  }

  build() {
    Column() {
      Text('Client Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.md })

      Column() {
        Text('Regional Client Map')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onPrimary)
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .borderRadius(AppShapes.large)
      .linearGradient({
        angle: 90,
        colors: [[AppColors.secondary, 0], [AppColors.primary, 1]]
      })

      Stack() {
        Column() {
          ForEach([0, 1, 2, 3, 4, 5], (i: number) => {
            Column() {}
              .width('100%')
              .height(1)
              .backgroundColor(AppColors.surfaceVariant)
          }, (i: number) => i.toString())
        }
        .width('100%')
        .height('100%')
        .padding(AppSpacing.lg)
        .justifyContent(FlexAlign.SpaceEvenly)

        Row() {
          ForEach([0, 1, 2, 3, 4, 5], (i: number) => {
            Column() {}
              .width(1)
              .height('100%')
              .backgroundColor(AppColors.surfaceVariant)
          }, (i: number) => i.toString())
        }
        .width('100%')
        .height('100%')
        .padding(AppSpacing.lg)
        .justifyContent(FlexAlign.SpaceEvenly)

        ForEach(this.clients, (c: Client) => {
          this.MapMarkerCircle(c)
        }, (c: Client) => `circle_${c.id}`)

        ForEach(this.clients, (c: Client) => {
          this.MapMarkerLabel(c)
        }, (c: Client) => `label_${c.id}`)
      }
      .width('100%')
      .height(360)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.large)
      .borderWidth(1)
      .borderColor(AppColors.outline)

      List({ space: AppSpacing.md }) {
        ForEach(this.clients, (c: Client) => {
          ListItem() {
            this.ClientCardBuilder(c)
          }
        }, (c: Client) => c.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ bottom: AppSpacing.xxl })
    }
    .width('100%')
    .height('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.background)
  }
}