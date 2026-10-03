import { window } from '@kit.ArkUI';

// --- Design Tokens & Constants ---

interface AppColors {
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

interface AppSpacing {
  sm: number;
  md: number;
  lg: number;
}

interface AppElevation {
  level1: number;
  level2: number;
}

const AppTokens = {
  Colors: {
    primary: '#1976D2',
    secondary: '#607D8B',
    tertiary: '#757575',
    background: '#ECEFF1',
    surface: '#FFFFFF',
    surfaceVariant: '#CFD8DC',
    outline: '#B0BEC5',
    success: '#4CAF50',
    warning: '#FFC107',
    error: '#F44336',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#263238',
    onSurface: '#263238'
  } as AppColors,
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16
  } as AppSpacing,
  Elevation: {
    level1: 1, // vp
    level2: 3  // vp
  } as AppElevation
};

interface StoryLayer {
  id: number;
  type: string;
  content: string;
}

@Entry
@Component
struct RootScreen {
  @State textOpacity: number = 1.0;
  @State uploadProgress: number = 0.65;
  @State selectedLayerId: number = 3; // Default to "Hello World" layer

  private layers: StoryLayer[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
  ];

  aboutToAppear() {
    // Hide system bars for immersive experience similar to Android code
    let windowClass: window.Window | undefined = undefined;
    window.getLastWindow(getContext(this), (err, data) => {
      if (err.code) {
        console.error('Failed to get window: ' + err.message);
        return;
      }
      windowClass = data;
      if (windowClass) {
        windowClass.setWindowSystemBarEnable([]);
      }
    });
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Button('Exit')
          .backgroundColor(Color.Transparent)
          .fontColor(AppTokens.Colors.onBackground)
          .borderWidth(0)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .onClick(() => {
            // Exit logic
          })

        Text('Story Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.1)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Post')
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Spacing.md)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .onClick(() => {
            // Post logic
          })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)

      // Main Content Area
      Column() {
        // Preview Card
        Column() {
          Text('Your Story Preview')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(0)
            .textAlign(TextAlign.Center)
            .fontColor(new Color(AppTokens.Colors.onTertiary))
            .opacity(this.textOpacity)
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.tertiary)
        .borderRadius(AppTokens.Spacing.lg)
        .shadow({ radius: 6, color: '#0000001A', offsetY: 2 }) // Simulating elevation
        .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

        // Upload Status
        Column() {
          Text('Upload Status')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.5)
            .fontColor(AppTokens.Colors.secondary)
          
          Progress({ value: this.uploadProgress, total: 1 })
            .width('100%')
            .height(AppTokens.Spacing.sm)
            .progressType(ProgressType.Linear)
            .color(AppTokens.Colors.success)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .margin({ top: AppTokens.Spacing.md })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        // Layer List (LazyRow equivalent using Flex)
        Flex({ direction: FlexDirection.Row, wrap: FlexWrap.NoWrap }) {
          ForEach(this.layers, (layer: StoryLayer) => {
            Column() {
              // Icon Placeholder
              Row()
                .width(32)
                .height(32)
                .borderRadius(16)
                .backgroundColor(this.selectedLayerId === layer.id 
                  ? new Color(AppTokens.Colors.onPrimary).withAlpha(0.2) 
                  : AppTokens.Colors.surfaceVariant)
              
              Text(layer.type)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .letterSpacing(0.5)
                .fontColor(this.selectedLayerId === layer.id 
                  ? AppTokens.Colors.onPrimary 
                  : new Color(AppTokens.Colors.onSurface).withAlpha(0.7))
                .margin({ top: AppTokens.Spacing.sm })

              Text(layer.content)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .letterSpacing(0.25)
                .fontColor(this.selectedLayerId === layer.id 
                  ? AppTokens.Colors.onPrimary 
                  : AppTokens.Colors.onSurface)
            }
            .width(100)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .backgroundColor(this.selectedLayerId === layer.id ? AppTokens.Colors.primary : AppTokens.Colors.surface)
            .borderRadius(AppTokens.Spacing.md)
            .border({ width: 1, color: this.selectedLayerId === layer.id ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .onClick(() => {
              this.selectedLayerId = layer.id;
            })
            .margin({ right: AppTokens.Spacing.md })
          })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .justifyContent(FlexAlign.Start)

      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

      // Bottom Bar
      Column() {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor(AppTokens.Colors.secondary)
        
        Row() {
          Text('Opacity')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .letterSpacing(0.25)
            .width(80)
          
          Slider({ value: this.textOpacity, min: 0, max: 1, step: 0.01 })
            .width('100%')
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .onChange((value: number) => {
              this.textOpacity = value;
            })
        }
        .width('100%')
        .margin({ top: AppTokens.Spacing.md })
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 6, color: '#0000001A', offsetY: -2 }) // Upward shadow for bottom bar
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}