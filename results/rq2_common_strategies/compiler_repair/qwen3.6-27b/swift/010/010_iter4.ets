import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
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

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

class AppTokens {
  static Colors: ColorTokens = {
    primary: '#FF1976D2',
    secondary: '#FF607D8B',
    tertiary: '#FF757575',
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
  };

  static TypographyTokens: TypographyTokens = {
    display: { size: 36, weight: FontWeight.Bold },
    headline: { size: 24, weight: FontWeight.Medium },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: ShapeTokens = {
    small: 4,
    medium: 8,
    large: 12
  };

  static Spacing: SpacingTokens = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static topBarHeight: number = 64;
}

// MARK: - Data Models
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
  @State layers: StoryLayer[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
  ];
  @State selectedLayer: number = 3;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main Content Area
      Column() {
        // Top Bar
        Row() {
          Button('Exit')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .foregroundColor(Color.AppTokens.Colors.onBackground as Color)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })

          Blank()

          Text('Story Editor')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .foregroundColor(Color.AppTokens.Colors.onSurface as Color)

          Blank()

          Button('Post')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .foregroundColor(Color.AppTokens.Colors.onPrimary as Color)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .backgroundColor(Color.AppTokens.Colors.primary as Color)
            .borderRadius(AppTokens.Shapes.medium)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
        }
        .height(AppTokens.topBarHeight)
        .backgroundColor(Color.AppTokens.Colors.surface as Color)

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Preview Card
            Stack() {
              Rect()
                .fill(Color.AppTokens.Colors.tertiary as Color)
                .borderRadius(AppTokens.Shapes.large)
                .shadow({ radius: 3, color: '#0000001A', offsetX: 0, offsetY: 1 })

              Text('Your Story Preview')
                .fontSize(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .foregroundColor(Color.AppTokens.Colors.onTertiary as Color)
                .opacity(this.textOpacity)
                .textAlign(TextAlign.Center)
            }
            .height(200)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Upload Status
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Upload Status')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .foregroundColor(Color.AppTokens.Colors.secondary as Color)

              // Progress Bar
              Row() {
                Rect()
                  .fill(Color.AppTokens.Colors.surfaceVariant as Color)
                  .borderRadius(4)
                  .height(AppTokens.Spacing.sm)

                Rect()
                  .fill(Color.AppTokens.Colors.success as Color)
                  .borderRadius(4)
                  .width(`${this.uploadProgress * 100}%`)
                  .height(AppTokens.Spacing.sm)
              }
              .height(AppTokens.Spacing.sm)
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Layer List
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Story Layers')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .foregroundColor(Color.AppTokens.Colors.secondary as Color)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

              Scroll() {
                Row({ space: AppTokens.Spacing.lg }) {
                  ForEach(this.layers, (layer: StoryLayer) => {
                    LayerItemView({
                      layer: layer,
                      isSelected: layer.id === this.selectedLayer,
                      onSelect: () => {
                        this.selectedLayer = layer.id;
                      }
                    })
                  }, (layer: StoryLayer) => layer.id.toString())
                }
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
              }
              .scrollBar(BarState.Off)
            }
          }
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        }
        .backgroundColor(Color.AppTokens.Colors.background as Color)
      }

      // Bottom Bar
      Column({ space: AppTokens.Spacing.md }) {
        Text('Layer Properties')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .foregroundColor(Color.AppTokens.Colors.secondary as Color)

        Row() {
          Text('Opacity')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .width(80)
            .textAlign(TextAlign.Start)

          Slider({ value: this.textOpacity, min: 0, max: 1, step: 0.01 })
            .selectedColor(Color.AppTokens.Colors.primary as Color)
        }
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .backgroundColor(Color.AppTokens.Colors.surface as Color)
      .shadow({ radius: 6, color: '#0000001A', offsetX: 0, offsetY: -2 })
    }
    .backgroundColor(Color.AppTokens.Colors.background as Color)
    .clip(true)
  }
}

@Component
struct LayerItemView {
  @Prop layer: StoryLayer;
  @Prop isSelected: boolean;
  @Prop onSelect: () => void;

  build() {
    Button() {
      Column({ space: AppTokens.Spacing.sm }) {
        Circle()
          .fill(this.isSelected ? Color.AppTokens.Colors.onPrimary as Color : Color.AppTokens.Colors.surfaceVariant as Color)
          .opacity(this.isSelected ? 0.2 : 1)
          .width(32)
          .height(32)

        Text(this.layer.type)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .foregroundColor(this.isSelected ? Color.AppTokens.Colors.onPrimary as Color : Color.AppTokens.Colors.onSurface as Color)
          .opacity(this.isSelected ? 1 : 0.7)

        Text(this.layer.content)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .foregroundColor(this.isSelected ? Color.AppTokens.Colors.onPrimary as Color : Color.AppTokens.Colors.onSurface as Color)
          .textAlign(TextAlign.Center)
          .maxLines(2)
      }
      .padding({ left: AppTokens.Spacing.xxl, right: AppTokens.Spacing.xxl, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .width(130)
      .backgroundColor(this.isSelected ? Color.AppTokens.Colors.primary as Color : Color.AppTokens.Colors.surface as Color)
      .borderRadius(8)
      .border({ width: 1, color: this.isSelected ? Color.AppTokens.Colors.primary as Color : Color.AppTokens.Colors.outline as Color, radius: 8 })
    }
    .onClick(() => {
      this.onSelect();
    })
  }
}