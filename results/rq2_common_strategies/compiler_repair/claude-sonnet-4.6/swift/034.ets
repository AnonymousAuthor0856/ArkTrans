// AppColors interface and const
interface ColorTokens {
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

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

const AppColors: ColorTokens = {
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
  onSurface: '#E0E0E0',
};

const AppSpacing: SpacingTokens = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
};

const AppShapes: ShapeTokens = {
  small: 6,
  medium: 10,
  large: 14,
};

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
        .height(28)
        .onClick(() => {
          console.log(`View ${this.marker.name} Tapped`);
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
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

      // Main Content
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
          .height(48)
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

        Blank()

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
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}