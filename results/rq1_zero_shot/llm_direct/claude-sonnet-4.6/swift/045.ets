import { router } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#FF8E6BF2';
  static readonly secondary: string = '#FFD3C1FF';
  static readonly tertiary: string = '#FFB39DDB';
  static readonly background: string = '#FFF5F3FF';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFECE6F8';
  static readonly outline: string = '#FFD1C4E9';
  static readonly success: string = '#FF4CAF50';
  static readonly warning: string = '#FFFFB300';
  static readonly error: string = '#FFE53935';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FF2E1A47';
  static readonly onBackground: string = '#FF2E1A47';
  static readonly onSurface: string = '#FF2E1A47';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 14;
  static readonly large: number = 20;
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(4.0, 8.0, 2.0, 0.18);
  static readonly level2: ShadowSpec = new ShadowSpec(8.0, 12.0, 4.0, 0.22);
  static readonly level3: ShadowSpec = new ShadowSpec(12.0, 20.0, 8.0, 0.26);
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State private orderId: string = '';
  @State private issue: string = '';
  @State private submitted: boolean = false;
  @State private orderIdIsFocused: boolean = false;
  @State private issueIsFocused: boolean = false;

  build() {
    Stack() {
      // Background
      Column() {}
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // Main Content
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          // Title
          Text('After-Sale Service')
            .fontSize(AppTypography.displaySize)
            .fontWeight(AppTypography.displayWeight)
            .fontColor(AppColors.onBackground)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Card Area
          Column({ space: AppSpacing.md }) {
            Text('Order ID')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(AppColors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            // Order ID Input
            Stack({ alignContent: Alignment.TopStart }) {
              if (this.orderId === '' && !this.orderIdIsFocused) {
                Text('Enter order number')
                  .fontSize(AppTypography.bodySize)
                  .fontWeight(AppTypography.bodyWeight)
                  .fontColor(AppColors.onSurface + '80')
                  .padding({
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                    top: (56 - AppTypography.bodySize) / 2,
                    bottom: (56 - AppTypography.bodySize) / 2
                  })
              }
              TextInput({ text: this.orderId, placeholder: '' })
                .fontSize(AppTypography.bodySize)
                .fontWeight(AppTypography.bodyWeight)
                .fontColor(AppColors.onSurface)
                .padding({ left: AppSpacing.md, right: AppSpacing.md })
                .height(56)
                .width('100%')
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.medium)
                .borderWidth(1)
                .borderColor(this.orderIdIsFocused ? AppColors.primary : AppColors.outline)
                .caretColor(AppColors.primary)
                .onChange((value: string) => {
                  this.orderId = value;
                })
                .onFocus(() => {
                  this.orderIdIsFocused = true;
                })
                .onBlur(() => {
                  this.orderIdIsFocused = false;
                })
            }
            .width('100%')
            .height(56)

            Text('Issue Description')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(AppColors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            // Issue Description Input
            Stack({ alignContent: Alignment.TopStart }) {
              if (this.issue === '' && !this.issueIsFocused) {
                Text('Describe your issue')
                  .fontSize(AppTypography.bodySize)
                  .fontWeight(AppTypography.bodyWeight)
                  .fontColor(AppColors.onSurface + '80')
                  .padding({
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                    top: AppSpacing.sm + 4,
                    bottom: AppSpacing.sm + 4
                  })
              }
              TextArea({ text: this.issue, placeholder: '' })
                .fontSize(AppTypography.bodySize)
                .fontWeight(AppTypography.bodyWeight)
                .fontColor(AppColors.onSurface)
                .padding({
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  top: AppSpacing.sm + 4,
                  bottom: AppSpacing.sm + 4
                })
                .height(120)
                .width('100%')
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.medium)
                .borderWidth(1)
                .borderColor(this.issueIsFocused ? AppColors.primary : AppColors.outline)
                .caretColor(AppColors.primary)
                .onChange((value: string) => {
                  this.issue = value;
                })
                .onFocus(() => {
                  this.issueIsFocused = true;
                })
                .onBlur(() => {
                  this.issueIsFocused = false;
                })
            }
            .width('100%')
            .height(120)
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: ElevationMapping.level2.radius,
            color: AppColors.outline + '38',
            offsetX: 0,
            offsetY: ElevationMapping.level2.dy
          })
          .alignItems(HorizontalAlign.Start)

          // Submit Button
          Button() {
            Text('Submit Request')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(AppColors.onPrimary)
          }
          .width('100%')
          .height(56)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .onClick(() => {
            this.submitted = true;
          })

          // Success Message
          if (this.submitted) {
            Text('Request submitted successfully!')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.success)
              .width('100%')
              .padding(AppSpacing.lg)
              .backgroundColor('#264CAF50')
              .borderRadius(AppShapes.medium)
              .textAlign(TextAlign.Center)
          }
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}