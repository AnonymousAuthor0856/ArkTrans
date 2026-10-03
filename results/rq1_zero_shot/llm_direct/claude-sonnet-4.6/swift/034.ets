import { router } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#FF00FF66';
  static readonly secondary: string = '#FFCCCCCC';
  static readonly tertiary: string = '#FF999999';
  static readonly background: string = '#FF000000';
  static readonly surface: string = '#FF0A0A0A';
  static readonly surfaceVariant: string = '#FF111111';
  static readonly outline: string = '#FF1F1F1F';
  static readonly success: string = '#FF16A34A';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFFF4444';
  static readonly onPrimary: string = '#FF000000';
  static readonly onSecondary: string = '#FFFFFFFF';
  static readonly onTertiary: string = '#FFFFFFFF';
  static readonly onBackground: string = '#FFE0E0E0';
  static readonly onSurface: string = '#FFE0E0E0';
}

class AppTypography {
  static readonly display: number = 28;
  static readonly headline: number = 20;
  static readonly title: number = 16;
  static readonly body: number = 13;
  static readonly label: number = 11;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

// MARK: - Data Model
class MapMarker {
  id: string;
  name: string;
  distance: string;

  constructor(id: string, name: string, distance: string) {
    this.id = id;
    this.name = name;
    this.distance = distance;
  }
}

// MARK: - CardView Component
@Component
struct CardView {
  marker: MapMarker = new MapMarker('', '', '');

  build() {
    Row() {
      Column() {
        Text(this.marker.name)
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ bottom: 0 })

        Text(this.marker.distance)
          .fontSize(AppTypography.body)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('View')
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.small)
        .padding({
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.xs,
          bottom: AppSpacing.xs
        })
        .height('auto')
        .onClick(() => {
          console.log(`View ${this.marker.name} Tapped`);
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State private query: string = '';
  @State private isSearchFieldFocused: boolean = false;

  private markers: MapMarker[] = [
    new MapMarker('1', 'Central Plaza', '1.2 km'),
    new MapMarker('2', 'Museum District', '3.4 km'),
    new MapMarker('3', 'Tech Park', '5.6 km'),
    new MapMarker('4', 'Old Town Gate', '7.8 km')
  ];

  build() {
    Column() {
      // Top Bar
      Text('Explore Map')
        .fontSize(AppTypography.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({
          top: AppSpacing.lg,
          bottom: AppSpacing.lg
        })
        .backgroundColor(AppColors.background)

      // Main Content
      Column() {
        // Search Field
        TextInput({ placeholder: 'Search destination', text: this.query })
          .fontSize(AppTypography.body)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
          .placeholderColor(AppColors.tertiary)
          .caretColor(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.medium)
          .border({
            width: 1,
            color: this.isSearchFieldFocused ? AppColors.primary : AppColors.outline,
            style: BorderStyle.Solid
          })
          .padding(AppSpacing.md)
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
        Column() {
          ForEach(this.markers, (marker: MapMarker) => {
            CardView({ marker: marker })
          }, (marker: MapMarker) => marker.id)
        }
        .width('100%')
        .margin({ top: AppSpacing.lg })

        Blank()
          .layoutWeight(1)

        // Refresh Map Button
        Button('Refresh Map')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .width('100%')
          .height(48)
          .margin({ top: AppSpacing.lg })
          .onClick(() => {
            console.log('Refresh Map Tapped');
          })
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}