import { router } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static primary: string = '#FF1976D2';
  static secondary: string = '#FF607D8B';
  static tertiary: string = '#FF757575';
  static background: string = '#FFECEFF1';
  static surface: string = '#FFFFFFFF';
  static surfaceVariant: string = '#FFCFD8DC';
  static outline: string = '#FFB0BEC5';
  static success: string = '#FF4CAF50';
  static warning: string = '#FFFFC107';
  static error: string = '#FFF44336';
  static onPrimary: string = '#FFFFFFFF';
  static onSecondary: string = '#FFFFFFFF';
  static onTertiary: string = '#FFFFFFFF';
  static onBackground: string = '#FF263238';
  static onSurface: string = '#FF263238';
}

class AppSpacing {
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;
}

const topBarHeight: number = 64;

// MARK: - Data Models
interface StoryLayer {
  id: number;
  type: string;
  content: string;
}

// MARK: - Layer Item Component
@Component
struct LayerItemView {
  layer: StoryLayer = { id: 0, type: '', content: '' };
  isSelected: boolean = false;
  onSelect: () => void = () => {};

  build() {
    Column({ space: AppSpacing.sm }) {
      Circle()
        .width(32)
        .height(32)
        .fill(this.isSelected ? '#33FFFFFF' : AppColors.surfaceVariant)

      Text(this.layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppColors.onPrimary : '#B3263238')

      Text(this.layer.content)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .padding({ left: AppSpacing.xxl, right: AppSpacing.xxl, top: AppSpacing.md, bottom: AppSpacing.md })
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
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
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
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onBackground)
          }
          .backgroundColor(Color.Transparent)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm })

          Blank()

          // Center title
          Text('Story Editor')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Blank()

          // Right button - Post
          Button({ type: ButtonType.Normal }) {
            Text('Post')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onPrimary)
              .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
          }
          .backgroundColor(AppColors.primary)
          .borderRadius(8)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
        }
        .width('100%')
        .height(topBarHeight)
        .backgroundColor(AppColors.surface)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm })

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

              Text('Your Story Preview')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(`rgba(255,255,255,${this.textOpacity})`)
                .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height(200)
            .borderRadius(12)
            .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            // Upload Status
            Column({ space: AppSpacing.sm }) {
              Text('Upload Status')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.secondary)
                .width('100%')
                .textAlign(TextAlign.Start)

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
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            // Story Layers
            Column({ space: AppSpacing.sm }) {
              Text('Story Layers')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.secondary)
                .width('100%')
                .textAlign(TextAlign.Start)
                .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

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
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ top: AppSpacing.lg, bottom: 120 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppColors.background)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar - Layer Properties
      Column({ space: AppSpacing.md }) {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .width('100%')
          .textAlign(TextAlign.Start)

        Row() {
          Text('Opacity')
            .fontSize(14)
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
            .layoutWeight(1)
            .selectedColor(AppColors.primary)
            .trackColor(AppColors.surfaceVariant)
            .onChange((value: number) => {
              this.textOpacity = value / 100;
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}