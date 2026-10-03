@Entry
@Component
struct Index {
  @State pins: PinItem[] = []

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Retro Group Buy')
          .width('100%')
          .textAlign(TextAlign.Start)
          .fontColor('#3E2723')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)

        Column() {
          Text('Live Deals Map')
            .fontColor('#3E2723')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          Stack() {
            Canvas().padding(8)
          }
          .width('100%')
          .height(220)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
        }
        .alignItems(HorizontalAlign.Start)
        .space(AppTokens.Spacing.md)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })

        Blank().height(4)

        Row({ space: AppTokens.Spacing.md }) {
          Button() {
            Text('Add Group')
              .clipShape(RoundedRectangle())
              .backgroundColor('#FFC107')
              .height(48)
              .width('100%')
              .fontColor('#3E2723')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)

          Button() {
            Text('Clear')
              .clipShape(RoundedRectangle())
              .backgroundColor('#FF8C00')
              .height(48)
              .width('100%')
              .fontColor('#3E2723')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
        }

        Column() {
          Text('Active Groups')
            .fontColor('#FF8C00')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          ForEach(this.pins, (pin: PinItem) => {
            Row() {
              Text(pin.label)
                .fontColor('#3E2723')
                .fontSize(14)
              Blank()
              Circle()
                .width(14)
                .height(14)
                .fill('#FF8C00')
            }
          })
        }
        .alignItems(HorizontalAlign.Start)
        .space(AppTokens.Spacing.sm)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

interface PinItem {
  label: string
  x: number
  y: number
}

const AppTokens: AppTokensInterface = {
  Spacing: {
    sm: 4,
    md: 8,
    lg: 16
  },
  Colors: {
    onBackground: '#3E2723',
    surface: '#FFFFFF',
    surfaceVariant: '#F5F5F5',
    secondary: '#FFC107',
    primary: '#FF8C00'
  },
  Shapes: {
    medium: 8,
    large: 16
  }
}

interface SpacingConfig {
  sm: number;
  md: number;
  lg: number;
}

interface ColorConfig {
  onBackground: string;
  surface: string;
  surfaceVariant: string;
  secondary: string;
  primary: string;
}

interface ShapeConfig {
  medium: number;
  large: number;
}

interface AppTokensInterface {
  Spacing: SpacingConfig;
  Colors: ColorConfig;
  Shapes: ShapeConfig;
}