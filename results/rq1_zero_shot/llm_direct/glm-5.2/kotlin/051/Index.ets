import { Length, ResourceStr } from '@ohos.arkui.component';
import { common } from '@kit.AbilityKit';

const NAME = "068*MetroPlanner*en";
const UI_TYPE = "Travel";
const STYLE_THEME = "Dark Neon";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static readonly Colors = {
    primary: '#00FFFF',
    secondary: '#00B4FF',
    tertiary: '#8A2BE2',
    background: '#0A0A1A',
    surface: '#141436',
    surfaceVariant: '#1E1E4A',
    outline: '#2E2E5C',
    success: '#00FFAA',
    warning: '#FFCC00',
    error: '#FF4444',
    onPrimary: '#0A0A1A',
    onSecondary: '#FFFFFF',
    onBackground: '#FFFFFF',
    onSurface: '#FFFFFF',
  };
  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };
  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 22,
  };
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36,
  };
  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 },
  };
}

@Entry
@Component
struct RootScreen {
  private stations: string[] = ["A", "B", "C", "D", "E", "F"];
  private departures: string[] = ["08:45 • Line 1", "09:10 • Line 2", "09:30 • Line 3"];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Column() {
          Text("Metro Planner")
            .fontSize(AppTokens.TypographyTokens.display.fontSize)
            .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
            .fontColor(AppTokens.Colors.primary)
            .margin({ bottom: AppTokens.Spacing.lg });

          // Canvas Replacement for Route Map
          Stack() {
            // Path Line
            Polyline({
              points: this.generatePolylinePoints(),
              fillOpacity: 0,
              strokeColor: AppTokens.Colors.secondary,
              strokeWidth: 6
            })
              .width('100%')
              .height('100%');

            // Stations
            ForEach(this.stations, (s: string, i: number) => {
              Row() {
                Circle({ width: 32, height: 32 })
                  .fill(AppTokens.Colors.primary)
                  .position({
                    x: `${(i / (this.stations.length - 1)) * 100}%`,
                    y: i % 2 === 0 ? '25%' : '75%'
                  })
                  .markAnchor(Alignment.Center);

                Circle({ width: 12, height: 12 })
                  .fill(AppTokens.Colors.background)
                  .position({
                    x: `${(i / (this.stations.length - 1)) * 100}%`,
                    y: i % 2 === 0 ? '25%' : '75%'
                  })
                  .markAnchor(Alignment.center);
              }
              .width('100%')
              .height('100%');
            })
          }
          .width('100%')
          .height(260)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .padding(AppTokens.Spacing.md)
          .margin({ bottom: AppTokens.Spacing.lg });

          // Next Departures Card
          Column() {
            Text("Next Departures")
              .fontSize(AppTokens.TypographyTokens.title.fontSize)
              .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
              .fontColor(AppTokens.Colors.secondary)
              .margin({ bottom: AppTokens.Spacing.sm });

            ForEach(this.departures, (dep: string) => {
              Row() {
                Text(dep)
                  .fontSize(AppTokens.TypographyTokens.body.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .layoutWeight(1);

                Text("On Time")
                  .fontSize(AppTokens.TypographyTokens.label.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                  .fontColor(AppTokens.Colors.success);
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ bottom: AppTokens.Spacing.sm });
            })
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy
          });

          Blank().height(AppTokens.Spacing.md);
        }
        .width('100%')
        .height('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.lg, bottom: 80 })
        .linearGradient({
          angle: 180,
          colors: [
            [AppTokens.Colors.background, 0.0],
            [AppTokens.Colors.surfaceVariant, 0.5],
            [AppTokens.Colors.background, 1.0]
          ]
        });

        // Bottom Bar
        Row() {
          Text("Routes")
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.secondary)
            .layoutWeight(1)
            .textAlign(TextAlign.Center);

          Text("Planner")
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center);

          Text("Tickets")
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center);

          Text("Profile")
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center);
        }
        .width('100%')
        .height(60)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)
        .position({ x: 0, y: '100%' })
        .markAnchor({ x: 0, y: '100%' });
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background);

      // Floating Action Button
      Button({ type: ButtonType.Circle }) {
        Text("+")
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary);
      }
      .width(56)
      .height(56)
      .backgroundColor(AppTokens.Colors.primary)
      .position({ x: '100%', y: '100%' })
      .markAnchor({ x: '100%', y: '100%' })
      .offset({ x: -24, y: -80 });
    }
    .width('100%')
    .height('100%');
  }

  private generatePolylinePoints(): string {
    let points: string[] = [];
    for (let i = 0; i < this.stations.length; i++) {
      let x = (i / (this.stations.length - 1)) * 100;
      let y = i % 2 === 0 ? 25 : 75;
      points.push(`${x}%,${y}%`);
    }
    return points.join(' ');
  }
}