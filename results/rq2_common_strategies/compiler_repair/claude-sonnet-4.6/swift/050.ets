import { promptAction } from '@kit.ArkUI';

// AppTokens - using classes instead of object literals
class ColorsClass {
  primary: string = '#1E3A8A';
  secondary: string = '#2563EB';
  tertiary: string = '#60A5FA';
  background: string = '#F5F8FF';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E8EEFA';
  outline: string = '#CBD5E1';
  success: string = '#16A34A';
  warning: string = '#F59E0B';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#FFFFFF';
  onTertiary: string = '#0B1220';
  onBackground: string = '#0B1220';
  onSurface: string = '#0B1220';
}

class SpacingClass {
  xs: number = 6;
  sm: number = 10;
  md: number = 14;
  lg: number = 18;
  xl: number = 26;
  xxl: number = 36;
}

class ShapesClass {
  smallCornerRadius: number = 8;
  mediumCornerRadius: number = 12;
  largeCornerRadius: number = 18;
}

const Colors = new ColorsClass();
const Spacing = new SpacingClass();
const Shapes = new ShapesClass();

@Entry
@Component
struct RootScreen {
  @State name: string = '';
  @State code: string = '';
  @State selectedSeat: number = 0;
  @State showDialog: boolean = false;

  seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  seatNumber(index: number): string {
    if (index === 0) return '23C';
    else if (index === 1) return '11A';
    else return '2F';
  }

  build() {
    Stack() {
      // Background gradient
      Column() {
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#3F99F8', 0.0],
          ['#F5F8FF', 0.5],
          ['#2563EB33', 1.0]
        ]
      })

      Column({ space: 0 }) {
        // Header
        Row() {
          Circle()
            .fill(Colors.primary)
            .width(22)
            .height(22)
            .margin({ left: Spacing.lg })

          Blank()

          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)

          Blank()

          Circle()
            .fill(Colors.secondary)
            .width(22)
            .height(22)
            .margin({ right: Spacing.lg })
        }
        .width('100%')
        .height(56)
        .margin({ bottom: Spacing.md })

        // Scrollable content
        Scroll() {
          Column({ space: Spacing.lg }) {

            // Passenger & Booking Card
            Column({ space: Spacing.lg }) {
              Text('Passenger')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              TextInput({ placeholder: 'Full name', text: this.name })
                .fontSize(14)
                .fontColor(Colors.onSurface)
                .placeholderColor('#888888')
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(Shapes.mediumCornerRadius)
                .border({ width: 1, color: Colors.outline, radius: Shapes.mediumCornerRadius })
                .padding(Spacing.md)
                .width('100%')
                .onChange((value: string) => {
                  this.name = value;
                })

              Text('Booking Code')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .fontSize(14)
                .fontColor(Colors.onSurface)
                .placeholderColor('#888888')
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(Shapes.mediumCornerRadius)
                .border({ width: 1, color: Colors.outline, radius: Shapes.mediumCornerRadius })
                .padding(Spacing.md)
                .width('100%')
                .onChange((value: string) => {
                  this.code = value;
                })

              Text('Seat Class')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              // Segmented Control
              Row({ space: 0 }) {
                ForEach(this.seatTabs, (label: string, index: number) => {
                  Button() {
                    Row({ space: Spacing.xs }) {
                      if (this.selectedSeat === index) {
                        Text('✓')
                          .fontSize(14)
                          .fontWeight(FontWeight.Bold)
                          .fontColor(Colors.onPrimary)
                      }
                      Text(label)
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.selectedSeat === index ? Colors.onPrimary : Colors.onSurface)
                    }
                    .justifyContent(FlexAlign.Center)
                    .alignItems(VerticalAlign.Center)
                  }
                  .type(ButtonType.Normal)
                  .backgroundColor(this.selectedSeat === index ? Colors.primary : Colors.surfaceVariant)
                  .borderRadius(index === 0
                    ? { topLeft: Shapes.mediumCornerRadius, bottomLeft: Shapes.mediumCornerRadius, topRight: 0, bottomRight: 0 }
                    : index === this.seatTabs.length - 1
                      ? { topLeft: 0, bottomLeft: 0, topRight: Shapes.mediumCornerRadius, bottomRight: Shapes.mediumCornerRadius }
                      : { topLeft: 0, bottomLeft: 0, topRight: 0, bottomRight: 0 })
                  .height(40)
                  .layoutWeight(1)
                  .onClick(() => {
                    this.selectedSeat = index;
                  })
                })
              }
              .width('100%')
              .border({ width: 1, color: Colors.outline, radius: Shapes.mediumCornerRadius })
            }
            .alignItems(HorizontalAlign.Start)
            .padding(Spacing.xl)
            .backgroundColor(Colors.surface)
            .borderRadius(Shapes.largeCornerRadius)
            .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
            .width('100%')

            // Flight Details Card
            Column({ space: Spacing.md }) {

              // Flight info row
              Row() {
                Column({ space: Spacing.xs }) {
                  Text('Flight')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text('BL 213 • HND → CTS')
                    .fontSize(14)
                    .fontColor(Colors.onSurface)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Circle()
                  .fill(Colors.secondary)
                  .width(36)
                  .height(36)
              }
              .width('100%')
              .padding(Spacing.md)
              .backgroundColor(Colors.surface)
              .borderRadius(Shapes.mediumCornerRadius)
              .border({ width: 1, color: Colors.outline, radius: Shapes.mediumCornerRadius })

              // Boarding / Gate / Seat row
              Row() {
                Column({ space: 2 }) {
                  Text('Boarding')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text('12:35')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.primary)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Column({ space: 2 }) {
                  Text('Gate')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text('A12')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.primary)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Column({ space: 2 }) {
                  Text('Seat')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text(this.seatNumber(this.selectedSeat))
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.primary)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .padding({ top: Spacing.md, bottom: Spacing.md })

              // Confirm button
              Button('Confirm Check-in')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onPrimary)
                .backgroundColor(Colors.primary)
                .borderRadius(Shapes.largeCornerRadius)
                .width('100%')
                .height(52)
                .onClick(() => {
                  this.showDialog = true;
                  promptAction.showDialog({
                    title: 'Check-in Successful',
                    message: 'Boarding pass is ready. Have a nice flight.',
                    buttons: [{ text: 'Done', color: Colors.primary }]
                  }).then(() => {
                    this.showDialog = false;
                  });
                })
            }
            .alignItems(HorizontalAlign.Start)
            .padding(Spacing.lg)
            .backgroundColor(Colors.surface)
            .borderRadius(Shapes.largeCornerRadius)
            .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
            .width('100%')

          }
          .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
          .width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}