// Design Tokens
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

const AppElevation = {
  level1: { radius: 4, dy: 2, opacity: 0.1 },
  level2: { radius: 8, dy: 4, opacity: 0.14 },
  level3: { radius: 12, dy: 6, opacity: 0.16 },
}

const AppTypography = {
  displayLarge: { size: 28, weight: FontWeight.Bold },
  headlineMedium: { size: 20, weight: FontWeight.Medium },
  titleMedium: { size: 16, weight: FontWeight.Medium },
  bodyMedium: { size: 14, weight: FontWeight.Regular },
  labelMedium: { size: 12, weight: FontWeight.Medium },
}

interface Client {
  id: number
  name: string
  region: string
  level: string
  x: number
  y: number
}

const clients: Client[] = [
  { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
  { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
  { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
  { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 },
]

function getMarkerColor(level: string): string {
  if (level === 'A') {
    return AppColors.primary
  } else if (level === 'B') {
    return AppColors.secondary
  } else {
    return AppColors.tertiary
  }
}

function getMarkerStrokeColor(selected: boolean): string {
  return selected ? AppColors.onPrimary : AppColors.surface
}

const gridLineCount: number = 6

@Component
struct MapMarker {
  label: string = ''
  level: string = ''
  selected: boolean = false
  xPos: number = 0
  yPos: number = 0
  onTap: () => void = () => {}

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .fill(getMarkerColor(this.level))
        .stroke(getMarkerStrokeColor(this.selected))
        .strokeWidth(2)
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .position({ x: this.xPos, y: this.yPos })

      Text(this.label)
        .fontSize(AppTypography.labelMedium.size)
        .fontWeight(AppTypography.labelMedium.weight)
        .fontColor(AppColors.onSurface)
        .padding({
          left: AppSpacing.sm,
          right: AppSpacing.sm,
          top: AppSpacing.xs,
          bottom: AppSpacing.xs,
        })
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)
        .border({ width: 1, color: AppColors.outline })
        .shadow({
          radius: AppElevation.level1.radius,
          color: `rgba(0,0,0,${AppElevation.level1.opacity})`,
          offsetY: AppElevation.level1.dy,
        })
        .position({ x: this.xPos + 20, y: this.yPos - 4 })
        .onClick(() => {
          this.onTap()
        })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MapGridOverlay {
  mapWidth: number = 0
  mapHeight: number = 0

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      ForEach(Array.from({ length: gridLineCount }, (_: number, i: number) => i),
        (i: number) => {
          Rect()
            .fill(AppColors.surfaceVariant)
            .width(this.mapWidth - 2 * AppSpacing.lg)
            .height(1)
            .position({
              x: AppSpacing.lg,
              y: AppSpacing.lg + ((this.mapHeight - 2 * AppSpacing.lg) / 7) * (i + 1),
            })
        },
        (i: number) => `h-${i}` as string)

      ForEach(Array.from({ length: gridLineCount }, (_: number, i: number) => i),
        (i: number) => {
          Rect()
            .fill(AppColors.surfaceVariant)
            .width(1)
            .height(this.mapHeight - 2 * AppSpacing.lg)
            .position({
              x: AppSpacing.lg + ((this.mapWidth - 2 * AppSpacing.lg) / 7) * (i + 1),
              y: AppSpacing.lg,
            })
        },
        (i: number) => `v-${i}` as string)
    }
    .width('100%')
    .height('100%')
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedId: number = 0
  @State mapWidth: number = 300
  @State mapHeight: number = 300

  build() {
    Column() {
      // Top Bar
      Stack() {
        Text('Client Detail')
          .fontSize(AppTypography.displayLarge.size)
          .fontWeight(AppTypography.displayLarge.weight)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.md }) {
          // Regional Client Map header with gradient
          Text('Regional Client Map')
            .fontSize(AppTypography.headlineMedium.size)
            .fontWeight(AppTypography.headlineMedium.weight)
            .fontColor(AppColors.onPrimary)
            .width('100%')
            .height(200)
            .textAlign(TextAlign.Center)
            .linearGradient({
              direction: GradientDirection.LeftRight,
              colors: [
                [AppColors.secondary, 0],
                [AppColors.primary, 1],
              ],
            })
            .borderRadius(AppShapes.large)
            .margin({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md })

          // Map area
          Stack({ alignContent: Alignment.TopStart }) {
            // Map background
            Stack()
              .width('100%')
              .height('100%')
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.large)
              .border({ width: 1, color: AppColors.outline })

            MapGridOverlay({ mapWidth: this.mapWidth, mapHeight: this.mapHeight })

            ForEach(clients, (client: Client) => {
              MapMarker({
                label: client.name,
                level: client.level,
                selected: this.selectedId === client.id,
                xPos: this.mapWidth * client.x,
                yPos: this.mapHeight * client.y,
                onTap: () => {
                  if (this.selectedId === client.id) {
                    this.selectedId = 0
                  } else {
                    this.selectedId = client.id
                  }
                },
              })
            }, (client: Client) => `marker-${client.id}` as string)
          }
          .width('100%')
          .aspectRatio(0.9)
          .constraintSize({ minHeight: 360 })
          .margin({ left: AppSpacing.lg, right: AppSpacing.lg })
          .onAreaChange((_: Area, newArea: Area) => {
            this.mapWidth = newArea.width as number
            this.mapHeight = newArea.height as number
          })

          // Client List
          Column({ space: AppSpacing.md }) {
            ForEach(clients, (client: Client) => {
              Stack() {
                Row() {
                  Column() {
                    Text(client.name)
                      .fontSize(AppTypography.titleMedium.size)
                      .fontWeight(AppTypography.titleMedium.weight)
                      .fontColor(AppColors.onSurface)
                    Text(client.region)
                      .fontSize(AppTypography.bodyMedium.size)
                      .fontWeight(AppTypography.bodyMedium.weight)
                      .fontColor(AppColors.onSurface)
                      .margin({ top: AppSpacing.xs })
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  Text(`Level ${client.level}`)
                    .fontSize(AppTypography.labelMedium.size)
                    .fontWeight(AppTypography.labelMedium.weight)
                    .fontColor(AppColors.primary)
                }
                .width('100%')
                .padding(AppSpacing.lg)
              }
              .width('100%')
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.medium)
              .border({ width: 1, color: AppColors.outline })
              .shadow({
                radius: AppElevation.level1.radius,
                color: `rgba(0,0,0,${AppElevation.level1.opacity})`,
                offsetY: AppElevation.level1.dy,
              })
            }, (client: Client) => `card-${client.id}` as string)
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, bottom: AppSpacing.xxl })
        }
        .width('100%')
      }
      .width('100%')
      .backgroundColor(AppColors.background)
      .flexGrow(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
