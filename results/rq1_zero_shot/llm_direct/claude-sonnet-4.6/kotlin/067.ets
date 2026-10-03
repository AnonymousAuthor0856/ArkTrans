import { router } from '@kit.ArkUI';

// ==================== Tokens ====================
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FFFF7043';
    export const secondary: string = '#FFFFB74D';
    export const tertiary: string = '#FFFFD54F';
    export const background: string = '#FFFFF8E1';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFFFECB3';
    export const outline: string = '#FFE0C097';
    export const success: string = '#FF43A047';
    export const warning: string = '#FFFBC02D';
    export const error: string = '#FFE53935';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FF3E2723';
    export const onTertiary: string = '#FF3E2723';
    export const onBackground: string = '#FF3E2723';
    export const onSurface: string = '#FF3E2723';
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28;
    export const headlineSize: number = 20;
    export const titleSize: number = 16;
    export const bodySize: number = 14;
    export const labelSize: number = 12;
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 32;
  }
}

// ==================== Data ====================
interface Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
}

const clientsData: Client[] = [
  { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
  { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
  { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
  { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 },
];

// ==================== MapGridOverlay ====================
@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // Horizontal lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .color(AppTokens.Colors.surfaceVariant)
            .strokeWidth(1)
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.SpaceAround)

      // Vertical lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .vertical(true)
            .color(AppTokens.Colors.surfaceVariant)
            .strokeWidth(1)
            .height('100%')
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .height('100%')
  }
}

// ==================== MapMarker ====================
@Component
struct MapMarker {
  label: string = '';
  level: string = '';
  selected: boolean = false;
  onClick: () => void = () => {};
  offsetX: number = 0;
  offsetY: number = 0;

  markerColor(): string {
    if (this.level === 'A') return AppTokens.Colors.primary;
    if (this.level === 'B') return AppTokens.Colors.secondary;
    return AppTokens.Colors.tertiary;
  }

  build() {
    Stack() {
      // Circle marker
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.markerColor())
        .stroke(this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface)
        .strokeWidth(2)
        .position({ x: this.offsetX, y: this.offsetY })

      // Label card
      Text(this.label)
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(8)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .shadow({ radius: 4, offsetY: 2, color: '#1A000000' })
        .position({ x: this.offsetX + 20, y: this.offsetY - 4 })
        .onClick(() => this.onClick())
    }
    .width('100%')
    .height('100%')
  }
}

// ==================== ClientCard ====================
@Component
struct ClientCard {
  client: Client = { id: 0, name: '', region: '', level: '', x: 0, y: 0 };

  build() {
    Row() {
      Column() {
        Text(this.client.name)
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Blank().height(AppTokens.Spacing.xs)
        Text(this.client.region)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Text(`Level ${this.client.level}`)
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.primary)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, offsetY: 2, color: '#1A000000' })
  }
}

// ==================== MapPanel ====================
@Component
struct MapPanel {
  @State selectedId: number | null = null;
  mapWidth: number = 0;
  mapHeight: number = 0;

  build() {
    Stack() {
      MapGridOverlay()

      ForEach(clientsData, (c: Client) => {
        MapMarker({
          label: c.name,
          level: c.level,
          selected: this.selectedId === c.id,
          onClick: () => {
            this.selectedId = this.selectedId === c.id ? null : c.id;
          },
          offsetX: this.mapWidth * c.x,
          offsetY: this.mapHeight * c.y,
        })
      })
    }
    .width('100%')
    .aspectRatio(0.9)
    .constraintSize({ minHeight: 360 })
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(16)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .onAreaChange((_oldVal, newVal) => {
      this.mapWidth = newVal.width as number;
      this.mapHeight = newVal.height as number;
    })
  }
}

// ==================== RootScreen ====================
@Component
struct RootScreen {
  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Client Detail')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Scrollable content
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          // Hero banner
          Stack() {
            Text('Regional Client Map')
              .fontSize(AppTokens.TypographyTokens.headlineSize)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width('100%')
          .height(200)
          .borderRadius(16)
          .linearGradient({
            angle: 135,
            colors: [
              [AppTokens.Colors.secondary, 0.0],
              [AppTokens.Colors.primary, 1.0]
            ]
          })
          .alignContent(Alignment.Center)

          // Map panel
          MapPanel()

          // Client list
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(clientsData, (c: Client) => {
              ClientCard({ client: c })
            })
          }
          .width('100%')
          .padding({ bottom: AppTokens.Spacing.xxl })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// ==================== Entry ====================
@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}