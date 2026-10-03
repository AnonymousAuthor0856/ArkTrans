// Build profile: compileSdkVersion 12, compatibleSdkVersion 12, targetSdkVersion 12
// Build profile: runtimeOS HarmonyOS
// Build profile: signingConfig default
// Build profile: module name entry
// Build profile: product name default
// Build profile: buildMode debug
// Build profile: target name default

import log from '@ohos.hilog';
import { Length, ResourceStr } from '@ohos.arkui';

const DOMAIN = 0x0000;
const TAG = 'SingleFileUI';

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
    onSurface: '#FF3E2723'
  };
  static readonly TypographyTokens = {
    display: { fontSize: '28fp', fontWeight: FontWeight.Bold },
    headline: { fontSize: '20fp', fontWeight: FontWeight.Medium },
    title: { fontSize: '16fp', fontWeight: FontWeight.Medium },
    body: { fontSize: '14fp', fontWeight: FontWeight.Normal },
    label: { fontSize: '12fp', fontWeight: FontWeight.Medium }
  };
  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  };
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };
  static readonly ElevationMapping = {
    level1: 1,
    level2: 3,
    level3: 6
  };
}

class Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;

  constructor(id: number, name: string, region: string, level: string, x: number, y: number) {
    this.id = id;
    this.name = name;
    this.region = region;
    this.level = level;
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct RootScreen {
  private clients: Client[] = [
    new Client(1, 'Sunrise Tech', 'Shanghai', 'A', 0.2, 0.3),
    new Client(2, 'Delta Logistics', 'Beijing', 'B', 0.5, 0.45),
    new Client(3, 'Oceanic Foods', 'Guangzhou', 'A', 0.72, 0.6),
    new Client(4, 'Horizon Ltd.', 'Chengdu', 'C', 0.33, 0.75)
  ];
  @State selectedId: number | null = null;

  aboutToAppear() {
    log.info(DOMAIN, TAG, 'RootScreen aboutToAppear');
  }

  build() {
    Column() {
      // Top App Bar
      Text('Client Detail')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md });

      // Main Content
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          // Regional Client Map Banner
          Stack() {
            Text('Regional Client Map')
              .fontSize(AppTokens.TypographyTokens.headline.fontSize)
              .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
              .fontColor(AppTokens.Colors.onPrimary);
          }
          .width('100%')
          .height(200)
          .linearGradient({
            angle: 90,
            colors: [[AppTokens.Colors.secondary, 0.0], [AppTokens.Colors.primary, 1.0]]
          })
          .borderRadius(AppTokens.Shapes.large);

          // Map Container
          Stack() {
            // Grid Overlay
            this.MapGridOverlay();

            // Markers
            ForEach(this.clients, (c: Client) => {
              this.MapMarker({
                label: c.name,
                level: c.level,
                selected: this.selectedId === c.id,
                onClick: () => {
                  this.selectedId = this.selectedId === c.id ? null : c.id;
                }
              })
                .markAnchor({ x: 0, y: 0 })
                .offset({ x: `${c.x * 100}%`, y: `${c.y * 100}%` });
            }, (c: Client) => c.id.toString());
          }
          .width('100%')
          .aspectRatio(0.9)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline });

          // Client List
          ForEach(this.clients, (c: Client) => {
            this.ClientCard({ client: c });
          }, (c: Client) => c.id.toString());
        }
        .width('100%')
        .padding({ bottom: AppTokens.Spacing.xxl });
      }
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }

  @Builder
  ClientCard(client: Client) {
    Row() {
      Column({ space: AppTokens.Spacing.xs }) {
        Text(client.name)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface);
        Text(client.region)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface);
      }
      .alignItems(HorizontalAlign.Start);

      Blank();

      Text(`Level ${client.level}`)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .fontColor(AppTokens.Colors.primary);
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: AppTokens.ElevationMapping.level1, color: '#33000000', offsetX: 0, offsetY: 2 });
  }

  @Builder
  MapMarker(label: string, level: string, selected: boolean, onClick: () => void) {
    Stack() {
      // Marker Dot
      Stack()
        .width(selected ? 28 : 22)
        .height(selected ? 28 : 22)
        .backgroundColor(this.getMarkerColor(level))
        .border({ width: 2, color: selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface })
        .borderRadius(14);

      // Label Card
      Text(label)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .borderRadius(AppTokens.Shapes.small)
        .shadow({ radius: AppTokens.ElevationMapping.level1, color: '#33000000', offsetX: 0, offsetY: 2 })
        .markAnchor({ x: 0, y: 0 })
        .offset({ x: 20, y: -4 })
        .onClick(() => onClick());
    }
  }

  @Builder
  MapGridOverlay() {
    Column() {
      ForEach([0, 1, 2, 3, 4, 5], () => {
        Divider().width('100%').height(1).color(AppTokens.Colors.surfaceVariant);
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding(AppTokens.Spacing.lg);

    Row() {
      ForEach([0, 1, 2, 3, 4, 5], () => {
        Divider().height('100%').width(1).color(AppTokens.Colors.surfaceVariant).vertical(true);
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding(AppTokens.Spacing.lg);
  }

  private getMarkerColor(level: string): string {
    switch (level) {
      case 'A':
        return AppTokens.Colors.primary;
      case 'B':
        return AppTokens.Colors.secondary;
      default:
        return AppTokens.Colors.tertiary;
    }
  }
}