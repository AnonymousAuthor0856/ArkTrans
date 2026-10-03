// entry/src/main/ets/viewmodel/AppTokens.ts
export class AppTokens {
  static readonly Colors = {
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
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16
  }

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 12
  }
}

// entry/src/main/ets/model/StoryLayer.ts
export interface StoryLayer {
  id: number;
  type: string;
  content: string;
}

// entry/src/main/ets/pages/Index.ets
import { AppTokens } from '../viewmodel/AppTokens';
import { StoryLayer } from '../model/StoryLayer';

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

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Exit')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onBackground)
          .onClick(() => {
            // Exit action
          })

        Blank().layoutWeight(1)

        Text('Story Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onBackground)

        Blank().layoutWeight(1)

        Button('Post')
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(40)
          .width(80)
          .onClick(() => {
            // Post action
          })
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)

      // Main Content Area
      Scroll() {
        Column() {
          // Story Preview Card
          Column() {
            Text('Your Story Preview')
              .fontSize(24)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(Color.White)
              .opacity(this.textOpacity)
              .textAlign(TextAlign.Center)
          }
          .width('90%')
          .height(300)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

          // Upload Status
          Column() {
            Text('Upload Status')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.secondary)
              .margin({ bottom: AppTokens.Spacing.sm })

            Progress({ value: this.uploadProgress * 100, total: 100, type: ProgressType.Linear })
              .width('100%')
              .height(8)
              .color(AppTokens.Colors.success)
              .trackColor(AppTokens.Colors.surfaceVariant)
              .control(false)
          }
          .width('90%')
          .margin({ bottom: AppTokens.Spacing.lg })

          // Layer Selection (LazyRow equivalent)
          Row() {
            ForEach(this.layers, (layer: StoryLayer) => {
              Column() {
                Circle()
                  .width(32)
                  .height(32)
                  .fill(layer.id === this.selectedLayerId ? Color.Transparent : AppTokens.Colors.surfaceVariant)
                  .margin({ bottom: AppTokens.Spacing.sm })

                Text(layer.type)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(layer.id === this.selectedLayerId ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  .margin({ bottom: AppTokens.Spacing.sm })

                Text(layer.content)
                  .fontSize(14)
                  .fontColor(layer.id === this.selectedLayerId ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              }
              .width(100)
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .backgroundColor(layer.id === this.selectedLayerId ? AppTokens.Colors.primary : AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.medium)
              .border({ width: 1, color: layer.id === this.selectedLayerId ? AppTokens.Colors.primary : AppTokens.Colors.outline })
              .onClick(() => {
                this.selectedLayerId = layer.id;
              })
              .margin({ right: AppTokens.Spacing.md })
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .margin({ bottom: AppTokens.Spacing.lg })
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.sm })
      }
      .layoutWeight(1)

      // Bottom Bar - Layer Properties
      Column() {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ bottom: AppTokens.Spacing.md })

        Row() {
          Text('Opacity')
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface)
            .width(80)

          Slider({
            value: this.textOpacity * 100,
            min: 0,
            max: 100,
            step: 1
          })
            .layoutWeight(1)
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .onChange((value: number) => {
              this.textOpacity = value / 100;
            })
        }
        .width('100%')
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}