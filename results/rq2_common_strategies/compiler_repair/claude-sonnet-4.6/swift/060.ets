// AppTokens Colors
class AppColors {
  primary: string = '#2563EB';
  secondary: string = '#38BDF8';
  tertiary: string = '#60A5FA';
  background: string = '#F8FAFC';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E2E8F0';
  outline: string = '#CBD5E1';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#0F172A';
  onTertiary: string = '#FFFFFF';
  onBackground: string = '#0F172A';
  onSurface: string = '#1E293B';
}

class AppTypography {
  displaySize: number = 24;
  headlineSize: number = 18;
  titleSize: number = 14;
  bodySize: number = 12;
}

class AppShapes {
  small: number = 6;
  medium: number = 10;
  large: number = 14;
}

class AppSpacing {
  sm: number = 6;
  md: number = 10;
  lg: number = 14;
  xl: number = 20;
  buttonContentHorizontal: number = 16;
  buttonContentVertical: number = 8;
}

const Colors = new AppColors();
const Typography = new AppTypography();
const Shapes = new AppShapes();
const Spacing = new AppSpacing();

@Component
struct MarkerBox {
  @Prop unit: string = '';
  @Prop value: string = '';
  @Prop active: boolean = false;

  build() {
    Row() {
      Column() {
        Text(this.unit)
          .fontSize(Typography.headlineSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .margin({ bottom: 4 })
        Text(this.value)
          .fontSize(Typography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height(80)
      .padding(Spacing.md)
    }
    .width('100%')
    .height(80)
    .backgroundColor(this.active ? '#4DB8F8' : Colors.surface)
    .borderRadius(Shapes.medium)
    .border({
      width: 1,
      color: Colors.outline,
      radius: Shapes.medium,
    })
  }
}

@Component
struct MapArea {
  @Prop selected: string = '';

  build() {
    Column({ space: Spacing.md }) {
      Text('Unit Map Visualization')
        .fontSize(Typography.headlineSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
      Text(`Active Unit: ${this.selected}`)
        .fontSize(Typography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(Colors.onSurface)
    }
    .width('100%')
    .height(240)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Colors.surfaceVariant)
    .borderRadius(Shapes.large)
    .border({
      width: 1,
      color: Colors.outline,
      radius: Shapes.large,
    })
    .margin({ left: Spacing.lg, right: Spacing.lg })
  }
}

@Component
struct UnitButton {
  @Prop label: string = '';
  @Prop isActive: boolean = false;
  onPress: () => void = () => {};

  build() {
    Button(this.label)
      .fontSize(Typography.titleSize)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isActive ? Colors.onPrimary : Colors.onSurface)
      .backgroundColor(this.isActive ? Colors.primary : Colors.surfaceVariant)
      .borderRadius(Shapes.small)
      .padding({
        left: Spacing.buttonContentHorizontal,
        right: Spacing.buttonContentHorizontal,
        top: Spacing.buttonContentVertical,
        bottom: Spacing.buttonContentVertical,
      })
      .onClick(() => {
        this.onPress();
      })
  }
}

@Entry
@Component
struct RootScreen {
  markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];
  @State active: string = 'Length';

  build() {
    Stack() {
      // Gradient background
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['#2638BDF8', 0.0],
            ['#262563EB', 1.0],
          ],
        })

      // Main content
      Scroll() {
        Column({ space: Spacing.lg }) {
          // Title
          Text('Unit Converter')
            .fontSize(Typography.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)
            .margin({ top: Spacing.lg })

          // Map Area
          MapArea({ selected: this.active })

          // Marker Boxes
          ForEach(this.markers, (marker: string) => {
            MarkerBox({
              unit: marker,
              value: 'Tap to convert',
              active: this.active === marker,
            })
          }, (marker: string) => marker)

          // Spacer
          Row()
            .height(Spacing.md)
            .width('100%')

          // Button Row
          Flex({
            direction: FlexDirection.Row,
            wrap: FlexWrap.Wrap,
            justifyContent: FlexAlign.Center,
            alignItems: ItemAlign.Center,
          }) {
            ForEach(this.markers, (marker: string) => {
              UnitButton({
                label: marker,
                isActive: this.active === marker,
                onPress: () => {
                  this.active = marker;
                },
              })
                .margin({
                  right: Spacing.md,
                  bottom: Spacing.sm,
                })
            }, (marker: string) => marker)
          }
          .width('100%')
          .margin({ bottom: Spacing.lg })
        }
        .width('100%')
        .padding({
          left: Spacing.lg,
          right: Spacing.lg,
          bottom: Spacing.lg,
        })
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}