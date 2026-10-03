const NAME: string = '010*ExploreMap*en';
const UI_TYPE: string = 'Social';
const STYLE_THEME: string = 'Monochrome Terminal';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
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

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class MapMarker {
  name: string;
  distance: string;
  constructor(name: string, distance: string) { this.name = name; this.distance = distance; }
}

@Entry
@Component
struct MainActivity {
  @State query: string = '';
  private markers: MapMarker[] = [
    new MapMarker('Central Plaza', '1.2 km'),
    new MapMarker('Museum District', '3.4 km'),
    new MapMarker('Tech Park', '5.6 km'),
    new MapMarker('Old Town Gate', '7.8 km')
  ];

  @Builder
  Header(): void {
    Text('Explore Map')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.primary)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  MarkerCard(marker: MapMarker): void {
    Row() {
      Column() {
        Text(marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Text(marker.distance)
          .fontSize(13)
          .fontColor(AppColors.secondary);
      }
      .alignItems(HorizontalAlign.Start);
      Blank();
      Button('View')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(6);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(10)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
    .alignItems(VerticalAlign.Center);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.lg }) {
        TextInput({ text: this.query, placeholder: 'Search destination' })
          .fontSize(13)
          .fontColor(AppColors.onSurface)
          .placeholderColor(AppColors.onSurface)
          .caretColor(AppColors.primary)
          .backgroundColor(AppColors.surface)
          .border({ width: 1, color: AppColors.outline })
          .borderRadius(10)
          .width('100%')
          .height(48)
          .onChange((value: string) => {
            this.query = value;
          });
        Column({ space: AppSpacing.md }) {
          ForEach(this.markers, (marker: MapMarker) => {
            this.MarkerCard(marker);
          }, (marker: MapMarker) => marker.name)
        }
        .width('100%');
        Blank().height(AppSpacing.xxl);
        Button('Refresh Map')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(14)
          .width('100%')
          .height(48);
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
