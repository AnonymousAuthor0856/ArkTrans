import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';

// --- App Tokens & Constants ---

const NAME = "112*ClientDetail*en";
const UI_TYPE = "Dashboard";
const STYLE_THEME = "Warm Gradient";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

interface ShadowSpec {
  elevation: number; // dp
  radius: number;    // dp
  dy: number;        // dp
  opacity: number;   // float
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF7043';
    export const secondary: string = '#FFB74D';
    export const tertiary: string = '#FFD54F';
    export const background: string = '#FFF8E1';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#FFECB3';
    export const outline: string = '#E0C097';
    export const success: string = '#43A047';
    export const warning: string = '#FBC02D';
    export const error: string = '#E53935';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#3E2723';
    export const onTertiary: string = '#3E2723';
    export const onBackground: string = '#3E2723';
    export const onSurface: string = '#3E2723';
  }

  export namespace TypographyTokens {
    export const display: number = 28;
    export const headline: number = 20;
    export const title: number = 16;
    export const body: number = 14;
    export const label: number = 12;
  }

  export namespace Shapes {
    export const small: number = 8;
    export const medium: number = 12;
    export const large: number = 16;
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 32;
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = { elevation: 1, radius: 4, dy: 2, opacity: 0.1 };
    export const level2: ShadowSpec = { elevation: 3, radius: 8, dy: 4, opacity: 0.14 };
    export const level3: ShadowSpec = { elevation: 6, radius: 12, dy: 6, opacity: 0.16 };
  }
}

// --- Data Models ---

interface Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
}

// --- Components ---

@Builder
function MapGridOverlay() {
  Stack() {
    Column() {
      ForEach(Array.from({ length: 6 }, (_, i: number) => i), () => {
        Row()
          .width('100%')
          .height(1)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
      })
    }
    .layoutWeight(1)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    .justifyContent(FlexAlign.SpaceEvenly)

    Row() {
      ForEach(Array.from({ length: 6 }, (_, i: number) => i), () => {
        Column()
          .width(1)
          .height('100%')
          .backgroundColor(AppTokens.Colors.surfaceVariant)
      })
    }
    .layoutWeight(1)
    .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
    .justifyContent(FlexAlign.SpaceEvenly)
  }
  .width('100%')
  .height('100%')
}

@Component
struct MapMarker {
  @Prop label: string;
  @Prop level: string;
  @Prop selected: boolean;
  @Prop offsetX: number;
  @Prop offsetY: number;
  private onClickCallback: ((event?: ClickEvent) => void) | null = null;

  aboutToAppear(): void {
    this.onClickCallback = () => {};
  }

  build() {
    Stack() {
      // Dot
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.getLevelColor())
        .border({
          width: 2,
          color: this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface
        })
        .position({ x: 0, y: 0 })

      // Label Card
      Text(this.label)
        .fontSize(AppTokens.TypographyTokens.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: 'rgba(0, 0, 0, 0.1)',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        })
        .onClick(() => {
          if (this.onClickCallback) {
            this.onClickCallback();
          }
        })
        .position({ x: 20, y: -4 })
    }
    .position({ x: this.offsetX, y: this.offsetY })
  }

  getLevelColor(): string {
    switch (this.level) {
      case 'A': return AppTokens.Colors.primary;
      case 'B': return AppTokens.Colors.secondary;
      default: return AppTokens.Colors.tertiary;
    }
  }
}

@Component
struct ClientCard {
  @Prop client: Client;

  build() {
    Row() {
      Column() {
        Text(this.client.name)
          .fontSize(AppTokens.TypographyTokens.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(this.client.region)
          .fontSize(AppTokens.TypographyTokens.body)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xs })
      }

      Blank()

      Text(`Level ${this.client.level}`)
        .fontSize(AppTokens.TypographyTokens.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.primary)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State clients: Client[] = [
    { id: 1, name: "Sunrise Tech", region: "Shanghai", level: "A", x: 0.2, y: 0.3 },
    { id: 2, name: "Delta Logistics", region: "Beijing", level: "B", x: 0.5, y: 0.45 },
    { id: 3, name: "Oceanic Foods", region: "Guangzhou", level: "A", x: 0.72, y: 0.6 },
    { id: 4, name: "Horizon Ltd.", region: "Chengdu", level: "C", x: 0.33, y: 0.75 }
  ];
  @State selectedId: number | null = null;

  aboutToAppear() {
    // Hide navigation bar if possible, similar to Android's immersive mode
    try {
      let windowClass: window.Window = undefined as unknown as window.Window;
      // Note: Accessing window instance directly in component might require context or specific API usage depending on OS version.
      // For standard ArkUI preview/testing, we often rely on system settings or specific entry ability configurations.
      // This is a placeholder for the intent of hiding bars.
    } catch (e: Error) {
      console.error("Window access error", e);
    }
  }

  build() {
    Column() {
      // Top Bar Area (Simulated CenterAlignedTopAppBar)
      Row() {
        Text("Client Detail")
          .fontSize(AppTokens.TypographyTokens.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: AppTokens.Spacing.xxl, bottom: AppTokens.Spacing.md })

      // Main Content
      Column() {
        // Header Box
        Row() {
          Text("Regional Client Map")
            .fontSize(AppTokens.TypographyTokens.headline)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width('100%')
        .height(200)
        .linearGradient({
          direction: GradientDirection.RightBottom,
          colors: [['#FFB74D', 0], ['#FF7043', 1]]
        })
        .borderRadius(AppTokens.Shapes.large)
        .justifyContent(FlexAlign.Center)

        // Map Container
        Stack() {
          MapGridOverlay()

          ForEach(this.clients, (client: Client) => {
            MapMarker({
              label: client.name,
              level: client.level,
              selected: this.selectedId === client.id,
              offsetX: client.x * 100,
              offsetY: client.y * 100
            })
          })
        }
        .width('100%')
        .height(360)
        .aspectRatio(0.9)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .margin({ top: AppTokens.Spacing.md })

        // Client List
        List({ space: AppTokens.Spacing.md }) {
          ForEach(this.clients, (client: Client) => {
            ListItem() {
              ClientCard({ client: client })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .margin({ top: AppTokens.Spacing.md })
        .padding({ bottom: AppTokens.Spacing.xxl })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}