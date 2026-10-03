import { window } from '@kit.ArkUI'

// --- App Tokens & Constants ---
const NAME = "112*ClientDetail*en"
const UI_TYPE = "Dashboard"
const STYLE_THEME = "Warm Gradient"
const LANG = "en"
const BASELINE_SIZE = "720x1280"

class AppTokens {
  static Colors = {
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
    onSurface: '#3E2723'
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
}

interface Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State selectedId: number | null = null

  private clients: Client[] = [
    { id: 1, name: "Sunrise Tech", region: "Shanghai", level: "A", x: 0.2, y: 0.3 },
    { id: 2, name: "Delta Logistics", region: "Beijing", level: "B", x: 0.5, y: 0.45 },
    { id: 3, name: "Oceanic Foods", region: "Guangzhou", level: "A", x: 0.72, y: 0.6 },
    { id: 4, name: "Horizon Ltd.", region: "Chengdu", level: "C", x: 0.33, y: 0.75 }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Client Detail")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      // Main Content Area
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          
          // Header Banner
          Row() {
            Text("Regional Client Map")
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width('100%')
          .height(200)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .borderRadius(16)
          .linearGradient({
            direction: GradientDirection.Right,
            colors: [['#FFB74D', 0], ['#FF7043', 1]]
          })

          // Map Container
          this.MapContainer()

          // Client List
          LazyColumn({ space: AppTokens.Spacing.md }) {
            ForEach(this.clients, (client: Client) => {
              ListItem() {
                this.ClientCard(client)
              }
            })
          }
          .padding({ bottom: AppTokens.Spacing.xxl })
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  MapContainer() {
    Stack() {
      // Background & Grid
      Column() {
        // Horizontal Lines
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Row().width('100%').height(1).backgroundColor(AppTokens.Colors.surfaceVariant)
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding(AppTokens.Spacing.lg)

      Column() {
        // Vertical Lines
        Row() {
          ForEach([0, 1, 2, 3, 4, 5], () => {
            Column().width(1).height('100%').backgroundColor(AppTokens.Colors.surfaceVariant)
          })
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)

      // Markers
      ForEach(this.clients, (client: Client) => {
        this.MapMarker(client)
      })
    }
    .width('100%')
    .height(360)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(16)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }

  @Builder
  MapMarker(client: Client) {
    Stack() {
      // Dot
      Circle({ width: this.selectedId === client.id ? 28 : 22, height: this.selectedId === client.id ? 28 : 22 })
        .fill(this.getLevelColor(client.level))
        .stroke(this.selectedId === client.id ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface)
        .strokeWidth(2)
      
      // Label Card
      Row() {
        Text(client.name)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(8)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
      .position({ x: 20, y: -4 })
    }
    .onClick(() => {
      this.selectedId = this.selectedId === client.id ? null : client.id
    })
    .position({ 
      x: `${client.x * 100}%`, 
      y: `${client.y * 100}%` 
    })
    .alignContent(Alignment.TopStart)
  }

  @Builder
  ClientCard(client: Client) {
    Row() {
      Column() {
        Text(client.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(client.region)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: 4 })
      }

      Text(`Level ${client.level}`)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.primary)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
  }

  getLevelColor(level: string): string {
    switch (level) {
      case 'A': return AppTokens.Colors.primary
      case 'B': return AppTokens.Colors.secondary
      default: return AppTokens.Colors.tertiary
    }
  }
}