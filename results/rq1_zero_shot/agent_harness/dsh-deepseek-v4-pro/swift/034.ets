// 034.ets - translated from 034.swift (Explore Map)

// MARK: - AppTokens

const CLEAR: string = '#00000000';

class AppTokensColors {
  static readonly primary: string = '#00FF66';
  static readonly secondary: string = '#CCCCCC';
  static readonly tertiary: string = '#999999';
  static readonly background: string = '#000000';
  static readonly surface: string = '#0A0A0A';
  static readonly surfaceVariant: string = '#111111';
  static readonly outline: string = '#1F1F1F';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#FF4444';
  static readonly onPrimary: string = '#000000';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#E0E0E0';
  static readonly onSurface: string = '#E0E0E0';
}

class AppTokensTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 20;
  static readonly headlineWeight: FontWeight = FontWeight.Medium;
  static readonly titleSize: number = 16;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 13;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 11;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppTokensShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppTokensSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

interface ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
}

class AppTokensElevation {
  static readonly level1: ShadowSpec = { radius: 0, y: 0, opacity: 0 };
  static readonly level2: ShadowSpec = { radius: 4, y: 2, opacity: 0.12 };
}

class AppTokens {
  static readonly Colors = AppTokensColors;
  static readonly TypographyTokens = AppTokensTypography;
  static readonly Shapes = AppTokensShapes;
  static readonly Spacing = AppTokensSpacing;
  static readonly ElevationMapping = AppTokensElevation;
}

// MARK: - Data Model

interface MapMarker {
  name: string;
  distance: string;
}

// MARK: - CardView

@Component
struct CardView {
  marker: MapMarker;

  build() {
    Row({ space: 0 }) {
      Column({ space: 0 }) {
        Text(this.marker.name)
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.marker.distance)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(AppTokens.TypographyTokens.bodyWeight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('View')
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(AppTokens.TypographyTokens.labelWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.small)
        .onClick(() => {
          console.log('View ' + this.marker.name + ' Tapped');
        })
    }
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: AppTokens.ElevationMapping.level2.y })
  }
}

// MARK: - RootScreen

@Component
struct RootScreen {
  @State query: string = '';
  @State isSearchFieldFocused: boolean = false;

  private markers: MapMarker[] = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ];

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: 0 }) {
        // Top Bar
        Text('Explore Map')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .backgroundColor(AppTokens.Colors.background)

        // 主内容区域
        Column({ space: AppTokens.Spacing.lg }) {
          // Search Field
          TextInput({ placeholder: 'Search destination', text: this.query })
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontColor(AppTokens.Colors.onSurface)
            .caretColor(AppTokens.Colors.primary)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: this.isSearchFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .width('100%')
            .onChange((value: string) => {
              this.query = value;
            })
            .onFocus(() => {
              this.isSearchFieldFocused = true;
            })
            .onBlur(() => {
              this.isSearchFieldFocused = false;
            })

          // Markers List
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.markers, (marker: MapMarker) => {
              CardView({ marker: marker })
            }, (marker: MapMarker) => marker.name)
          }
          .width('100%')

          Blank()

          // Refresh Map Button
          Button('Refresh Map')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.large)
            .onClick(() => {
              console.log('Refresh Map Tapped');
            })
        }
        .width('100%')
        .height('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - App Entry Point

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
