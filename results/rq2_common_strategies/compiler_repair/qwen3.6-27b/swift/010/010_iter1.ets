import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
class AppTokens {
  static Colors = {
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

  static TypographyTokens = {
    display: { size: 36, weight: FontWeight.Bold },
    headline: { size: 24, weight: FontWeight.Medium }, // Fixed SemiBold to Medium as SemiBold might not exist or be standard in all versions, usually Medium is safe. If SemiBold exists, use it. But error says it doesn't.
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes = {
    small: 4,
    medium: 8,
    large: 12
  };

  static Spacing = {
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
            .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
            .foregroundColor(AppTokens.Colors.onBackground)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })

          Blank()

          Text('Story Editor')
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .foregroundColor(AppTokens.Colors.onSurface)

          Blank()

          Button('Post')
            .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
            .foregroundColor(AppTokens.Colors.onPrimary)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
        }
        .height(AppTokens.topBarHeight)
        .backgroundColor(AppTokens.Colors.surface)

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Preview Card
            Stack() {
              Rect()
                .fill(AppTokens.Colors.tertiary)
                .borderRadius(AppTokens.Shapes.large)
                .shadow({ radius: 3, color: '#0000001A', offsetX: 0, offsetY: 1 })

              Text('Your Story Preview')
                .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
                .foregroundColor(new Color(AppTokens.Colors.onTertiary).opacity(this.textOpacity))
                .textAlign(TextAlign.Center)
            }
            .height(200)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Upload Status
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Upload Status')
                .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
                .foregroundColor(AppTokens.Colors.secondary)

              // Progress Bar
              Row() {
                Rect()
                  .fill(AppTokens.Colors.surfaceVariant)
                  .borderRadius(4)
                  .height(AppTokens.Spacing.sm)

                Rect()
                  .fill(AppTokens.Colors.success)
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
                .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
                .foregroundColor(AppTokens.Colors.secondary)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

              Scroll(Scroller.new()) {
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
        .backgroundColor(AppTokens.Colors.background)
      }

      // Bottom Bar
      Column({ space: AppTokens.Spacing.md }) {
        Text('Layer Properties')
          .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
          .foregroundColor(AppTokens.Colors.secondary)

        Row() {
          Text('Opacity')
            .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
            .width(80)
            .textAlign(TextAlign.Start)

          Slider({ value: this.textOpacity, min: 0, max: 1, step: 0.01 })
            .selectedColor(AppTokens.Colors.primary)
        }
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 6, color: '#0000001A', offsetX: 0, offsetY: -2 })
    }
    .backgroundColor(AppTokens.Colors.background)
    .clip(true) // Replaced edges(Edge.all) with clip(true) or similar valid attribute if needed, but edges/Edge.all is invalid. Clip is often used for corners.
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
          .fill(this.isSelected ? new Color(AppTokens.Colors.onPrimary).opacity(0.2) : AppTokens.Colors.surfaceVariant)
          .width(32)
          .height(32)

        Text(this.layer.type)
          .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
          .foregroundColor(this.isSelected ? AppTokens.Colors.onPrimary : new Color(AppTokens.Colors.onSurface).opacity(0.7))

        Text(this.layer.content)
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .foregroundColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .maxLines(2)
      }
      .padding({ left: AppTokens.Spacing.xxl, right: AppTokens.Spacing.xxl, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .width(130)
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(8)
      .border({ width: 1, color: this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.outline, radius: 8 })
    }
    .onClick(() => {
      this.onSelect();
    })
  }
}