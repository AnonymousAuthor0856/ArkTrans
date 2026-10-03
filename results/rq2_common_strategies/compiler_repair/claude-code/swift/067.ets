// Design Tokens
class AppColorsClass {
  primary: string = '#FF7043'
  secondary: string = '#FFB74D'
  tertiary: string = '#FFD54F'
  background: string = '#FFF8E1'
  surface: string = '#FFFFFF'
  surfaceVariant: string = '#FFECB3'
  outline: string = '#E0C097'
  success: string = '#43A047'
  warning: string = '#FBC02D'
  error: string = '#E53935'
  onPrimary: string = '#FFFFFF'
  onSecondary: string = '#3E2723'
  onTertiary: string = '#3E2723'
  onBackground: string = '#3E2723'
  onSurface: string = '#3E2723'
}

const AppColors: AppColorsClass = new AppColorsClass()

class AppSpacingClass {
  xs: number = 4
  sm: number = 8
  md: number = 12
  lg: number = 16
  xl: number = 24
  xxl: number = 32
}

const AppSpacing: AppSpacingClass = new AppSpacingClass()

class AppShapesClass {
  small: number = 8
  medium: number = 12
  large: number = 16
}

const AppShapes: AppShapesClass = new AppShapesClass()

class ShadowSpec {
  radius: number
  dy: number
  opacity: number
  constructor(radius: number, dy: number, opacity: number) {
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevationClass {
  level1: ShadowSpec = new ShadowSpec(4, 2, 0.1)
  level2: ShadowSpec = new ShadowSpec(8, 4, 0.14)
  level3: ShadowSpec = new ShadowSpec(12, 6, 0.16)
}

const AppElevation: AppElevationClass = new AppElevationClass()

class FontSpec {
  size: number
  weight: FontWeight
  constructor(size: number, weight: FontWeight) {
    this.size = size
    this.weight = weight
  }
}

class AppTypographyClass {
  displayLarge: FontSpec = new FontSpec(28, FontWeight.Bold)
  headlineMedium: FontSpec = new FontSpec(20, FontWeight.Medium)
  titleMedium: FontSpec = new FontSpec(16, FontWeight.Medium)
  bodyMedium: FontSpec = new FontSpec(14, FontWeight.Regular)
  labelMedium: FontSpec = new FontSpec(12, FontWeight.Medium)
}

const AppTypography: AppTypographyClass = new AppTypographyClass()

interface Client {
  id: number
  name: string
  region: string
  level: string
  x: number
  y: number
}

class ClientItem implements Client {
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

const clients: Client[] = [
  new ClientItem(1, 'Sunrise Tech', 'Shanghai', 'A', 0.2, 0.3),
  new ClientItem(2, 'Delta Logistics', 'Beijing', 'B', 0.5, 0.45),
  new ClientItem(3, 'Oceanic Foods', 'Guangzhou', 'A', 0.72, 0.6),
  new ClientItem(4, 'Horizon Ltd.', 'Chengdu', 'C', 0.33, 0.75),
]

function getMarkerColor(level: string): ResourceColor {
  if (level === 'A') {
    return AppColors.primary
  } else if (level === 'B') {
    return AppColors.secondary
  } else {
    return AppColors.tertiary
  }
}

function getMarkerStrokeColor(selected: boolean): ResourceColor {
  return selected ? AppColors.onPrimary : AppColors.surface
}

const gridLineCount: number = 6

function buildGridIndices(): number[] {
  let result: number[] = []
  for (let i: number = 0; i < gridLineCount; i++) {
    result.push(i)
  }
  return result
}

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
  private gridIndices: number[] = buildGridIndices()

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      ForEach(this.gridIndices, (i: number) => {
        Rect()
          .fill(AppColors.surfaceVariant)
          .width(this.mapWidth - 2 * AppSpacing.lg)
          .height(1)
          .position({
            x: AppSpacing.lg,
            y: AppSpacing.lg + ((this.mapHeight - 2 * AppSpacing.lg) / 7) * (i + 1),
          })
      }, (i: number) => `h-${i}` as string)

      ForEach(this.gridIndices, (i: number) => {
        Rect()
          .fill(AppColors.surfaceVariant)
          .width(1)
          .height(this.mapHeight - 2 * AppSpacing.lg)
          .position({
            x: AppSpacing.lg + ((this.mapWidth - 2 * AppSpacing.lg) / 7) * (i + 1),
            y: AppSpacing.lg,
          })
      }, (i: number) => `v-${i}` as string)
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
              direction: GradientDirection.Left,
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
