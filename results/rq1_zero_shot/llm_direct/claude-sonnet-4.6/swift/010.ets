import { router } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#FF1976D2';
  static readonly secondary: string = '#FF607D8B';
  static readonly tertiary: string = '#FF757575';
  static readonly background: string = '#FFECEFF1';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFCFD8DC';
  static readonly outline: string = '#FFB0BEC5';
  static readonly success: string = '#FF4CAF50';
  static readonly warning: string = '#FFFFC107';
  static readonly error: string = '#FFF44336';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FFFFFFFF';
  static readonly onTertiary: string = '#FFFFFFFF';
  static readonly onBackground: string = '#FF263238';
  static readonly onSurface: string = '#FF263238';
}

class AppTypography {
  static readonly displaySize: number = 36;
  static readonly headlineSize: number = 24;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

const TOP_BAR_HEIGHT: number = 64;

// MARK: - Data Models
class StoryLayer {
  id: number;
  type: string;
  content: string;

  constructor(id: number, type: string, content: string) {
    this.id = id;
    this.type = type;
    this.content = content;
  }
}

// MARK: - Layer Item Component
@Component
struct LayerItemView {
  layer: StoryLayer = new StoryLayer(0, '', '');
  isSelected: boolean = false;
  onSelect: () => void = () => {};

  build() {
    Column({ space: AppSpacing.sm }) {
      // Icon area - Circle
      Circle()
        .width(32)
        .height(32)
        .fill(this.isSelected ? '#33FFFFFF' : AppColors.surfaceVariant)

      // Type label
      Text(this.layer.type)
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppColors.onPrimary : '#B3263238')

      // Content text
      Text(this.layer.content)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .padding({
      left: AppSpacing.xxl,
      right: AppSpacing.xxl,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .width(130)
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isSelected ? AppColors.primary : AppColors.outline,
      radius: 8
    })
    .onClick(() => {
      this.onSelect();
    })
  }
}

// MARK: - Root Screen
@Entry
@Component
struct RootScreen {
  @State textOpacity: number = 1.0;
  @State uploadProgress: number = 0.65;
  @State layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ];
  @State selectedLayer: number = 3;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main content area
      Column() {
        // Top Bar
        Row() {
          // Left button - Exit
          Button({ type: ButtonType.Normal }) {
            Text('Exit')
              .fontSize(AppTypography.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onBackground)
          }
          .backgroundColor(Color.Transparent)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm })

          Blank()

          // Center title
          Text('Story Editor')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Blank()

          // Right button - Post
          Button({ type: ButtonType.Normal }) {
            Text('Post')
              .fontSize(AppTypography.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onPrimary)
              .padding({
                left: AppSpacing.md,
                right: AppSpacing.md,
                top: AppSpacing.sm,
                bottom: AppSpacing.sm
              })
          }
          .backgroundColor(AppColors.primary)
          .borderRadius(8)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
        }
        .height(TOP_BAR_HEIGHT)
        .width('100%')
        .backgroundColor(AppColors.surface)

        // Main scrollable content
        Scroll() {
          Column({ space: AppSpacing.lg }) {
            // Preview Card
            Stack() {
              Column()
                .width('100%')
                .height('100%')
                .backgroundColor(AppColors.tertiary)
                .borderRadius(12)
                .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })

              Text('Your Story Preview')
                .fontSize(AppTypography.headlineSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onTertiary)
                .opacity(this.textOpacity)
                .textAlign(TextAlign.Center)
            }
            .height(200)
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            // Upload Status
            Column({ space: AppSpacing.sm }) {
              Text('Upload Status')
                .fontSize(AppTypography.labelSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.secondary)
                .width('100%')

              // Custom Progress Bar
              Stack({ alignContent: Alignment.Start }) {
                // Track background
                Row()
                  .width('100%')
                  .height(AppSpacing.sm)
                  .backgroundColor(AppColors.surfaceVariant)
                  .borderRadius(4)

                // Progress fill
                Row()
                  .width(`${this.uploadProgress * 100}%`)
                  .height(AppSpacing.sm)
                  .backgroundColor(AppColors.success)
                  .borderRadius(4)
              }
              .width('100%')
              .height(AppSpacing.sm)
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            // Layer List
            Column({ space: AppSpacing.sm }) {
              Text('Story Layers')
                .fontSize(AppTypography.labelSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.secondary)
                .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
                .width('100%')

              Scroll() {
                Row({ space: AppSpacing.lg }) {
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
                .padding({
                  left: AppSpacing.lg,
                  right: AppSpacing.lg,
                  top: AppSpacing.md,
                  bottom: AppSpacing.md
                })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
          }
          .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
          .width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .backgroundColor(AppColors.background)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      Column({ space: AppSpacing.md }) {
        Text('Layer Properties')
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .width('100%')

        Row() {
          Text('Opacity')
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
            .width(80)
            .textAlign(TextAlign.Start)

          Slider({
            value: this.textOpacity * 100,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet
          })
            .trackColor(AppColors.surfaceVariant)
            .selectedColor(AppColors.primary)
            .layoutWeight(1)
            .onChange((value: number) => {
              this.textOpacity = value / 100;
            })
        }
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppSpacing.lg)
      .width('100%')
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}