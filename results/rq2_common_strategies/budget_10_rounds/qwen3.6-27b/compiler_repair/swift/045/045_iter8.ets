import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// 定义应用程序的颜色、排版、形状、间距和阴影规范

interface ColorToken {
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
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

interface SpacingToken {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ElevationLevel {
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMapping {
  level1: ElevationLevel;
  level2: ElevationLevel;
  level3: ElevationLevel;
}

class AppTokens {
  static Colors: ColorToken = {
    primary: '#FF8E6BF2',
    secondary: '#FFD3C1FF',
    tertiary: '#FFB39DDB',
    background: '#FFF5F3FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFECE6F8',
    outline: '#FFD1C4E9',
    success: '#FF4CAF50',
    warning: '#FFFFB300',
    error: '#FFE53935',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF2E1A47',
    onBackground: '#FF2E1A47',
    onSurface: '#FF2E1A47'
  };

  static TypographyTokens: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: ShapeToken = {
    small: 8.0,
    medium: 14.0,
    large: 20.0
  };

  static Spacing: SpacingToken = {
    sm: 6.0,
    md: 10.0,
    lg: 16.0,
    xl: 24.0
  };

  static ElevationMapping: ElevationMapping = {
    level1: { radius: 8.0, dy: 2.0, opacity: 0.18 },
    level2: { radius: 12.0, dy: 4.0, opacity: 0.22 },
    level3: { radius: 20.0, dy: 8.0, opacity: 0.26 }
  };
}

@Entry
@Component
struct RootScreen {
  @State orderId: string = '';
  @State issue: string = '';
  @State submitted: boolean = false;
  
  build() {
    Column() {
      Text('After-Sale Service')
        .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
        .fontColor(AppTokens.Colors.onBackground)
        .alignSelf(ItemAlign.Start)
        .width('100%')

      // Card Area
      Column({ space: AppTokens.Spacing.md }) {
        Text('Order ID')
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .fontColor(AppTokens.Colors.onSurface)
          .alignSelf(ItemAlign.Start)

        // Order ID Input
        Row() {
          TextInput({ placeholder: 'Enter order number' })
            .type(InputType.Number)
            .text(this.orderId)
            .onChange((value: string) => {
              this.orderId = value;
            })
            .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor(Color(AppTokens.Colors.onSurface).withOpacity(0.5))
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: this.orderId.length > 0 ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            .height(56)
            .width('100%')
        }
        .width('100%')

        Text('Issue Description')
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .fontColor(AppTokens.Colors.onSurface)
          .alignSelf(ItemAlign.Start)

        // Issue Description Input
        TextArea({ placeholder: 'Describe your issue' })
          .text(this.issue)
          .onChange((value: string) => {
            this.issue = value;
          })
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .fontColor(AppTokens.Colors.onSurface)
          .placeholderColor(Color(AppTokens.Colors.onSurface).withOpacity(0.5))
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .border({ width: 1, color: this.issue.length > 0 ? AppTokens.Colors.primary : AppTokens.Colors.outline })
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm + 4, bottom: AppTokens.Spacing.sm + 4 })
          .height(120)
          .width('100%')
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: Color(AppTokens.Colors.outline).withOpacity(AppTokens.ElevationMapping.level2.opacity),
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })

      // Submit Button
      Button('Submit Request')
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)
        .width('100%')
        .height(56)
        .onClick(() => {
          this.submitted = true;
        })

      // Success Message
      if (this.submitted) {
        Text('Request submitted successfully!')
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .fontColor(AppTokens.Colors.success)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(Color(AppTokens.Colors.success).withOpacity(0.15))
          .borderRadius(AppTokens.Shapes.medium)
      }

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}