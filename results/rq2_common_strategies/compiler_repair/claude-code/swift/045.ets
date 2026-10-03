@Entry
@Component
struct AfterSaleServicePage {
  @State orderId: string = '';
  @State issue: string = '';
  @State submitted: boolean = false;
  @State orderIdFocused: boolean = false;
  @State issueFocused: boolean = false;

  build() {
    Stack() {
      Column() {
        Column({ space: AppTokens.Spacing.lg }) {
          Text('After-Sale Service')
            .font({
              size: AppTokens.TypographyTokens.displaySize,
              weight: AppTokens.TypographyTokens.displayWeight
            })
            .fontColor(AppTokens.Colors.onBackground)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Card area
          Column() {
            Column({ space: AppTokens.Spacing.md }) {
              Text('Order ID')
                .font({
                  size: AppTokens.TypographyTokens.titleSize,
                  weight: AppTokens.TypographyTokens.titleWeight
                })
                .fontColor(AppTokens.Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              // Order ID input
              Stack({ alignContent: Alignment.TopStart }) {
                if (this.orderId === '' && !this.orderIdFocused) {
                  Text('Enter order number')
                    .font({
                      size: AppTokens.TypographyTokens.bodySize,
                      weight: AppTokens.TypographyTokens.bodyWeight
                    })
                    .fontColor(AppTokens.Colors.onSurface + '80')
                    .padding({
                      left: AppTokens.Spacing.md,
                      right: AppTokens.Spacing.md
                    })
                    .margin({ top: (56 - AppTokens.TypographyTokens.bodySize) / 2 })
                }
                TextInput({ text: this.orderId, placeholder: '' })
                  .fontSize(AppTokens.TypographyTokens.bodySize)
                  .fontWeight(AppTokens.TypographyTokens.bodyWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .backgroundColor(Color.Transparent)
                  .padding({
                    left: AppTokens.Spacing.md,
                    right: AppTokens.Spacing.md
                  })
                  .height(56)
                  .width('100%')
                  .onChange((value: string) => {
                    this.orderId = value;
                  })
                  .onFocus(() => {
                    this.orderIdFocused = true;
                  })
                  .onBlur(() => {
                    this.orderIdFocused = false;
                  })
              }
              .width('100%')
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .border({
                width: 1,
                color: this.orderIdFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline
              })

              Text('Issue Description')
                .font({
                  size: AppTokens.TypographyTokens.titleSize,
                  weight: AppTokens.TypographyTokens.titleWeight
                })
                .fontColor(AppTokens.Colors.onSurface)
                .alignSelf(ItemAlign.Start)
                .margin({ top: AppTokens.Spacing.md })

              // Issue Description input
              Stack({ alignContent: Alignment.TopStart }) {
                if (this.issue === '' && !this.issueFocused) {
                  Text('Describe your issue')
                    .font({
                      size: AppTokens.TypographyTokens.bodySize,
                      weight: AppTokens.TypographyTokens.bodyWeight
                    })
                    .fontColor(AppTokens.Colors.onSurface + '80')
                    .padding({
                      left: AppTokens.Spacing.md,
                      right: AppTokens.Spacing.md,
                      top: AppTokens.Spacing.sm + 4,
                      bottom: AppTokens.Spacing.sm + 4
                    })
                }
                TextArea({ text: this.issue, placeholder: '' })
                  .fontSize(AppTokens.TypographyTokens.bodySize)
                  .fontWeight(AppTokens.TypographyTokens.bodyWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .backgroundColor(Color.Transparent)
                  .padding({
                    left: AppTokens.Spacing.md,
                    right: AppTokens.Spacing.md,
                    top: AppTokens.Spacing.sm + 4,
                    bottom: AppTokens.Spacing.sm + 4
                  })
                  .height(120)
                  .width('100%')
                  .onChange((value: string) => {
                    this.issue = value;
                  })
                  .onFocus(() => {
                    this.issueFocused = true;
                  })
                  .onBlur(() => {
                    this.issueFocused = false;
                  })
              }
              .width('100%')
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .border({
                width: 1,
                color: this.issueFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline
              })
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
          }
          .width('100%')
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: AppTokens.Colors.outline + toHexOpacity(AppTokens.ElevationMapping.level2.opacity),
            offsetY: AppTokens.ElevationMapping.level2.dy
          })

          // Submit button
          Button('Submit Request')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(56)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.large)
            .onClick(() => {
              this.submitted = true;
            })

          // Success message
          if (this.submitted) {
            Text('Request submitted successfully!')
              .font({
                size: AppTokens.TypographyTokens.bodySize,
                weight: AppTokens.TypographyTokens.bodyWeight
              })
              .fontColor(AppTokens.Colors.success)
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .textAlign(TextAlign.Center)
              .backgroundColor(AppTokens.Colors.success + '26')
              .borderRadius(AppTokens.Shapes.medium)
          }

          Blank()
        }
        .width('100%')
        .height('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

function toHexOpacity(opacity: number): string {
  const val = Math.round(opacity * 255);
  const hex = val.toString(16).padStart(2, '0').toUpperCase();
  return hex;
}

namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#FF8E6BF2';
    export const secondary: ResourceColor = '#FFD3C1FF';
    export const tertiary: ResourceColor = '#FFB39DDB';
    export const background: ResourceColor = '#FFF5F3FF';
    export const surface: ResourceColor = '#FFFFFFFF';
    export const surfaceVariant: ResourceColor = '#FFECE6F8';
    export const outline: ResourceColor = '#FFD1C4E9';
    export const success: ResourceColor = '#FF4CAF50';
    export const warning: ResourceColor = '#FFFFB300';
    export const error: ResourceColor = '#FFE53935';
    export const onPrimary: ResourceColor = '#FFFFFFFF';
    export const onSecondary: ResourceColor = '#FF2E1A47';
    export const onBackground: ResourceColor = '#FF2E1A47';
    export const onSurface: ResourceColor = '#FF2E1A47';
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28;
    export const displayWeight: FontWeight = FontWeight.Bold;
    export const titleSize: number = 18;
    export const titleWeight: FontWeight = FontWeight.Medium;
    export const bodySize: number = 14;
    export const bodyWeight: FontWeight = FontWeight.Normal;
    export const labelSize: number = 12;
    export const labelWeight: FontWeight = FontWeight.Medium;
  }

  export namespace Shapes {
    export const small: number = 8;
    export const medium: number = 14;
    export const large: number = 20;
  }

  export namespace Spacing {
    export const sm: number = 6;
    export const md: number = 10;
    export const lg: number = 16;
    export const xl: number = 24;
  }

  export interface ShadowSpec {
    elevation: number;
    radius: number;
    dy: number;
    opacity: number;
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = { elevation: 4, radius: 8, dy: 2, opacity: 0.18 };
    export const level2: ShadowSpec = { elevation: 8, radius: 12, dy: 4, opacity: 0.22 };
    export const level3: ShadowSpec = { elevation: 12, radius: 20, dy: 8, opacity: 0.26 };
  }
}
