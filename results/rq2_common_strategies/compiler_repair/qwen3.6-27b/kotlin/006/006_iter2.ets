import { window } from '@kit.ArkUI';
import { common, UIAbility } from '@kit.AbilityKit';

// --- Design Tokens & Constants ---

interface AppTokenColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface AppTokenSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface ElevationLevel {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface AppTokensConfig {
  Colors: AppTokenColors;
  Spacing: AppTokenSpacing;
  Elevation: {
    level1: ElevationLevel;
    level2: ElevationLevel;
  };
}

const AppTokens: AppTokensConfig = {
  Colors: {
    primary: '#2196F3',
    secondary: '#4CAF50',
    tertiary: '#FF9800',
    background: '#F5F7FA',
    surface: '#FFFFFF',
    surfaceVariant: '#E8F5E8',
    outline: '#E0E0E0',
    success: '#4CAF50',
    warning: '#FF9800',
    error: '#F44336',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#263238',
    onSurface: '#263238'
  },
  Spacing: {
    xs: 4,
    sm: 6,
    md: 10,
    lg: 14,
    xl: 18,
    xxl: 24,
    xxxl: 32
  },
  Elevation: {
    level1: { elevation: 1, radius: 3, dy: 1, opacity: 0.1 },
    level2: { elevation: 2, radius: 5, dy: 2, opacity: 0.12 }
  }
};

interface WeatherHour {
  hour: string;
  temp: string;
  condition: string;
  color: string;
}

interface WeatherDay {
  day: string;
  high: string;
  low: string;
  condition: string;
  color: string;
}

@Entry
@Component
struct RootScreen {
  @State currentLocation: string = 'New York';
  @State temperature: string = '72°';
  @State condition: string = 'Sunny';
  @State feelsLike: string = '74°';
  @State humidity: string = '45%';
  @State wind: string = '5 mph';

  private hourlyForecast: WeatherHour[] = [
    { hour: 'Now', temp: '72°', condition: 'Sunny', color: AppTokens.Colors.tertiary },
    { hour: '1 PM', temp: '74°', condition: 'Sunny', color: AppTokens.Colors.tertiary },
    { hour: '2 PM', temp: '75°', condition: 'Sunny', color: AppTokens.Colors.tertiary },
    { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: AppTokens.Colors.primary },
    { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: AppTokens.Colors.primary },
    { hour: '5 PM', temp: '72°', condition: 'Rain', color: AppTokens.Colors.secondary },
    { hour: '6 PM', temp: '70°', condition: 'Rain', color: AppTokens.Colors.secondary }
  ];

  private weeklyForecast: WeatherDay[] = [
    { day: 'Today', high: '76°', low: '62°', condition: 'Sunny', color: AppTokens.Colors.tertiary },
    { day: 'Mon', high: '74°', low: '60°', condition: 'Cloudy', color: AppTokens.Colors.primary },
    { day: 'Tue', high: '72°', low: '58°', condition: 'Rain', color: AppTokens.Colors.secondary },
    { day: 'Wed', high: '70°', low: '56°', condition: 'Rain', color: AppTokens.Colors.secondary },
    { day: 'Thu', high: '73°', low: '59°', condition: 'Cloudy', color: AppTokens.Colors.primary },
    { day: 'Fri', high: '75°', low: '61°', condition: 'Sunny', color: AppTokens.Colors.tertiary },
    { day: 'Sat', high: '77°', low: '63°', condition: 'Sunny', color: AppTokens.Colors.tertiary }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Weather')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(-0.2)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.Transparent)

      // Main Content Scrollable Area
      Scroll() {
        Column() {
          // Current Weather Card
          Card() {
            Column() {
              Text(this.currentLocation)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)

              Text(this.temperature)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .lineHeight(36)
                .fontColor(AppTokens.Colors.onSurface)

              Text(this.condition)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color(AppTokens.Colors.onSurface).withAlpha(0.7))

              Row() {
                Column() {
                  Text('Feels like')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color(AppTokens.Colors.onSurface).withAlpha(0.7))
                  Text(this.feelsLike)
                    .fontSize(12)
                    .fontColor(AppTokens.Colors.onSurface)
                }
                .alignItems(HorizontalAlign.Center)
                .margin({ right: AppTokens.Spacing.xs })

                Column() {
                  Text('Humidity')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color(AppTokens.Colors.onSurface).withAlpha(0.7))
                  Text(this.humidity)
                    .fontSize(12)
                    .fontColor(AppTokens.Colors.onSurface)
                }
                .alignItems(HorizontalAlign.Center)
                .margin({ right: AppTokens.Spacing.xs })

                Column() {
                  Text('Wind')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color(AppTokens.Colors.onSurface).withAlpha(0.7))
                  Text(this.wind)
                    .fontSize(12)
                    .fontColor(AppTokens.Colors.onSurface)
                }
                .alignItems(HorizontalAlign.Center)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceEvenly)
              .alignItems(VerticalAlign.Center)
            }
            .padding(AppTokens.Spacing.lg)
            .alignItems(HorizontalAlign.Center)
            .margin({ top: AppTokens.Spacing.sm })
          }
          .width('100%')
          .borderRadius(14)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({
            radius: AppTokens.Elevation.level2.radius,
            color: Color('#000000').withAlpha(AppTokens.Elevation.level2.opacity),
            offsetX: 0,
            offsetY: AppTokens.Elevation.level2.dy
          })

          // Hourly Forecast Section
          Text('Hourly Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })

          Scroll() {
            Row() {
              ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                Card() {
                  Column() {
                    Text(hour.hour)
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(AppTokens.Colors.onSurface)

                    Circle()
                      .width(20)
                      .height(20)
                      .fill(Color(hour.color))

                    Text(hour.temp)
                      .fontSize(12)
                      .fontColor(AppTokens.Colors.onSurface)
                  }
                  .padding(AppTokens.Spacing.sm)
                  .alignItems(HorizontalAlign.Center)
                  .margin({ top: AppTokens.Spacing.xs })
                }
                .width(70)
                .borderRadius(10)
                .backgroundColor(AppTokens.Colors.surface)
                .shadow({
                  radius: AppTokens.Elevation.level1.radius,
                  color: Color('#000000').withAlpha(AppTokens.Elevation.level1.opacity),
                  offsetX: 0,
                  offsetY: AppTokens.Elevation.level1.dy
                })
                .margin({ right: AppTokens.Spacing.sm })
              })
            }
          }
          .width('100%')
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          // Weekly Forecast Section
          Text('7-Day Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })

          Column() {
            ForEach(this.weeklyForecast, (day: WeatherDay) => {
              Card() {
                Row() {
                  Text(day.day)
                    .fontSize(12)
                    .fontColor(AppTokens.Colors.onSurface)
                    .width(40)

                  Circle()
                    .width(16)
                    .height(16)
                    .fill(Color(day.color))

                  Row() {
                    Text(day.high)
                      .fontSize(12)
                      .fontColor(AppTokens.Colors.onSurface)
                    Text(day.low)
                      .fontSize(12)
                      .fontColor(Color(AppTokens.Colors.onSurface).withAlpha(0.5))
                  }
                  .margin({ left: AppTokens.Spacing.sm })
                  .alignItems(VerticalAlign.Center)
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
                .padding(AppTokens.Spacing.md)
              }
              .width('100%')
              .borderRadius(6)
              .backgroundColor(AppTokens.Colors.surface)
              .shadow({
                radius: AppTokens.Elevation.level1.radius,
                color: Color('#000000').withAlpha(AppTokens.Elevation.level1.opacity),
                offsetX: 0,
                offsetY: AppTokens.Elevation.level1.dy
              })
              .margin({ bottom: AppTokens.Spacing.sm })
            })
          }

          // Additional Info Card
          Card() {
            Row() {
              Column() {
                Text('UV Index')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color(AppTokens.Colors.onSurface).withAlpha(0.7))
                Text('Moderate')
                  .fontSize(12)
                  .fontColor(AppTokens.Colors.onSurface)
              }
              .margin({ right: AppTokens.Spacing.xs })

              Column() {
                Text('Sunset')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color(AppTokens.Colors.onSurface).withAlpha(0.7))
                Text('7:45 PM')
                  .fontSize(12)
                  .fontColor(AppTokens.Colors.onSurface)
              }
              .margin({ right: AppTokens.Spacing.xs })

              Column() {
                Text('Visibility')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color(AppTokens.Colors.onSurface).withAlpha(0.7))
                Text('10 mi')
                  .fontSize(12)
                  .fontColor(AppTokens.Colors.onSurface)
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .padding(AppTokens.Spacing.md)
          }
          .width('100%')
          .borderRadius(10)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .shadow({
            radius: AppTokens.Elevation.level1.radius,
            color: Color('#000000').withAlpha(AppTokens.Elevation.level1.opacity),
            offsetX: 0,
            offsetY: AppTokens.Elevation.level1.dy
          })
          .margin({ bottom: 80 }) // Space for bottom bar
        }
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
        .margin({ top: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Navigation Bar
      Surface() {
        Row() {
          this.LocationButton('NY', 'New York')
          this.LocationButton('London', 'London')
          this.LocationButton('Tokyo', 'Tokyo')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
        .padding(AppTokens.Spacing.md)
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius({ topLeft: 14, topRight: 14, bottomLeft: 0, bottomRight: 0 })
      .shadow({
        radius: AppTokens.Elevation.level2.radius,
        color: Color('#000000').withAlpha(AppTokens.Elevation.level2.opacity),
        offsetX: 0,
        offsetY: -AppTokens.Elevation.level2.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  LocationButton(label: string, location: string) {
    Button(label)
      .type(ButtonType.Normal)
      .backgroundColor(this.currentLocation === location ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .fontColor(this.currentLocation === location ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .borderRadius(10)
      .height(32)
      .width(80)
      .onClick(() => {
        this.currentLocation = location;
      })
  }
}

@Component
struct Surface {
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content();
    }
  }
}

@Component
struct Card {
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content();
    }
  }
}

// Helper to set up window properties similar to Android's WindowInsetsController
export function setupWindow(context: common.UIAbilityContext) {
  let windowClass: window.Window | null = null;
  try {
    windowClass = window.getWindowSync(context);
    if (windowClass) {
      windowClass.setWindowLayoutFullScreen(true);
    }
  } catch (e) {
    console.error(`Failed to set window layout full screen: ${JSON.stringify(e)}`);
  }
}

// Call setupWindow in the entry ability if needed, though ArkTS handles system bars differently by default.
// For a pure UI component file, we just export the struct.