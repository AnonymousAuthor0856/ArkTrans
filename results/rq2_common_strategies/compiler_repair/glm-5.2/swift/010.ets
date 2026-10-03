// Data Models
interface StoryLayer {
  id: number;
  type: string;
  content: string;
}

interface ColorsType {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onTertiary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

interface TypographyTokensType {
  display: FontInfo;
  headline: FontInfo;
  title: FontInfo;
  body: FontInfo;
  label: FontInfo;
}

interface FontInfo {
  size: number;
  weight: FontWeight;
}

interface ShapesType {
  small: number;
  medium: number;
  large: number;
}

interface SpacingType {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

class AppTokens {
  static readonly Colors: ColorsType = {
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
  };

  static readonly TypographyTokens: TypographyTokensType = {
    display: { size: 36, weight: FontWeight.Bold },
    headline: { size: 24, weight: FontWeight.Medium },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes: ShapesType = {
    small: 4,
    medium: 8,
    large: 12
  };

  static readonly Spacing: SpacingType = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static readonly topBarHeight: number = 64;
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
        // Top App Bar
        Row() {
          // Exit Button
          Button('Exit')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .backgroundColor(Color.Transparent)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })

          Blank()

          // Title
          Text('Story Editor')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          // Post Button
          Button('Post')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        }
        .width('100%')
        .height(AppTokens.topBarHeight)
        .backgroundColor(AppTokens.Colors.surface)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Preview Card
            Stack() {
              Text('Your Story Preview')
                .fontSize(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .fontColor(AppTokens.Colors.onTertiary)
                .opacity(this.textOpacity)
                .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height(200)
            .borderRadius(AppTokens.Shapes.large)
            .backgroundColor(AppTokens.Colors.tertiary)
            .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 1 })
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Upload Status
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Upload Status')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.secondary)

              // Custom Progress Bar
              Stack({ alignContent: Alignment.Start }) {
                // Track Background
                Column()
                  .width('100%')
                  .height(AppTokens.Spacing.sm)
                  .borderRadius(4)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)

                // Progress Fill
                Column()
                  .width(`${this.uploadProgress * 100}%`)
                  .height(AppTokens.Spacing.sm)
                  .borderRadius(4)
                  .backgroundColor(AppTokens.Colors.success)
              }
              .width('100%')
              .height(AppTokens.Spacing.sm)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Story Layers
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Story Layers')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.secondary)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

              // Horizontal Scroll for Layers
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
                  })
                }
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        }
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
      }

      // Bottom Bar
      Column({ space: AppTokens.Spacing.md }) {
        Text('Layer Properties')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.secondary)

        Row() {
          Text('Opacity')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .width(80)
            .textAlign(TextAlign.Start)

          Slider({
            value: this.textOpacity,
            min: 0,
            max: 1
          })
            .onChange((value: number, mode: SliderChangeMode) => {
              this.textOpacity = value;
            })
            .layoutWeight(1)
            .selectedColor(AppTokens.Colors.primary)
        }
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 6, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct LayerItemView {
  @Prop layer: StoryLayer;
  @Prop isSelected: boolean;
  onSelect: () => void = () => {};

  build() {
    Button({ type: ButtonType.Normal }) {
      Column({ space: AppTokens.Spacing.sm }) {
        // Icon Area
        Circle()
          .width(32)
          .height(32)
          .fill(this.isSelected ? 'rgba(255,255,255,0.2)' : AppTokens.Colors.surfaceVariant)

        // Type Label
        Text(this.layer.type)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .opacity(this.isSelected ? 1 : 0.7)

        // Content Text
        Text(this.layer.content)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .width(130)
      .padding({ left: AppTokens.Spacing.xxl, right: AppTokens.Spacing.xxl, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .borderRadius(8)
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .border({
        width: 1,
        color: this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.outline
      })
    }
    .onClick(this.onSelect)
  }
}