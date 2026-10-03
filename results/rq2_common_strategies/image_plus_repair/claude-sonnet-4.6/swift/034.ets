// AppTokens
class AppColors {
  static primary: string = '#00FF66';
  static secondary: string = '#CCCCCC';
  static tertiary: string = '#999999';
  static background: string = '#000000';
  static surface: string = '#0A0A0A';
  static surfaceVariant: string = '#111111';
  static outline: string = '#1F1F1F';
  static success: string = '#16A34A';
  static warning: string = '#F59E0B';
  static error: string = '#FF4444';
  static onPrimary: string = '#000000';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#FFFFFF';
  static onBackground: string = '#E0E0E0';
  static onSurface: string = '#E0E0E0';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;
}

class AppShapes {
  static small: number = 6;
  static medium: number = 10;
  static large: number = 14;
}

interface MapMarker {
  id: number;
  name: string;
  distance: string;
}

const markers: MapMarker[] = [
  { id: 1, name: 'Central Plaza', distance: '1.2 km' },
  { id: 2, name: 'Museum District', distance: '3.4 km' },
  { id: 3, name: 'Tech Park', distance: '5.6 km' },
  { id: 4, name: 'Old Town Gate', distance: '7.8 km' },
];

@Component
struct CardView {
  marker: MapMarker = { id: 0, name: '', distance: '' };

  build() {
    Row() {
      Column() {
        Text(this.marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ bottom: 2 })
        Text(this.marker.distance)
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('View')
        .fontSize(11)
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
        .height(32)
        .onClick(() => {
          console.log('View ' + this.marker.name + ' Tapped');
        })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .alignItems(VerticalAlign.Center)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State isSearchFocused: boolean = false;

  build() {
    Column() {
      // Top Bar
      Text('Explore Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({
          top: AppSpacing.lg,
          bottom: AppSpacing.lg
        })
        .backgroundColor(AppColors.background)

      // Main content
      Column() {
        // Search Field
        TextInput({ placeholder: 'Search destination', text: this.query })
          .fontSize(13)
          .fontColor(AppColors.onSurface)
          .placeholderColor(AppColors.tertiary)
          .placeholderFont({ size: 13, weight: FontWeight.Normal })
          .caretColor(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.medium)
          .border({
            width: 1,
            color: this.isSearchFocused ? AppColors.primary : AppColors.outline,
            radius: AppShapes.medium
          })
          .padding({
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.md,
            bottom: AppSpacing.md
          })
          .width('100%')
          .height(50)
          .onChange((value: string) => {
            this.query = value;
          })
          .onFocus(() => {
            this.isSearchFocused = true;
          })
          .onBlur(() => {
            this.isSearchFocused = false;
          })

        // Markers List
        Column({ space: AppSpacing.md }) {
          ForEach(markers, (marker: MapMarker) => {
            CardView({ marker: marker })
          }, (marker: MapMarker) => marker.id.toString())
        }
        .width('100%')
        .margin({ top: AppSpacing.lg })

        // Spacer
        Blank()
          .layoutWeight(1)

        // Refresh Map Button
        Button('Refresh Map')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .width('100%')
          .height(48)
          .onClick(() => {
            console.log('Refresh Map Tapped');
          })
          .margin({ bottom: AppSpacing.lg })
      }
      .padding(AppSpacing.lg)
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}