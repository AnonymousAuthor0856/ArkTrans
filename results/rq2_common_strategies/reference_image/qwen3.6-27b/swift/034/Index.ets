// AppTokens.ts
export class AppTokens {
  static readonly Colors = {
    primary: '#00FF66',
    secondary: '#CCCCCC',
    tertiary: '#999999',
    background: '#000000',
    surface: '#0A0A0A',
    surfaceVariant: '#111111',
    outline: '#1F1F1F',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#FF4444',
    onPrimary: '#000000',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#E0E0E0',
    onSurface: '#E0E0E0'
  }

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Normal },
    label: { size: 11, weight: FontWeight.Medium }
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly ElevationMapping = {
    level2: { radius: 4, y: 2, opacity: 0.12 }
  }
}

// MapMarker.ts
export interface MapMarker {
  id: number;
  name: string;
  distance: string;
}

// CardView.ets
import { AppTokens } from './AppTokens';
import { MapMarker } from './MapMarker';

@Component
export struct CardView {
  marker: MapMarker;

  build() {
    Row() {
      Column() {
        Text(this.marker.name)
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(this.marker.distance)
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      
      Blank()
      
      Button('View')
        .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.small)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
      offsetY: AppTokens.ElevationMapping.level2.y
    })
  }
}

// RootScreen.ets
import { AppTokens } from './AppTokens';
import { MapMarker } from './MapMarker';
import { CardView } from './CardView';

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State isSearchFieldFocused: boolean = false;

  markers: MapMarker[] = [
    { id: 1, name: 'Central Plaza', distance: '1.2 km' },
    { id: 2, name: 'Museum District', distance: '3.4 km' },
    { id: 3, name: 'Tech Park', distance: '5.6 km' },
    { id: 4, name: 'Old Town Gate', distance: '7.8 km' }
  ];

  build() {
    Stack() {
      Column() {
        // Top Bar
        Text('Explore Map')
          .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
          .fontColor(AppTokens.Colors.primary)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        
        // Main Content Area
        Column() {
          // Search Field
          TextInput({ placeholder: 'Search destination' })
            .type(InputType.Text)
            .text(this.query)
            .onChange((value: string) => {
              this.query = value;
            })
            .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor(AppTokens.Colors.tertiary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({
              width: 1,
              color: this.isSearchFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline,
              style: BorderStyle.Solid
            })
            .onFocus(() => {
              this.isSearchFieldFocused = true;
            })
            .onBlur(() => {
              this.isSearchFieldFocused = false;
            })
            .padding(AppTokens.Spacing.md)
            .width('100%')
          
          // Markers List
          Column() {
            ForEach(this.markers, (marker: MapMarker) => {
              CardView({ marker: marker })
                .margin({ bottom: AppTokens.Spacing.md })
            })
          }
          .width('100%')
          
          Blank()
          
          // Refresh Map Button
          Button('Refresh Map')
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.large)
            .height(48)
            .width('100%')
            .onClick(() => {
              console.info('Refresh Map Tapped');
            })
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}