// Index.ets

interface Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokensColors {
  static primary: string = '#FFFF7043';
  static secondary: string = '#FFFFB74D';
  static tertiary: string = '#FFFFD54F';
  static background: string = '#FFFFF8E1';
  static surface: string = '#FFFFFFFF';
  static surfaceVariant: string = '#FFFFECB3';
  static outline: string = '#FFE0C097';
  static success: string = '#FF43A047';
  static warning: string = '#FFFBC02D';
  static error: string = '#FFE53935';
  static onPrimary: string = '#FFFFFFFF';
  static onSecondary: string = '#FF3E2723';
  static onTertiary: string = '#FF3E2723';
  static onBackground: string = '#FF3E2723';
  static onSurface: string = '#FF3E2723';
}

class AppTokensSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;
}

class AppTokensElevationMapping {
  static level1: ShadowSpec = { elevation: 1, radius: 4, dy: 2, opacity: 0.1 };
  static level2: ShadowSpec = { elevation: 3, radius: 8, dy: 4, opacity: 0.14 };
  static level3: ShadowSpec = { elevation: 6, radius: 12, dy: 6, opacity: 0.16 };
}

@Entry
@Component
struct RootScreen {
  private clients: Client[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ];
  @State selectedId: number | null = null;

  private getMarkerColor(level: string): string {
    if (level === 'A') {
      return AppTokensColors.primary;
    } else if (level === 'B') {
      return AppTokensColors.secondary;
    } else {
      return AppTokensColors.tertiary;
    }
  }

  build() {
    Column() {
      // Top App Bar
      Text('Client Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokensColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16);

      // Main Content
      Column({ space: AppTokensSpacing.md }) {
        // Regional Client Map Banner
        Stack() {
          Text('Regional Client Map')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokensColors.onPrimary);
        }
        .width('100%')
        .height(200)
        .linearGradient({
          angle: 90,
          colors: [[AppTokensColors.secondary, 0.0], [AppTokensColors.primary, 1.0]]
        })
        .borderRadius(16)
        .alignContent(Alignment.Center);

        // Map Container
        Stack() {
          // Grid Overlay
          Column() {
            ForEach([0, 1, 2, 3, 4, 5], () => {
              Divider().color(AppTokensColors.surfaceVariant).strokeWidth(1).width('100%');
            })
          }
          .width('100%')
          .height('100%')
          .padding(AppTokensSpacing.lg)
          .justifyContent(FlexAlign.SpaceEvenly);

          Row() {
            ForEach([0, 1, 2, 3, 4, 5], () => {
              Divider().vertical(true).color(AppTokensColors.surfaceVariant).strokeWidth(1).height('100%');
            })
          }
          .width('100%')
          .height('100%')
          .padding(AppTokensSpacing.lg)
          .justifyContent(FlexAlign.SpaceEvenly);

          // Markers
          ForEach(this.clients, (c: Client) => {
            Stack() {
              Circle({ width: this.selectedId === c.id ? 28 : 22, height: this.selectedId === c.id ? 28 : 22 })
                .fill(this.getMarkerColor(c.level))
                .border({ width: 2, color: this.selectedId === c.id ? AppTokensColors.onPrimary : AppTokensColors.surface });

              Text(c.name)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokensColors.onSurface)
                .backgroundColor(AppTokensColors.surfaceVariant)
                .border({ width: 1, color: AppTokensColors.outline })
                .borderRadius(8)
                .padding({ left: AppTokensSpacing.sm, right: AppTokensSpacing.sm, top: AppTokensSpacing.xs, bottom: AppTokensSpacing.xs })
                .markAnchor({ x: 0, y: 0 })
                .offset({ x: 20, y: -4 })
                .onClick(() => {
                  this.selectedId = this.selectedId === c.id ? null : c.id;
                });
            }
            .markAnchor({ x: '50%', y: '50%' })
            .offset({ x: `${c.x * 100}%`, y: `${c.y * 100}%` });
          }, (c: Client) => c.id.toString());
        }
        .width('100%')
        .aspectRatio(0.9)
        .backgroundColor(AppTokensColors.surface)
        .border({ width: 1, color: AppTokensColors.outline })
        .borderRadius(16)
        .clip(true);

        // Client List
        Scroll() {
          Column({ space: AppTokensSpacing.md }) {
            ForEach(this.clients, (c: Client) => {
              Row() {
                Column({ space: AppTokensSpacing.xs }) {
                  Text(c.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokensColors.onSurface);
                  Text(c.region)
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(AppTokensColors.onSurface);
                }
                .alignItems(HorizontalAlign.Start);

                Text(`Level ${c.level}`)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokensColors.primary);
              }
              .width('100%')
              .padding(AppTokensSpacing.lg)
              .backgroundColor(AppTokensColors.surface)
              .border({ width: 1, color: AppTokensColors.outline })
              .borderRadius(12)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center);
            }, (c: Client) => c.id.toString());
          }
          .width('100%')
          .padding({ bottom: AppTokensSpacing.xxl });
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off);
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg, top: AppTokensSpacing.md, bottom: AppTokensSpacing.md });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokensColors.background);
  }
}